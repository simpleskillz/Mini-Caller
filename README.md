# minicaller

Mini Caller Version 2.1


Overview
Mini Caller is a Bash script designed to automate outbound calls using Asterisk and a dongle device. It reads phone numbers from a specified file (minicaller_numbers.txt), sets caller ID information, initiates calls, and logs call details.


Features
Automated Calling: Initiates outbound calls sequentially to numbers listed in minicaller_numbers.txt.
Caller ID Configuration: Sets caller ID as "BOT" for each call using Asterisk database commands.
Call Progress Monitoring: Monitors the progress of each call, displaying status updates until completion.
Logging: Logs call details including start time, end time, and duration to minicaller_log.txt.
User Interaction: Prompts the user to confirm before initiating calls, ensuring manual oversight.


Requirements
Asterisk: Requires an Asterisk installation with configured dongle device ($DONGLE_DEVICE).
Authentication: Uses Asterisk Management Interface (AMI) credentials ($AMI_USER, $AMI_PASS, $AMI_PORT).


Usage
Ensure Asterisk and the dongle device are properly configured and operational.
Populate minicaller_numbers.txt with the phone numbers to call.
Execute the script and follow the prompts to begin calling.


Notes
Adjustments may be needed based on specific Asterisk configurations and network conditions.
This script assumes a Unix-like environment with Bash and necessary utilities (awk, grep, etc.) installed.


License
This script is licensed under the MIT License.
