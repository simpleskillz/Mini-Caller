<div class="markdown-heading" dir="auto">
<h2>Mini Caller - Asterisk automatic calls</h2>
<h4>Simple tool for auto calls to contacts from file list<h4>
<hr>
<h3>Overview</h3>
<p>Mini Caller is a Bash script designed to automate outbound calls using Asterisk and a dongle device. It reads phone numbers from a specified file (<code>minicaller_numbers.txt</code>), sets caller ID information, initiates calls, and logs call details.</p>
<h3>Features</h3>
<ul>
<li><strong>Automated Calling:</strong> Initiates outbound calls sequentially to numbers listed in <code>minicaller_numbers.txt</code>.</li>
<li><strong>Caller ID Configuration:</strong> Sets caller ID as "BOT" + Numer for each call using Asterisk database commands.</li>
<li><strong>Call Progress Monitoring:</strong> Monitors the progress of each call, displaying status updates until completion.</li>
<li><strong>Logging:</strong> Logs call details including start time, end time, and duration to <code>minicaller_log.txt</code>.</li>
<li><strong>User Interaction:</strong> Prompts the user to confirm before initiating calls, ensuring manual oversight.</li>
</ul>
<h3>Requirements</h3>
<ul>
<li><strong>Asterisk:</strong> Requires an Asterisk installation with configured dongle device (<code>$DONGLE_DEVICE</code>).</li>
<li><strong>Authentication:</strong> Uses Asterisk Management Interface (AMI) credentials (<code>$AMI_USER</code>, <code>$AMI_PASS</code>, <code>$AMI_PORT</code>).</li>
<li><strong>New context in Dialplan:</strong> Setup in extensions_custom.conf file.</li>
</ul>
<h3>Usage</h3>
<ol>
<li>Ensure Asterisk and the dongle device are properly configured and operational.</li>
<li>Populate <code>minicaller_numbers.txt</code> with the phone numbers to call.</li>
<li>Execute the script and follow the prompts to begin calling.</li>
<li><strong>Add new context to dialplan.</strong></li></ol>
<div>
<strong>[mini-caller]</strong><br>
exten => s,1,Answer()<br>
exten => s,n,Set(CHANNEL(language)=en)<br>
exten => s,n,Set(CALLERID(num)=${DB(CALLERID/number)})<br>
exten => s,n,Set(CALLERID(name)=${DB(CALLERID/name)})<br>
exten => s,n,Wait(1)<br>
exten => s,n,Goto(ivr-4,s,1)<br>
exten => s,n,Hangup()<br>
</div>


<h3>Notes</h3>
<ul>
<li>Adjustments may be needed based on specific Asterisk configurations and network conditions.</li>
<li>This script assumes a Unix-like environment with Bash and necessary utilities (<code>awk</code>, <code>grep</code>, etc.) installed.</li>
</ul>
<h3>License</h3>
<p>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>
</div>
