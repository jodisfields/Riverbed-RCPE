<div class="prose lg:prose-lg max-w-none">
                <h1>HOL5923: Create Web App Dashboards</h1>
<h2>Introduction</h2>
<h4>Overview</h4>
<p>In this lab scenario, you are part of the End-User Services team currently using SteelCentral AppResponse and Portal to monitor the performance of your company’s public facing website. You are now tasked by management to create and share dashboards that display the website’s usage and performance. The new dashboards are to be shared with two user groups, management and the help desk staff on the tier 1 support team.</p>

#### Solution

<h4>Lab Objectives</h4>
<ol>
<li>
<p>Review the Advanced Web Applications and Host Groups That Have Been Defined on AppResponse to Monitor the Public Website</p>
</li>
<li>
<p>Create an SLA Dashboard in SteelCentral Portal to Monitor the Website’s Most Important Pages and User Locations to be Shared with Management</p>
</li>
<li>
<p>Create a Web Application Performance Dashboard That Monitors the Public Website and That Can be Used by the Helpdesk as Starting Point to Perform Triage and Troubleshooting in the Event of Poor Performance</p>
</li>
</ol>

#### Challenge Objectives

1. {Challenge Title}
2. {Challenge Title}

<hr />
<h3>Task 1. Review the Advanced Web Applications and Host Groups that have been defined on AppResponse to monitor the public website.</h3>
<h4>Objective</h4>
<p>In this task, you will browse the data source, AppResponse to observe how it is currently configured to monitor the public website.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Access the AppResponse user interface at <code>https://10.99.31.240</code> or using the browser bookmark <strong>DataCenter Hosts &gt; n31-arx SC AppResponse</strong>.</p>
<ul>
<li>If necessary, add the security exception to accept the use of the self-signed certificate.</li>
</ul>
</li>
<li>
<p>Login using the credentials <strong>admin/admin</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/89a739e5-1a5b-47bc-bc0e-fa00a006c7c9.png" alt="screenshot" title="HOL5923 AppResponse Login Page 2021" /></p>
</li>
<li>
<p>It may take a few minutes for the Time to synchronize.</p>
</li>
<li>
<p>Navigate to <strong>DEFINITIONS &gt; Applications</strong> to observe the list of applications currently defined on the AppResponse appliance.</p>
</li>
<li>
<p>Click on the <strong>Web</strong> tab to view the application definitions used by the AppResponse Web Transaction Analysis Module.</p>
</li>
<li>
<p>Use the information on this page to answer the following questions:</p>
<ul>
<li>
<p>How many Web Application definitions are supported on this appliance?</p>
</li>
<li>
<p>How many Web Application definitions have already been defined?</p>
</li>
<li>
<p>What is the Traffic Matching Mode of all of these application definitions?</p>
</li>
<li>
<p>How many of these application definitions are related to the PUBLIC WEBSITE?</p>
</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/6b71e2df-658b-47df-8f4c-d98ce8187d28.png" alt="screenshot" title="HOL5923 AppResponse App Config" /></p>
</li>
<li>
<p>Click on the <strong>Edit</strong> button (the Pencil to the right)in the row for the <strong>PUBLIC WEBSITE</strong> definition (the one with no additional &quot;Description&quot;) to view the URL and any additional parameters used to define this app.</p>
<ul>
<li>Compare this definition to the definitions used for other PUBLIC WEBSITE pages.</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/4f97da6e-80f9-43aa-acff-75ab6c850475.png" alt="screenshot" title="HOL5923 AppResponse Edit WebApp" /></p>
</li>
<li>
<p>Use the information from these definitions to answer the following questions:</p>
<ul>
<li>
<p>How long would a page load have to take to complete to be considered a slow page by these definitions?</p>
</li>
<li>
<p>Do the application definitions contain overlapping URL patterns?</p>
</li>
<li>
<p>Which of the application definitions is the most specific?</p>
</li>
</ul>
</li>
<li>
<p>Close the <strong>Edit Web Application</strong> dialog box.</p>
</li>
<li>
<p>Navigate to <strong>DEFINITIONS &gt; Host Groups</strong> to observe the list of host groups currently defined on the AppResponse appliance.</p>
</li>
<li>
<p>Sort the <strong>Host Group Configuration</strong> table by <strong>Status</strong> by clicking on the descending arrow in the appropriate column header.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/2c7b6d94-5b9a-4c11-883b-369cf7bd0025.png" alt="screenshot" title="HOL5923 AppResponse Host Group Config" /></p>
</li>
<li>
<p>Use this Host Group table to answer the following questions:</p>
<ul>
<li>
<p>How many Host Groups are enabled?</p>
</li>
<li>
<p>How many Host Groups represent office locations?</p>
</li>
<li>
<p>Are there any Host Groups that are enabled but not an office location?</p>
</li>
</ul>
</li>
<li>
<p>You may have to wait 5 minutes for the Host Groups and New Applications to accumulate data.</p>
</li>
<li>
<p>Go to <strong>Home</strong></p>
</li>
<li>
<p>Click on recent 1 Hour in the upper right corner.</p>
</li>
<li>
<p>Navigate to <strong>INSIGHTS &gt; Web &gt; Web App</strong>.</p>
</li>
<li>
<p>Enter <strong>PUBLIC WEBSITE</strong> as your input.</p>
</li>
<li>
<p>Click <strong>Launch</strong> to open the Insight.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/5f5891cb-af5f-49cf-8ce3-14a196457940.png" alt="screenshot" title="HOL5923 AppResponse Pick WebApp" /></p>
</li>
<li>
<p>Use the information displayed in the Insight to answer the following questions:</p>
<ul>
<li>
<p>How many times was the page viewed in the last hour?</p>
</li>
<li>
<p>What is the average page time for the PUBLIC WEBSITE?</p>
</li>
<li>
<p>Which Web User Group experienced the worst page time?</p>
</li>
<li>
<p>When did the worst page time occur?</p>
</li>
<li>
<p>What page family delivered the worst page time?</p>
</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/7ac518b9-dcd8-4857-92f5-c8d668cff733.png" alt="screenshot" title="HOL5923 AppResponse WebApp" /></p>
</li>
</ol>

