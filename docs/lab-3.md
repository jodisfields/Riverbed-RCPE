<div id="rdpGuide" role="tabpanel" class="tab-pane markdown-output active">
<h1>HOL1192: Analyzing Auto Discovery Packets</h1>
<h3>Introduction</h3>
<p>In this scenario, you will be using Wireshark to analyze TCP dump captures created by the SteelHead appliance to
observe the Enhanced Auto Discovery (EAD) process.</p>
<p>In upcoming tasks, you will be establishing a new TCP connection to the shared server, initiating the Enhanced
Auto Discovery (EAD) process.</p>
<h4>Background Information</h4>
<p>TCP Dump is a free and open source <strong>packet capture tool</strong> that runs from both the SteelHead CLI and
the Management Console. It allows network administrators to intercept (capture) TCP/IP and other packets being
transmitted or received over networks. TCP Dump was originally written in 1987 by Van Jacobson, Craig Leres and
Steven McCanne who were, at the time, working in the <strong>Lawrence Berkeley Laboratory</strong> Network
Research Group. Steven McCanne, Ph.D., went on to co-found Riverbed Technology in May 2002 and served as
Riverbed's first CTO. TCP Dump is commonly used in conjunction with <strong>Wireshark</strong> to analyze
network behavior, performance and applications that generate or receive network traffic. TCP Dump is also useful
for analyzing network routing infrastructure and providing crucial traffic flow visibility, allowing network
engineers to isolate and resolve complex problems.</p>
<p><strong>Wireshark</strong> (originally named <strong>Ethereal</strong>) is a free and open-source <strong>packet
capture and analyzer tool</strong> and is used for network troubleshooting, analysis, software and
communications protocol development, and education. In the late 1990s, Gerald Combs, a computer science graduate
of the University of Missouri–Kansas City, began writing Ethereal and released the first version around 1998.
Combs, in 2006, accepted a job with <strong>CACE</strong> Technologies to continue development of the product,
and subsequently changed its name from Ethereal to <strong>Wireshark</strong>. In 2010, <strong>Riverbed
Technology</strong> acquired CACE and took over as the primary sponsor of Wireshark. <strong>Gerald Combs is
the Director of Open Source Projects</strong> at Riverbed and lead developer in the Wireshark development
team.</p>
<h4>Tasks</h4>
<ol>
<li>Configure TCP Dump on SteelHead Appliance</li>
<li>Generate Traffic to Capture Enhanced Auto Discovery (EAD) Probes</li>
<li>Download TCP Dump Capture Files from the SteelHead</li>
<li>Use Wireshark to Analyze TCP Dump Capture File</li>
<li>Change Inner Channel Transparency Mode to Full Transparency</li>
<li>Configure and Start a New TCP Dump</li>
<li>Use Wireshark to Analyze the New Capture File</li>
</ol>
<hr>
<h3>Task 1. Configure TCP Dump on SteelHead Appliance</h3>
<h4>Objective</h4>
<p>In this task, you will be creating a new TCP Dump capture job on the <strong>branch</strong> SteelHead appliance,
<strong>n120-sh1</strong>.
</p>
<blockquote>
<p>The captured traffic will contain packets that have traversed through the lan0_0 and wan0_0 interfaces on the
SteelHead appliance, allowing us to identify the SteelHead auto discovery probe that will appear in the
wan0_0 capture file.</p>
</blockquote>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Using your Windows client, <strong>n21-pc</strong>, open <strong>Mozilla Firefox</strong> or
<strong>Chrome</strong> from the Taskbar shortcut.
</p>
</li>
<li>
<p>In the bookmarks toolbar, expand the <strong>Branch Optimization</strong> folder and select the
<strong>n120-sh1 SteelHead 1 (Path 1)</strong> SteelHead appliance.
</p>
</li>
<li>
<p>Login using the following credentials:</p>
<pre><code>username:   admin
password:   password</code></pre>
</li>
<li>
<p>Using the branch SteelHead Web UI, navigate to <strong>Reports &gt; Diagnostics &gt; TCP Dumps</strong>.
</p>
</li>
<li>
<p>Click the <strong>Add a New TCP Dump</strong> button and specify the following capture criteria. Leave
any unlisted fields at the default value, and <strong>do not click the "Add" button</strong> until
instructed in the upcoming task.</p>
<blockquote>
<p>This is a time sensitive task that requires additional configuration in the next task.</p>
</blockquote>
<pre><code>Capture Name:           EADprobes
In-Path Interfaces:     lan0_0 (Check)
wan0_0 (Check)
Capture Duration:       60 Seconds</code></pre>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422102556.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Leave the browser window open.</p>
</li>
</ol>
<h4>Review</h4>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422102629.png" alt="screenshot"
title="Screenshot"></p>
<hr>
<h3>Task 2. Generate Traffic to Capture EAD Probes</h3>
<h4>Objective</h4>
<p>In this task, you will initiate new TCP connections from your Windows desktop to the HTTP web server.</p>
<blockquote>
<p><strong>It is important to follow the instructions carefully since this is a time sensitive task.</strong> By
establishing an HTTP connection, you will initiate the Enhanced Auto-Discovery (EAD) process, which will
insert probes into the TCP options field that will be captured by the TCP Dump process staged in the
previous task.</p>
</blockquote>
<h4>Detailed Steps</h4>
<blockquote>
<p>Ensure the TCP Dump Configuration task has been completed before proceeding with this task. You will also
need to be pretty quick (within 60 seconds between steps 1 and 3)</p>
</blockquote>
<ol>
<li>
<p>In the SteelHead Web UI TCP Dump capture, click the <strong>Add</strong> button. <em>EADprobes</em>
should appear under <strong>TCP Dumps Currently Running</strong></p>
</li>
<li>
<p>Open a <strong>new tab</strong> in your browser.</p>
</li>
<li>
<p>Using the browser bookmarks toolbar, open <code>Datacenter Hosts &gt; n31-fil File Server (HTTP)</code>
in the new tab.</p>
<blockquote>
<p><code>http://10.1.31.130</code></p>
<p>The page will load with a web directory listing of the /public/ directory of your datacenter file
server.</p>
</blockquote>
</li>
<li>
<p>Return to the SteelHead Web UI browser window.</p>
</li>
<li>
<p>Click the <strong>Stop Selected Captures</strong> button <em><em>or</em></em> simply wait for 60 seconds
for the TCP dump to complete.</p>
</li>
<li>
<p>Leave your browser window open.</p>
</li>
</ol>
<h4>Review</h4>
<p>By performing a directory listing of the HTTP /public/ directory, you generated a TCP 3-way handshake that
subsequently initiated the EAD process. The probes generated in the EAD process were captured by TCP dump
process you created and will be analyzed in the next tasks using Wireshark.</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422103731.png" alt="screenshot"
title="Screenshot"></p>
<hr>
<h3>Task 3. Download TCP Dump Capture Files from the SteelHead</h3>
<h4>Objective</h4>
<p>In this task, you will download the recently created TCP Dump capture files from the SteelHead Web UI.</p>
<blockquote>
<p>The TCP Dump configured earlier created capture files for both the LAN and WAN interfaces. Each of these
capture files are saved as a <code>.cap0</code> file which will be analyzed using the free Wireshark packet
analysis tool.</p>
</blockquote>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Use the SteelHead Web UI browser tab that you left open in the previous task.</p>
</li>
<li>
<p><strong>Refresh</strong> your browser window.</p>
</li>
<li>
<p>In the table of stored TCP dumps, you will see two new capture files for the LAN and WAN interfaces.</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220170423212642.png" alt="screenshot"
title="Screenshot"></p>
<blockquote>
<p>You will notice that the file name is formatted using the following syntax:</p>
<p><code>&lt;hostname&gt;_&lt;interface&gt;_&lt;your-dump-name&gt;.cap0</code></p>
</blockquote>
</li>
<li>
<p>Expand each capture file and click it's <strong>Download</strong> link.</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422110112.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>In the pop-up, click the <strong>Save</strong> button (will vary slightly between Firefox and Chrome):
</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422110122.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Ensure both files are downloaded and note their location, usually the Downloads folder or the Desktop.
</p>
</li>
</ol>
<h4>Review</h4>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119320170422110250.png" alt="screenshot"
title="Screenshot"></p>
<hr>
<h3>Task 4. Use Wireshark to Analyze TCP Dump Capture File</h3>
<h4>Objective</h4>
<p>In this task, you will use Wireshark to analyze the TCP Dump capture files that you downloaded in the previous
task.</p>
<blockquote>
<p>In the eLab environment, Wireshark has been installed on the Windows client, n21-pc. Although this task
assumes that you already have some familiarity with the Wireshark product, the steps in this task will
provide a step-by-step guide to allow you to analyze the packet capture.</p>
</blockquote>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Using your Windows desktop client, click the Windows icon at leftmost of the Task Bar and start typing
"wireshark". On the Search pop-up, select <strong>Wireshark 3.2.0</strong> (as in screenshot below,
though version may differ slightly in your environment).</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/40cb3471-2c62-480f-bc78-99ed9a57e4c8.png"
alt="screenshot" title="Screenshot Accessing Wireshark 3.2.0"></p>
</li>
<li>
<p>In the Wireshark title bar, select <strong>File &gt; Open</strong>.</p>
</li>
<li>
<p>Navigate to the file location (Download directory is easily accessed via <em>Quick access</em> link),
select the <code>lan0_0</code> capture file that you saved in the previous task, and click
<strong>Open</strong>.
</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/94974d65-bcbb-46b0-8cb5-b628351ead7b.png"
alt="screenshot" title="Screenshot Wireshark Open Capture"></p>
</li>
<li>
<p>Launch a second Wireshark window, as before, and open the <code>wan0_0</code> capture file. You will have
both capture files open, each in a separate Wireshark window.</p>
</li>
<li>
<p>In the <code>lan0_0</code> trace window, type <code>http</code> in the <strong>Filter field</strong> and
click <strong>Apply</strong>.</p>
<blockquote>
<p>This filter displays only packets containing HTTP traffic, which is just what we're looking for.</p>
</blockquote>
</li>
<li>
<p>Take a few moments to review the filtered results and explore additional Wireshark tools, such as the
<strong>Statistics &gt; Flow Graph</strong>, <strong>Statistics &gt; TCP Stream Graphs</strong>, or
<strong>Statistics &gt; HTTP</strong> menu options.
</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/26d6e529-ed88-4867-b3e3-106187e0d1d5.png"
alt="screenshot" title="Screenshot Wireshark Flow Graph"></p>
</li>
<li>
<p>Close the Flow Graph (if open) and, back in the main Wireshark window of the <code>lan0_0</code> capture,
scroll through the packets in the Packet List pane (the top one) to find the first "GET / HTTP/1.1". In
the Packet Details pane (the middle one), expand the TCP fields, then right-click on Source Port and
select "Apply as Column". Identifying this connection's Source Port allows us to more easily follow this
connection's packets when we open the WAN-side packet capture. In the screenshot below we see Source
Port 49835.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/397516f9-452e-41ae-9e1c-98ce8cd316ce.png"
alt="screenshot" title="Screenshot Wireshark Apply as Column"></p>
</li>
<li>
<p>Clear the Wireshark filter and locate the SYN packet whose Source Port corresponds to the HTTP Get. </p>
<blockquote>
<p>In the screenshot below you will see packet 31 (top in list) shows SYN (and ECN &amp; CWR, which are
not currently interested in) with Source Port 49835; this packet we will locate in the wan0_0
capture to identify what, if anything, was changed by the n120-sh1 SteelHead (SH). </p>
<p>While you are viewing this packet, it may be enlightening to note what the client set as TCP Options,
to allow a more clear picture of any changes made by the client-side SteelHead. You may also note
packet numbers 36 and 37 in the screenshot as the SYN/ACK and ACK for this connection; these had to
complete before the HTTP GET we first looked at, in packet 43, could be sent by the client's
browser.</p>
</blockquote>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/a5e77ade-036a-439f-babe-7820d34ffb01.png"
alt="screenshot" title="Screenshot Wireshark"></p>
</li>
<li>
<p>Switch to the Wireshark <code>wan0_0</code> trace window, type <code>tcp.options.rvbd.probe</code> in the
<strong>Filter field</strong> and click the <strong>Apply</strong> arrow at far right of the filter
field.
</p>
</li>
<li>
<p>Look for the "S+" in the Info field of the packet who's Source Port matches that noted in the lan0_0
capture (if it helps, you can add Source Port as a column, as before).</p>
<blockquote>
<p>You are isolating the same SYN packet the client sent to initiate this connection, but we now see it
<em>after</em> being handled by the client-side SH. Peruse the TCP Options of this packet to note if
any client-set options were altered.
</p>
</blockquote>
</li>
<li>
<p>To explore the Enhanced Auto Discovery process further, <strong>click on each of the filtered
packets</strong> and expand the <strong>Transmission Control Protocol &gt; Options</strong> entry in
the Packet Details pane.</p>
</li>
<li>
<p><strong>Search the TCP Options field</strong> of the S+, SA++, and SA+ packets to ensure you understand
how the client- and server-side SteelHeads leverage the TCP Options field to auto-discover each other.
Note that selecting a TCP Option in the Packet Details pane highlights the corresponding
hexadecimal-formatted payload in the Packet Bytes pane (bottom panel); useful to verify the first byte
of Riverbed EAD probes use 0x4c. </p>
</li>
<li>
<p>With auto-discovery understood, select the first SA+ packet, note it's packet number (on the left-most
column) and clear the Wireshark display filter by selecting the <code>x</code> at the filter's
right-hand edge. You should find the subsequent packets show the client-side SteelHead ARP for it's
default gateway, then send the SYN packet to the server-side SteelHead's in-path IP address over
tcp/7800. This begins the correct-addressed inner channel to establish optimization between the
SteelHead appliances.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/279291f0-bbb2-4876-beff-6805be8e0ee0.png"
alt="screenshot" title="Screenshot Wireshark 4c filter"></p>
</li>
<li>
<p>Once complete, exit out of both Wireshark application windows.</p>
</li>
</ol>
<hr>
<h3>Task 5. Change the Transparency Mode to <em>Full Transparency</em></h3>
<h4>Objective</h4>
<p>We will now set WAN Visibility Mode for tcp/80 connections to the n31-fil server to Full IP and Port
Transparency, then capture packets to analyze TCP Options. Recall that transparency mode, like every in-path
rule feature, is always configured on the client-side SteelHead.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Return to the Web GUI for n120-sh1. Navigate to <strong>OPTIMIZATION &gt; NETWORK SERVICES &gt; In-Path
Rules</strong></p>
</li>
<li>
<p>Click <strong>Add a New In-Path Rule</strong>, and configure these settings</p>
<pre><code>Source Subnet = All IPv4
Destination Subnet = 10.1.31.130/32
Destination: &gt; Port: &gt; Specific Port: 80
WAN Visibility Mode = Full Transparency
Description = "full trpy to n31-fil:80"</code></pre>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/b39ba38b-ae37-422c-808c-fbe7ee5f76d3.png"
alt="screenshot" title="Screenshot full trpy rule to n31-fil:80"></p>
</li>
<li>
<p>Leave all other settings at their default values and click <strong>Add</strong></p>
</li>
</ol>
<h4>Review</h4>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/b7bd4944-dbd1-44b6-a683-b3af9bd64363.png"
alt="screenshot" title="Screenshot Inpath Rule list"></p>
<hr>
<h3>Task 6. Configure and Start a New TCP Dump</h3>
<h4>Objective</h4>
<p>In this task we will create a new TCPDump and generate more traffic which, this time, should be optimized using
Full Transparency. We then examine these trace files using Wireshark.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Staying on the GUI for n120-sh1 navigate to <strong>Reports &gt; Diagnostics &gt; TCP Dumps</strong>.</p>
</li>
<li>
<p>As before, click the <strong>Add a New TCP Dump</strong> button and specify the following capture
criteria. Again, leave any unlisted fields at the default value. </p>
<blockquote>
<p>Though we will add a bit more time, check that the browser tab for <strong>Datacenter Hosts &gt;
n31-fil File Server (HTTP)</strong> is still open; if it is not then open it, take a quick
glance at where the file "DutchGoldenAge.ppt" is, and return here to complete the capture.</p>
</blockquote>
<pre><code>Capture Name:           FTprobes
In-Path Interfaces:     lan0_0 (Check)
wan0_0 (Check)
Capture Duration:       120 Seconds</code></pre>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420101556.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Click <strong>Add</strong> to start the TCP Capture. Verify that <strong>FTprobes</strong> appears under
<strong>TCP Dumps Currently Running</strong>:
</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420102120.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Return to the tab for <strong>Datacenter Hosts &gt; n31-fil File Server (HTTP)</strong> and refresh it.
Click the <strong>Presentations</strong> folder and then right-click the "DutchGoldenAge.ppt" file and,
when prompted, save the file. It technically does not matter which file you choose or even where you
have stored it, the important thing is that we have generated some traffic:</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420102339.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p><em>If you act quickly</em> you should be able to view this connection on n120-sh1 in the <em>Reports
&gt; Networking &gt; Current Connections Report</em>. HTTP connections are typically short lived, so
you'd have to view it before the transfer finishes. If you can, open this report and expand the
optimized connection. You should see that the connection is using Full Transparency. Should you miss
this first transfer, feel free to perform another with a file you've not yet transferred; this should
allow you time to catch it in the Current Connections Report.</p>
</li>
</ol>
<h4>Review</h4>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420102755.png" alt="screenshot"
title="Screenshot"></p>
<hr>
<h3>Task 7. Use Wireshark to Analyze the New TCP Dump Capture File</h3>
<h4>Objective</h4>
<p>In this, the final task of this lab, we will once again use Wireshark to analyze the TCP Dumps we generated in
the previous task.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Download both capture files using the steps you performed in Task 3.</p>
</li>
<li>
<p>Open a new Wireshark window and select <strong>File &gt; Open</strong>.</p>
</li>
<li>
<p>Select the <code>lan0-0</code> capture file that you just saved. Ensure you open <em>FTprobes</em> rather
than the EADprobes file!</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420103400.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Repeat this step for the corresponding <code>wan0_0</code> capture file in a separate Wireshark window.
</p>
</li>
<li>
<p>In the <code>lan0_0</code> trace window, type <code>http</code> in the <strong>Filter field</strong>,
click the <strong>Apply</strong> arrow.</p>
</li>
<li>
<p>Take a few moments to review the filtered results, they should look remarkably similar to those you saw
in Task 4.</p>
</li>
<li>
<p>Now, in the <code>wan0_0</code> trace window, type <code>tcp.options.rvbd.trpy</code> in the
<strong>Filter field</strong> and click the <strong>Apply</strong> arrow.
</p>
<blockquote>
<p>This filter will display only the packets containing the Riverbed Transparency TCP option, which as
you recall (and which you can now validate) begins with hexadecimal entry <code>4e</code>. Remember,
Full Transparency embeds the inner channel addressing information in the TCP options field, and it
is this information we are now interested in.</p>
</blockquote>
</li>
<li>
<p>You should see a lot of green packets between the IP addresses 10.1.21.110 and 10.1.31.130, all of them
with <code>TRPY</code> in the Info field. Click on one of these packets and expand the
<strong>Transmission Control Protocol &gt; Options</strong> entry in the lower contents pane.
</p>
</li>
<li>
<p><strong>Search the TCP Options field</strong> and its corresponding hexadecimal-formatted payload in the
lower two panels.</p>
</li>
<li>
<p>You should be able to see the 'real' endpoint IP addresses (of the client- and server-side SteelHead
in-path interfaces) embedded within the TCP Options field:</p>
<p><img src="https://s3.amazonaws.com/edu-screenshots/legacy/119220180420104418.png" alt="screenshot"
title="Screenshot"></p>
</li>
<li>
<p>Take a few moments to review the filtered results. Can you understand what is going on here? if not,
discuss this with your instructor.</p>
</li>
</ol>
<hr>
<h3>Extra Credit</h3>
<ol>
<li>
<p>Finally (you may need to change the filters) compare an equivalent packet (from a source IP to
destination IP) from the lan0_0 file with one from the wan0_0 capture file paying particular attention
to the client IP addresses its associated MAC address. See if you can answer the following questions:
</p>
<p>Does the SYN+ packet seen on the WAN side of n120-sh1 have the same source MAC address as it's
corresponding SYN packet seen on the LAN side? (HINT: use TCP source port to ensure same packet for same
connection is being compared)</p>
<p>For a given connection in full transparency, do the data packets (packets after the TCP handshake) on the
WAN side of the client-side SteelHead have the same source MAC address as data packets on the LAN side?
(HINT: look for TCP option 0x4e on the WAN-side trace)</p>
<p>Consider the MAC address corresponding to the IP address of the server (10.1.31.130), from the client's
perspective. Will the client see a change in the MAC address for the "server" depending on SYN, SYN+ and
data packets?</p>
</li>
<li>
<p>An important concept to understand about the above questions is: how is the SteelHead terminating and
bridging traffic? How are SYN+ packets actually handled? Which MAC address does the client-side
SteelHead use when it sends SYN+ packets? For the inner-channel of a full transparent connection, who is
really talking to whom?</p>
</li>
<li>
<p>Once complete, exit out of both Wireshark application windows.</p>
</li>
</ol>
<hr>
<h3>End of Scenario</h3>
<p>Congratulations! You have successfully created TCP dumps on SteelHead appliances, and from those have identified
and traced EAD packets and Full Transparency connections. For more information on Wireshark or to learn more
about packet capture, it is recommended to visit www.wireshark.org to download a free copy for yourself.</p>
</div>
