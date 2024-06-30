<div class="markdown-heading" dir="auto">
<h2>BOT Mini Caller ver 2.1</h2>
<h4>Automatic calls using Asterisk<h4>
<hr>
<h3>Overview</h3>
<p>Mini Caller is a Bash script designed to automate outbound calls using Asterisk and a dongle device. It reads phone numbers from a specified file (<code>minicaller_numbers.txt</code>), sets caller ID information, initiates calls, and logs call details.</p>
<h3>Features</h3>
<ul>
<li><strong>Automated Calling:</strong> Initiates outbound calls sequentially to numbers listed in <code>minicaller_numbers.txt</code>.</li>
<li><strong>Caller ID Configuration:</strong> Sets caller ID as "BOT" for each call using Asterisk database commands.</li>
<li><strong>Call Progress Monitoring:</strong> Monitors the progress of each call, displaying status updates until completion.</li>
<li><strong>Logging:</strong> Logs call details including start time, end time, and duration to <code>minicaller_log.txt</code>.</li>
<li><strong>User Interaction:</strong> Prompts the user to confirm before initiating calls, ensuring manual oversight.</li>
</ul>
<h3>Requirements</h3>
<ul>
<li><strong>Asterisk:</strong> Requires an Asterisk installation with configured dongle device (<code>$DONGLE_DEVICE</code>).</li>
<li><strong>Authentication:</strong> Uses Asterisk Management Interface (AMI) credentials (<code>$AMI_USER</code>, <code>$AMI_PASS</code>, <code>$AMI_PORT</code>).</li>
</ul>
<h3>Usage</h3>
<ol>
<li>Ensure Asterisk and the dongle device are properly configured and operational.</li>
<li>Populate <code>minicaller_numbers.txt</code> with the phone numbers to call.</li>
<li>Execute the script and follow the prompts to begin calling.</li>
</ol>
<h3>Notes</h3>
<ul>
<li>Adjustments may be needed based on specific Asterisk configurations and network conditions.</li>
<li>This script assumes a Unix-like environment with Bash and necessary utilities (<code>awk</code>, <code>grep</code>, etc.) installed.</li>
</ul>
<h3>License</h3>
<p>This script is licensed under the <a target="_new" rel="noreferrer">MIT License</a>.</p>
</div>