#### Review

<hr />
<h3>Task 2. Create an SLA Dashboard in SteelCentral Portal to monitor the website’s most important pages and user locations to be shared with management.</h3>
<h4>Objective</h4>
<p>In this task, you will add the AppResponse appliance as a data source for Portal and create dashboards based on packet inspection metrics for the public website.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Access the Portal user interface at <code>https://10.99.31.200</code> or using the browser bookmark <strong>DataCenter Hosts &gt; n31-prtl SC Portal</strong>.</p>
<ul>
<li>If necessary, add the security exception to accept the use of the self-signed certificate.</li>
</ul>
</li>
<li>
<p>Login using the credentials <strong>admin/admin</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/25563f91-42ed-447b-94b2-940750c12b15.png" alt="screenshot" title="HOL5923 Portal Login" /></p>
</li>
<li>
<p>After logging in, you will be prompted to add a data source to Portal.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/dcbf2e6f-da99-42e5-94ea-1dc611004882.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Select <strong>Yes</strong> to continue and complete the process of adding the data source with the information listed below:</p>
<pre><code>Data source type: AppResponse
Hostname: 10.99.31.240
Port: 443
Description: eLab AppResponse
Username: admin
Password: admin</code></pre>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/5ea6f2f7-3b2d-4244-a936-9ee84bde7973.png" alt="screenshot" title="HOL5923 Portal Data Source" /></p>
</li>
<li>
<p>Click <strong>Connect</strong> to proceed.</p>
</li>
<li>
<p>The process will take 1-2 minutes to complete and the final result should be <strong>Connected Successfully</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/7372856c-2f0a-41d3-9543-2464485d5d0a.png" alt="screenshot" title="HOL5923 Portal Data SourceStatus" /></p>
</li>
<li>
<p>Navigate to <strong>DASHBOARDS &gt; Create</strong>.</p>
</li>
<li>
<p>In the resulting <strong>Create a New Dashboard</strong> wizard, scroll down select the <strong>SLA Dashboard</strong> by <strong>Page Time (AppResponse)</strong> and click <strong>Next</strong> to continue.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/adaefafe-8715-4dc6-a473-1b67b4e572dc.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>On the Select <strong>Web User Groups</strong> step, select all of the <strong>Office locations and Default- Internet Group</strong> and click <strong>Next</strong> to continue.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/53744b46-be65-4f5e-9ac3-f50d57da71ef.png" alt="screenshot" title="HOL5923 Portal New DashboardSelectUsergrps" /></p>
</li>
<li>
<p>On the Select Web Applications step, select all of the <strong>PUBLIC WEBSITE</strong> applications and click <strong>Next</strong> to continue.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/590cced3-7415-44ff-93d6-e0516329f7c7.png" alt="screenshot" title="HOL5923 Portal New DashboardSelectApps" /></p>
</li>
<li>
<p>On the Select Data Sources step, select Use all connected data sources and click <strong>Next</strong> to continue.</p>
</li>
<li>
<p>On the Set dashboard options step, change the Dashboard Name to <strong>Public Website SLA Dashboard</strong>, leave the Dashboard Size as current browser size and click <strong>Create</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/f4a51da0-e921-4353-916a-d3660c89b61b.png" alt="screenshot" title="Screenshot" /></p>
<p>Congratulations, you have now created your first Portal dashboard. This is a high level SLA Dashboard that is suitable for management and line-of-business owners to monitor the status of application performance from each location without configuring or navigating the underlying AppResponse data source. Ideally each LED on this dashboard would show a page time within acceptable limits represented by the green check-mark.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/48791c5f-3572-4bf9-bb1e-04eb605df94c.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Explore the Drilldown options available from the LEDs on the SLA Dashboard.</p>
</li>
<li>
<p>On a single LED that is in the critical state (red X), <strong>right-click &gt; Drilldowns &gt; Web Application Details</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/013f6362-a0a4-4b77-b4b5-d63666595bba.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Use the resulting Dashboard to answer the following questions:</p>
<ul>
<li>
<p>Which Web User Group experienced the worst page time?</p>
</li>
<li>
<p>For this group, which component of delay was the highest contributor to page time?</p>
</li>
</ul>
<p>Hint: Hover over bar chart components for numerical values.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/5e430ba3-4399-4e78-ae57-3c4707292e25.png" alt="screenshot" title="HOL5923 Portal New DashboardWebAppDetails" /></p>
</li>
<li>
<p>Return to your SLA dashboard by navigating to <strong>DASHBOARDS &gt; RECENTS &gt; Public Website SLA</strong>.</p>
</li>
<li>
<p>Find and use the drilldown option that allows you to view the performance of all web applications for a specific site, <strong>Great Lakes Office</strong>.</p>
<ul>
<li>
<p>What is the web app with the highest throughput at this site?</p>
</li>
<li>
<p>What is the web app with the highest number of slow pages at this site?</p>
</li>
<li>
<p>How many Slow Pages for the public website were experienced at this site?</p>
</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/0d61e89d-a474-4978-9f80-ebb614a34248.png" alt="screenshot" title="HOL5923 Portal New DashboardWebUserGrpDetails" /></p>
</li>
</ol>

