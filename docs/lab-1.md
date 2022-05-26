<div class="prose lg:prose-lg max-w-none">
    <h1>HOL1131: Optimization with Windows file share (SMB) Demo</h1>
    <h3>Introduction</h3>
    <p>This exercise introduces the user interface and effectiveness of WAN optimization using Riverbed Optimization
        System, RiOS.</p>
    <h3>Overview</h3>
    <p>In this exercise you will monitor and record transfer times of traffic you generate to witness optimization
        efficacy. This eLab is designed for you to gain working knowledge of some basic SteelHead concepts and
        optimization effects, and presumes little to no familiarity with the SteelHead UI.</p>
    <p>The network environment has two sites:</p>
    <table>
        <thead>
            <tr>
                <th></th>
                <th>Host</th>
                <th>SteelHead</th>
                <th>City</th>
                <th>Site</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Branch Office</td>
                <td>n21-win10</td>
                <td>n120-sh1</td>
                <td>San Francisco, California</td>
                <td>Site A</td>
            </tr>
            <tr>
                <td>Datacenter</td>
                <td>n31-svr</td>
                <td>n130-sh1</td>
                <td>Ashburn, Virginia</td>
                <td>Site B</td>
            </tr>
        </tbody>
    </table>
    <ul>
        <li>These sites are connected by a WAN with approximately <strong>70ms latency, 1.5Mbit/sec, and 0.5%
                loss</strong>.</li>
    </ul>
    <p>The SteelHead virtual appliances in this scenario are pre-configured, to allow your focus to be on the effects of
        optimization and benefits to user experience.</p>
    <h4>More information on topics covered in this exercise can be found here:</h4>
    <ul>
        <li>SteelHead CX Installation and Configuration Guide
            <ul>
                <li>Chapter 3, Installing and Configuring the SteelHead</li>
                <li>Chapter 4, Troubleshooting</li>
            </ul>
        </li>
        <li>SteelHead Deployment Guide
            <ul>
                <li>Chapter 3, WAN Visibility Modes</li>
                <li>Chapter 9, Physical In-Path Deployments</li>
            </ul>
        </li>
        <li>SteelHead Deployment Guide - Protocols
            <ul>
                <li>Chapter 1, CIFS Optimization</li>
                <li>Chapter 3, Signed SMB and Encrypted MAPI Optimization</li>
            </ul>
        </li>
    </ul>
    <h4>Lab Objectives</h4>
    <ol>
        <li>Map a Network Drive and Experience Non-optimized Environment</li>
        <li>Allow optimization using in-path rules</li>
        <li>Create optimized transfers and verify them</li>
        <li>Create reports on the effects of optimization</li>
    </ol>
    <hr>
    <h3>Task 1. Map a Network Drive and Experience Non-optimized Environment</h3>
    <p>Map a network drive from your Windows Client PC to a Windows file share on the server in the datacenter, then
        select a file and time how long it takes to copy across the WAN.</p>
    <ul>
        <li>
            <p>Due to SMB/Kerberos requirements, we will spend most of this exercise leveraging Remote Desktop Protocol,
                RDP, into a domain-joined Windows 10 PC, <code>n21-win10</code>.</p>
        </li>
        <li>
            <p>Recall the SteelHeads have been pre-configured, and for this task the optimization capability - which
                normally is automatically enabled - has been disabled. You will be re-enabling optimization in the next
                task.</p>
        </li>
    </ul>
    <ol>
        <li>
            <p>From the taskbar, launch RDP (the icon looking like a computer screen) to make a connection to
                <code>n21-win10</code>, using credentials <code>LAB\elabstudent</code> and <code>myeLab!</code> This
                places you as a user in the domain <strong>lab.local</strong>
            </p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/1680fe8e-7b25-4a8b-ac6b-33722197eaa1.png"
                    alt="screenshot"
                    title="RDP connection screen, either edit to add credentials, or continue and you will be promoted">
            </p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/9ef75863-a0cc-48c1-9a23-3d5045343a51.png"
                    alt="screenshot" title="Domain logon"></p>
        </li>
        <li>
            <p>On the <code>n21-win10</code> client PC, open the File Explorer, click on <code>This PC</code> and select
                the Computer tab at the top of the window. From the <em>Map Network Drive</em> pop-up window, map the
                Network drive <code>\\share.lab.local\public</code></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/48eac836-da0c-4aaa-8ca9-b44d2f17842f.png"
                    alt="screenshot" title="Map a network drive to n31-svr\public"></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/cf6a2355-0dfd-4c8f-9b9a-6343b2047b9a.png"
                    alt="screenshot" title="Map Network Drive"></p>
        </li>
        <li>
            <p>As the directory names suggest, there are many file types available, but for now navigate to the
                <strong>Presentations</strong> folder and select a file larger than roughly 10MB.
            </p>
        </li>
    </ol>
    <ul>
        <li>
            <p>We will use the file <strong>BoogieWoogieBugleBoy.ppt</strong> for our example.</p>
        </li>
        <li>
            <p>It does not matter which file you select, but make a note of yours so you can repeat the same transfer
                later in a like-for-like comparison <em>with</em> optimization.</p>
        </li>
    </ul>
    <ol start="4">
        <li>With a stopwatch ready (your watch or phone or the Clock widget at lower-right of the n21-win10 desktop
            would work) copy the file and make note of how long the transfer takes.</li>
    </ol>
    <ul>
        <li>Once the copy is completed and you've noted the transfer time, let's see how the SteelHead reports on this
            connection.</li>
    </ul>
    <ol start="5">
        <li>
            <p>Start Firefox and use the provided shortcut, <strong>Site A - Branch &gt; Optimization &gt; n120-sh1
                    SteelHead (Path 1)</strong>, to access <code>n120-sh1</code>; logon with credentials <em>admin</em>
                :: <em>password</em>.</p>
        </li>
        <li>
            <p>On the <code>n120-sh1</code> UI, navigate to <strong>Reports &gt; Networking: Current
                    Connections</strong></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/334ac469-d7cf-4e17-855f-e38cf1c090c0.png"
                    alt="screenshot" title="Screenshot - SH Current Connections - Passthrough of 10.1.31.120:445"></p>
            <ul>
                <li>
                    <p>You should see a connection with:</p>
                    <ul>
                        <li>
                            <p>"Destination:Port" = 10.1.31.120:445</p>
                        </li>
                        <li>
                            <p>"Connection Type" = grey arrow (which the legend shows us is an "Intentional"
                                pass-through)</p>
                        </li>
                        <li>
                            <p>"Passthrough reason" = In-path rule</p>
                        </li>
                    </ul>
                </li>
                <li>
                    <p>To see details of the connection you press the gray "Show details" triangle on the left.</p>
                </li>
                <li>
                    <p>The "Passthrough reason: In-path rule" tells us this client-side SteelHead is passing the
                        connection through <em>because</em> it has been administratively informed to do so. That's the
                        purpose of an in-path rule: Us telling the SteelHead whether it should attempt to optimize (or
                        not, as in this case), and if so, how to do so.</p>
                </li>
            </ul>
        </li>
        <li>
            <p>Still on <code>n120-sh1</code>, head to <strong>Reports &gt; Networking: WAN Throughput</strong></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/0162e6d4-cb20-4457-b6c5-f8b67ece5052.png"
                    alt="screenshot" title="Screenshot - SteelHead WAN Throughput"></p>
            <ul>
                <li>
                    <p>Click on the <strong>5m</strong> Time Selector (or "1h" if it's been longer than 5 minutes since
                        you copied the file over) to 'zoom in' to the best resolution view of your transfer</p>
                </li>
                <li>
                    <p>Note the x-axis of the graph provides an indication of how long your transfer took. This works
                        splendid in our Lab, with only our one connection to view, but on a SteelHead carrying
                        production traffic with hundreds or thousands of optimized connections, isolating a single
                        transfer on this report is not possible.</p>
                </li>
            </ul>
        </li>
        <li>
            <p>Now that you've experienced an unoptimized transfer, and been informed why it is not being optimized,
                return to the <strong>File Manager</strong> app, right click on the <code>\\n31-svr\public</code> shared
                drive and disconnect it.</p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/4310e0fd-de6e-4f81-90b1-2cdcddc61368.png"
                    alt="screenshot" title="Screenshot - n21-win10, Drive disconnection"></p>
        </li>
    </ol>
    <ul>
        <li>
            <p><strong>Worthy of Note:</strong> We disconnect the drive now because SteelHeads do not <em>start</em>
                optimizing existing/pre-existing connections. A SteelHead will not attempt to initiate optimization of
                connections it has not seen the SYN message for; will simply pass them through.</p>
        </li>
        <li>
            <p>After we re-enable optimization on the SteelHead, we will re-map the drive so the SteelHead can see the
                very beginning of the connection and attempt to optimize it.</p>
        </li>
        <li>
            <p>In other words, SteelHeads identify the SYN packet of each connection to evaluate if optimization should
                occur, or if the SYN packet - and all subsequent packets for the connection - should be passed through
                without optimization.</p>
        </li>
    </ul>
    <blockquote>
        <p>Having a baseline of 'performance without optimization', we can compare this to the transfer time of
            subsequent optimized transfers.</p>
    </blockquote>
    <hr>
    <h3>Task 2. Allow optimization using in-path rules</h3>
    <p>You will first 're-enable' optimization on the branch SteelHead, <code>n120-sh1</code> by adjusting the in-path
        rules.</p>
    <ol>
        <li>
            <p>On <code>n120-sh1</code>, navigate to <strong>&gt; Optimization &gt; Network Services: In-Path
                    Rules</strong>.</p>
            <ul>
                <li>SCAN the in-path rules to see at a high level what they do:</li>
            </ul>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/52e45df9-18dd-424d-bdab-770488dd6da8.png"
                    alt="screenshot"
                    title="Screenshot - SteelHead In-path Rules, noting Type, Source &amp; Destination, and Rule #"></p>
            <p>Identified Columns:</p>
            <ol>
                <li>
                    <p>Type = "Pass Through" or "Auto Discover"</p>
                </li>
                <li>
                    <p>Source &amp; Destination = IP Addresses on the SYN Packet being evaluated for optimization.</p>
                </li>
                <li>
                    <p>Rule # = Hierarchic order; rules evaluated top to bottom like access control list (ACL).</p>
                    <ul>
                        <li>
                            <p>One Rule to note is "default", whose purpose is to attempt to optimize, via
                                auto-discovery, any new TCP connection not passed through by above rules.</p>
                        </li>
                        <li>
                            <p>This "default" rule cannot be deleted, effectively causing SteelHeads to behave in a
                                "blacklist" manner, where every TCP connection has optimization attempted
                                <em>except</em> those explicitly passed through, or blacklisted, via previously
                                evaluated in-path rules.
                            </p>
                        </li>
                    </ul>
                </li>
            </ol>
        </li>
        <li>
            <p>To re-configure this SteelHead to attempt optimization, you are welcome to either:</p>
            <ul>
                <li>
                    <p><strong>Disable the rule</strong> by clicking on the twisty next to the rule number, scroll down
                        and uncheck <code>Enable Rule</code>, and click <strong>Apply</strong>, or</p>
                </li>
                <li>
                    <p><strong>Delete this first rule</strong> by ticking it's checkbox on the far left and clicking
                        <strong>Remove Selected Rules</strong>
                    </p>
                </li>
            </ul>
            <blockquote>
                <p>Your SteelHead will now attempt to optimize all LAN-to-WAN TCP traffic not matching the remaining,
                    default pass-through rules.</p>
            </blockquote>
        </li>
    </ol>
    <hr>
    <h3>Task 3. Create optimized connections and verify them.</h3>
    <p>You will now re-map the network drive as you did in Task 1. This time however, the SteelHeads will create an
        optimized session using, as you may have noticed in the bottom-most <code>default</code> in-path Rule, Auto
        Discovery. You will then verify optimization status.</p>
    <ol>
        <li>
            <p>Re-map the network drive <code>\\share.lab.local\public</code> on <code>n21-win10</code></p>
            <ul>
                <li>In the <strong>File Explorer</strong> window, select <code>This PC</code> and the <em>Computer</em>
                    tab at the top, and either re-type the URL or use the drop-down, which should have the address
                    cached.</li>
            </ul>
        </li>
        <li>
            <p>Now, on <code>n120-sh1</code> GUI, return to <strong>Reports &gt; Networking: Current
                    Connections</strong> to see the connection in an optimized state. Should your connection not be
                optimized... this is a perfect opportunity to review the above and your course material to determine
                why!</p>
            <ul>
                <li>
                    <p>In a live environment you may well see tens of thousands of connections or more, so take a moment
                        to review your options for filtering on this page.</p>
                </li>
                <li>
                    <p>Note also, on your optimized connection you should see the version of SMB currently in use, and
                        the <em>Username</em>, which is populated from the Active Directory integration.</p>
                </li>
            </ul>
            <blockquote>
                <p><strong>Knowledge check:</strong></p>
            </blockquote>
            <ul>
                <li>
                    <p>In the view below, what informs the connection is optimized?</p>
                </li>
                <li>
                    <p>In the view below, what informs the connection is encrypted over the WAN?</p>
                    <ul>
                        <li>Hint: hovering icons in your Current Connections screen can answer both questions...</li>
                    </ul>
                    <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/e2d0e34c-6b1d-4f81-8289-a60e864da07f.png"
                            alt="screenshot" title="Current Connections Report"></p>
                </li>
            </ul>
        </li>
        <li>
            <p>Knowing your connection is optimized, and with your stopwatch at the ready, use <strong>File
                    Manager</strong> to repeat the transfer of the same file you used before, and time how long it
                takes.</p>
            <ul>
                <li>
                    <p>Since the byte patterns of this file is being seen/optimized for the first time by these two
                        SteelHeads, this is a “cold” transfer.</p>
                </li>
                <li>
                    <p>Whether the end user notices a significant speed improvement or not, the data segments are being
                        segmented/'learned' by both SteelHeads and stored to allow future “warm” transfers when the same
                        patterns are passed between these two SteelHeads again.</p>
                </li>
            </ul>
            <blockquote>
                <p>During the file transfer, on the File Manager transfer pop-up you can expand the caret in the bottom
                    left corner to view more details.</p>
            </blockquote>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/c56cd34e-ca02-4daf-9f55-fc1309b16c99.png"
                    alt="screenshot" title="Screenshot - n21-win10 File Manager view of Cold Transfer"></p>
            <blockquote>
                <p>With transfer finished, compare this "cold" transfer time with the "unoptimized" transfer time.</p>
            </blockquote>
            <ul>
                <li>
                    <p>Keep in mind that bandwidth reduction benefits are more tangible to Users over slower or
                        oversubscribed WAN links. It is <em>latency reduction</em> which Users feel the most, which
                        SteelHeads usually impact most with their Application-layer optimization. However, less
                        bandwidth used is also a perspective; for instance:</p>
                    <ul>
                        <li>
                            <p>Tell a User they consumed 60% less bandwidth and they'll say "So what."</p>
                        </li>
                        <li>
                            <p>Tell a Network Admin or CFO their data circuits are 60% less utilized, and they'll say
                                "Amazing!"</p>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li>
            <p>Let's move on to the "warm" transfer... start by deleting the local copy of your file on
                <code>n21-win10</code>, then raise your stopwatch and repeat the transfer once more - but you will have
                to be quick!
            </p>
        </li>
    </ol>
    <ul>
        <li>Calculate the approximate speed for the SMB file transfers, cold and warm. How do they compare to the
            previous non optimized transfer?</li>
    </ul>
    <blockquote>
        <p>Take some time to experiment</p>
    </blockquote>
    <ul>
        <li>
            <p>Try changing a PowerPoint document and saving it as another file, then passing it back to the server.</p>
        </li>
        <li>
            <p>Try doing the same with different file types. For instance,</p>
            <ul>
                <li>
                    <p>Drag 'n drop the whole <strong>Databases</strong> folder (which contains ~3Mb of database files)
                        to the <code>n21-win10</code> - <code>Downloads</code> folder.</p>
                    <ul>
                        <li>Pause a few moments, then go into the <code>\\share.lab.local\public\High-Res Images</code>
                            folder and copy "wallpaper-1985738.png" (also roughly 3Mb, but one file),</li>
                    </ul>
                </li>
            </ul>
            <ul>
                <li>
                    <p>On <code>n130-sh1</code> navigate to <strong>Reports &gt; Optimization &gt; Optimized
                            Throughput</strong> and compare the LAN and WAN impact of those two transfers.</p>
                    <ul>
                        <li>You should be able to discern the 3Mb of database traffic impacted the WAN &amp; LAN less,
                            and perhaps even took a bit less time, than the 3Mb picture file.</li>
                    </ul>
                </li>
            </ul>
            <blockquote>
                <p><strong>Knowledge Check:</strong></p>
            </blockquote>
            <ul>
                <li>Why would the optimization effects differ on a "cold pass" of one type of data/traffic versus
                    another?</li>
            </ul>
        </li>
    </ul>
    <ol start="5">
        <li>
            <p>We can now use the SCC in the data center to generate some HTTP traffic. Open a tab in Firefox and browse
                to <code>http://10.1.31.50</code> and logon with <strong>admin</strong> and <strong>password</strong>.
            </p>
            <ul>
                <li>
                    <p>Click around the menus just to generate traffic.</p>
                </li>
                <li>
                    <p>Then, open another tab and navigate to <code>https://10.1.31.50</code>. (accept the security risk
                        in this Lab environment)</p>
                </li>
            </ul>
        </li>
        <li>
            <p>On <code>n120-sh1</code>, view the Current Connection details to compare the two connections to
                <code>n31-scc</code>.
            </p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/8319d181-4fcc-48fe-b4c3-8903334c3369.png"
                    alt="screenshot"
                    title="Screenshot - SH Current Connections - Optimized &amp; Passthrough to n31-scc"></p>
            <ul>
                <li>
                    <p>Both access techniques <em>can</em> be optimized, but in this case SSL optimization is not
                        configured so, per default behavior, <code>tcp/443</code> traffic will be passed through; HTTP
                        is optimized by default.</p>
                </li>
                <li>
                    <p>For an advanced concept, navigate to the Current Connections page of <code>n130-sh1</code> and
                        compare the pass-through reason for the tcp/443 connection. This may help highlight the
                        perspective a server-side SteelHead has on connections, versus a client-side SteelHead.</p>
                </li>
            </ul>
        </li>
    </ol>
    <hr>
    <h3>Task 4. Create reports on the effects of optimization</h3>
    <p>You will view reports showing WAN traffic reduction aspects of your previous transfers. You can also:</p>
    <ul>
        <li>
            <p>Check on the SteelHead's peer table and look at the DataStore status,</p>
        </li>
        <li>
            <p>View the LAN throughput, a most important statistic as this is where the user experience lies. LAN
                throughput increase is due to a combination of WAN data reduction (usually to a lesser degree), and TCP
                &amp; Application layer RTT optimizations (often the major contributor).</p>
        </li>
    </ul>
    <ol>
        <li>Let's check out the server-side SteelHead perspective.</li>
    </ol>
    <ul>
        <li>
            <p>Create a new browser tab if necessary to open the <code>n130-sh1</code> GUI, and navigate to
                <strong>Reports &gt; Networking &gt; Traffic Summary</strong>
            </p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/565072d2-ef0a-49c1-9ba1-8bb9dd7a6276.png"
                    alt="screenshot" title="Screenshot - SteelHead Traffic Summary report"></p>
            <p>Notice the filtering defaults of <strong>Period: 1 Month</strong> and <strong>Traffic: Optimized
                    traffic</strong>. Change them to <strong>5 minutes</strong> <em>(or "Last Hour" if necessary)</em>
                and <strong>Both</strong>, respectively</p>
        </li>
        <li>
            <p>What percentage of the total traffic was optimized?</p>
        </li>
        <li>
            <p>What percentage of that traversed the WAN?</p>
        </li>
        <li>
            <p>Also notice you can sort your metric of choice by clicking on the respective column header; helps quickly
                identify outliers of interest. In many cases we are more interested in what is not going so well; for
                instance when you see a port with substantial amounts of optimized traffic yet with no reduction, that
                port is likely to be carrying encrypted traffic. Your choices in this specific case include:</p>
            <p>a) Identify the traffic and either decrypt it somehow, or switch off encryption. (obviously requires
                dialog with the application owner)</p>
            <p>b) Pass it through, if decryption/non-encryption is not an option and TCP optimizations are not a
                tangible timesaver (would require testing to validate).</p>
            <p>It may be better to pass through that which cannot be optimized, to preserve resource for that which can.
                And if we cannot make it slimmer and/or faster, we can easily pass it through. (a consideration for
                substantial-throughput connections; usually a non-issue for smaller connections)</p>
        </li>
    </ul>
    <ol start="2">
        <li>
            <p>Now view the <strong>Reports &gt; Optimization &gt; Optimized Throughput</strong> report. Notice in the
                Controls panel on the right-hand side your Time Selection options, which include typing into the time
                field, choosing one of the presets, or using the time control scroller bar at the bottom of the chart.
                Notice also, below the Time selection area, that this report allows you to choose a single port of
                interest or All, and you can view or omit the LAN, WAN, Peaks and Averages chart presentations by
                unchecking them.</p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/fac0a43f-9173-458e-b0fd-3626e919249c.png"
                    alt="screenshot" title="Screenshot - SteelHead Optimized Throughput"></p>
            <ul>
                <li>
                    <p>What was the peak LAN throughput in your timescale for HTTPS traffic?</p>
                </li>
                <li>
                    <p>What was it for HTTP and SMB?</p>
                </li>
            </ul>
            <p>It should be noted that for optimized traffic originating on port 445, SteelHead reporting refers
                uniquely to the different SMB versions, options and dialects. For example, SteelHeads report on
                SMB3-signed traffic as port 8782. The "real" port number on the connections (as Hosts on the outer
                channels see it) remains 445. The Current Connections report shows which connection is using which SMB
                type, and Filtering allows isolating to a particular protocol if desired.</p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/78a68bf1-6b80-4e5f-a8ee-e010b5932b8f.png"
                    alt="screenshot" title="Screenshot - SteelHead Current Connections"></p>
        </li>
        <li>
            <p>Run a report on <strong>Reports &gt; Optimization &gt; Bandwidth Optimization</strong></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/19b46e72-1d55-4d32-93a9-1412576a0ed1.png"
                    alt="screenshot" title="Screenshot - SteelHead Bandwidth Optimization"></p>
            <p>Note the scale on the Y axis of the chart is automatically adjusted to suit. Hover the mouse over the
                plot area to display the Data Reduction for various points on the timeline. Note that the LAN Throughput
                should be greater than WAN Throughput to imply optimization occurring and reducing the amount of
                throughput on the WAN.</p>
            <blockquote>
                <p>What was the peak LAN throughput?</p>
                <p>When did it happen?</p>
                <p>What protocol was it?</p>
                <p>What was the total amount of data that was removed from the WAN during your time period?</p>
            </blockquote>
        </li>
        <li>
            <p>Run a report on <strong>Reports &gt; Optimization &gt; Data Store Status</strong></p>
            <p><img src="https://riverbedlab.s3.us-west-2.amazonaws.com/screenshots/bebf5a46-839f-407a-8c21-1f949b563804.png"
                    alt="screenshot" title="Screenshot - SteelHead Data Store Status"></p>
            <blockquote>
                <p>Note the percentage of the data store have you used.</p>
                <p>What will happen when it becomes 100% full?</p>
            </blockquote>
        </li>
    </ol>
    <hr>
    <h3>End of Scenario</h3>
    <p>You have successfully created optimized traffic in an in-path deployment, and should understand the nature of
        cold and warm file transfers. Ideally you noticed significant improvement in transfer times, even with file
        modifications.</p>
    <p><strong>Useful add-on:</strong> SDR is protocol agnostic, so the warm transfer of a byte stream in one
        application will be equally optimized should that byte stream occur in a different applications. As an example,
        downloading a file from the datacenter via a file share, then sending the file via email; your local and
        datacenter SteelHeads will see the file 'cold' when downloading, then 'warm' when that same file is attached to
        an email.</p>
    <p>Finally, you verified various optimization statistics in different Reports. Good to note that bandwidth
        reduction/optimization is enabled by default for all TCP ports not explicitly passed through. Once your
        SteelHead appliance is plugged in and configured with the initial network settings, you can begin optimizing
        traffic and notice significant performance increase, with accompanying WAN data reduction.</p>
</div>