#### Review

<hr />
<h3>Task 3. Create a web application performance dashboard that monitors the public website and that can be used by the helpdesk as a starting point to perform triage and troubleshooting in the event of poor performance.</h3>
<h4>Objective</h4>
<p>In this task, you will design your dashboards to meet the needs of two specific groups in your enterprise, IT management and the help- desk.</p>
<h4>Detailed Steps</h4>
<ol>
<li>
<p>Navigate to <strong>DASHBOARDS &gt; Create</strong>.</p>
</li>
<li>
<p>In the resulting Create New Dashboard wizard, scroll down select the <strong>Web Application Details</strong> dashboard template and click <strong>Next</strong> to continue.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/dd3dc62f-2e25-461b-ac46-de2ae15278f2.png" alt="screenshot" title="HOL5923 Portal New DashboardSelectWebAppDetails" /></p>
</li>
<li>
<p>On the Select a Web Application Step, start by typing <strong>PUBLIC WEBSITE</strong> in the search box and select <strong>PUBLIC WEBSITE</strong> from the drop down menu when available.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/daa2d42d-1dd2-4030-af4c-95e851f0e8f8.png" alt="screenshot" title="HOL5923 Portal New DashboardSelectWebApp" /></p>
</li>
<li>
<p>On the Select Data Sources step, select Use all connected data sources and click <strong>Finish</strong> to continue.</p>
</li>
<li>
<p>Click <strong>Create</strong> to complete the dashboard.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/4c664fc3-a317-4e6f-b498-3a3d12269d05.png" alt="screenshot" title="HOL5923 Portal New DashboardSelectWebAppDet" /></p>
</li>
<li>
<p>Use the dashboard to answer the following questions:</p>
<ul>
<li>
<p>Which Page Family delivered the worst page time?</p>
</li>
<li>
<p>Were there any 5xx Server errors observed for this web app?</p>
</li>
<li>
<p>What were the server IP addresses observed for this app?</p>
</li>
</ul>
</li>
<li>
<p>Drilldown into Page Views to identify the busiest servers and clients.</p>
</li>
<li>
<p>Find the <strong>PUBLIC WEBSITE</strong> Usage panel.</p>
</li>
<li>
<p>On Page Views sparkline, <strong>right-click &gt; Drilldowns &gt; Top Server IPs</strong>.</p>
</li>
<li>
<p>Repeat the steps above to identify the Top Client IPs.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/560a7ef1-6733-4681-bfd0-5030ef4aff1e.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Use the resulting pop-up panels to find:</p>
<ul>
<li>
<p>What Client IP had the most page views?</p>
</li>
<li>
<p>How many page views were served by the Top Server?</p>
</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/f1763515-187c-4ff8-b281-3342ff25ee39.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Close the pop-up panels.</p>
</li>
<li>
<p>Drilldown into the slowest Page Family to create a <strong>Page Family Details</strong> dashboard.</p>
</li>
<li>
<p>On the slowest page family, right-click &gt; <strong>Drilldowns &gt; Page Family Details</strong>.</p>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/880f5b91-7132-48d7-94c3-3871d766cb47.png" alt="screenshot" title="Screenshot" /></p>
</li>
<li>
<p>Use the new dashboard to identify:</p>
<ul>
<li>
<p>The slowest client.</p>
</li>
<li>
<p>The slowest server.</p>
</li>
<li>
<p>The slowest user group.</p>
</li>
</ul>
<p><img src="https://edu-screenshots.s3.amazonaws.com/current/1db94834-6fc3-407b-9c50-e3e25b5b4776.png" alt="screenshot" title="Screenshot" /></p>
</li>
</ol>

#### Review

<hr />
<h3>Challenge</h3>
<h4>Objective</h4>
<p>In this challenge, you will find the problematic web page objects on the single slowest public website page view from the Great Lakes office starting in Portal and filtering down to AppResponse individual page views.</p>
<h4>Hints</h4>
<ol>
<li>
<p>Return to your Public Website: Web Application Details dashboard.</p>
</li>
<li>
<p>Launch into Summary: <strong>Page Views from the Great Lakes Office Web User Group</strong>.</p>
</li>
<li>
<p>Use the resulting AppResponse Insight to answer the following questions:</p>
<ul>
<li>
<p>How would you describe what the True Plot panel shows?</p>
</li>
<li>
<p>How many unique users accessed the website from this location?</p>
</li>
<li>
<p>What was the page time of the slowest page?</p>
</li>
<li>
<p>What was the slowest object on the page?</p>
</li>
<li>
<p>Was the object slow due to request, response or server time?</p>
</li>
</ul>
</li>
</ol>

#### Review

<hr/>

### Challenge 2

#### Objective

In this challenge, you will create an SLA dashboard for monitoring MS Office application performance by location in SteelCentral Portal using only Aternity Activity Scores.

#### Hints

1. Navigate to **Administration > Data Sources > Add**.
2. Add the LMS SaaS instance of Aternity as a data source for Portal using the following:
        Hostname: lms-datasource.aternity.com
        Port: 443
        Username: SCAternityPortal_2
        Password: 2_163a23b94c8_HlxteFyM72tsiYjJMhbHnNqjP6m6ek
3. Use the Create Dashboard wizard to find and use the appropriate template for an Aternity SLA dashboard.
4. Follow the steps in the wizard to create a dashboard for all Office Locations and all MS Office apps.
    ![screenshot](https://edu-screenshots.s3.amazonaws.com/current/98fa87d7-df98-45f4-9eef-7f79da555b03.png "Screenshot")
5. Use the resulting dashboard to answer the following:
    - What drilldown options are available from this SLA dashboard?
    - What is the only option to navigate from this Portal dashboard to an Aternity Dashboard?

#### Review

<hr />
<h3>End of Scenario</h3>
<p>This lab exercise demonstrated the use of two different types of dashboards in SteelCentral Portal. The type of dashboard you choose to create depends on the definitions and metrics available from your data sources and the specific requirements of the consumers of dashboard. You first reviewed the existing configuration of app definitions and host groups on the AppResponse appliance before adding it as a data source to Portal. Next, you created two new dashboards and explored a few of the available drilldown options for creating additional dashboards and pop-up panels on demand.</p>
<hr />
            </div>
        </div>
    </div>
</div>
