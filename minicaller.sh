#!/bin/bash

DONGLE_DEVICE="dongle0"
AMI_USER="user_name"
AMI_PASS="ami_password"
AMI_PORT="5038"
NUMBER_FILE="minicaller_numbers.txt"
SUMMARY_FILE="minicaller_log.txt"

# Count numbers in minicaller_numbers.txt
NUMBERS_COUNT=$(wc -l < "$NUMBER_FILE")

# Clear the minicaller_log.txt file
> "$SUMMARY_FILE"
echo ""
echo "########################################"
echo ""
echo "SCRIPT: Mini Caller ver. 2.1"
echo ""
echo "START: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "########################################"
echo ""
# Display numbers list from the minicaller_numbers.txt file
echo "Contacts on file list $NUMBERS_COUNT"
echo ""
cat "$NUMBER_FILE"
echo ""
echo "########################################"

function make_call() {
    local number=$1
    local caller_id="BOT"
    # Clear old CALLERID values
	asterisk -rx "database del CALLERID number" > /dev/null
	asterisk -rx "database del CALLERID name" > /dev/null
    # Set new CALLERID values
	asterisk -rx "database put CALLERID number $number" > /dev/null
	asterisk -rx "database put CALLERID name $caller_id" > /dev/null
    asterisk -rx "channel originate dongle/$DONGLE_DEVICE/$number extension s@mini-caller"
}

function wait_for_completion() {
    local wait_number=$1
    local channel=""
    local device_state=""
    local talk_status=""
    local counter=0

    while true; do
        device_state=$(asterisk -rx "dongle show device state $DONGLE_DEVICE" | grep "State" | awk '{print $2}')

        if [ "$device_state" == "Free" ]; then
            echo "Device $DONGLE_DEVICE is available."
            break
        fi

        channel=$(asterisk -rx "core show channels verbose" | grep "$DONGLE_DEVICE" | awk '{print $1}')
        if [ -z "$channel" ]; then
            local end_time=$(date +%s)
            local duration=$((end_time - start_time))
			echo ""
            echo "End of call: $wait_number"
			echo "Time: $(date '+%Y-%m-%d %H:%M:%S')"
            echo "Duration: $duration sec"
            echo "----------------------------------"
            echo ""
            break
        fi

        talk_status=$(asterisk -rx "core show channels concise" | grep "$channel" | awk '{print $12}')
        if [ "$talk_status" == "Up" ]; then
            	printf '%s%s%s%s' "$(tput setaf 3)" "$(tput blink)" "--- CALL IN PROGRESS ---> $wait_number [$counter s]..." "$(tput sgr0)"
        else
            	printf '%s%s%s%s' "$(tput setaf 3)" "$(tput blink)" "--- CALL IN PROGRESS ---> $wait_number [$counter s]..." "$(tput sgr0)"
        fi

        counter=$((counter + 1))
        sleep 1
        echo -ne "\r\033[K"  # Clear the current line
    done
    echo
}

echo ""
printf '%s%s%s%s' "$(tput setaf 3)" "$(tput blink)" "----- READY TO CALL -----" "$(tput sgr0)" 
echo ""
echo

# Prompt user to start
while true; do
    echo "All calls to make: $NUMBERS_COUNT"
    echo ""
    echo "Begin calling? (Y)es or (N)o"
    read answer

    case $answer in
        [Yy]* )
            break;;
        [Nn]* )
            echo "User declined to start. Exiting script."
            exit;;
        * )
            echo "Please enter Y or N";;
    esac
done

total_connections=0
total_duration=0

while IFS= read -r number || [ -n "$number" ]; do
    number=$(echo "$number" | tr -d '[:space:]')
    echo ""
    echo "----------------------------------"
	printf '%s%s%s%s' "$(tput setaf 3)" "$(tput blink)" "Contact $number" "$(tput sgr0)"
    echo ""
    echo ""
    make_call "$number"
    start_time=$(date +%s)
    wait_for_completion "$number"
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    total_duration=$((total_duration + duration))
    total_connections=$((total_connections + 1))

    # Write information to minicaller_log.txt file
    echo "$total_connections. $number, Date: $(date "+%Y-%m-%d %H:%M:%S"), Total time: $duration seconds" >> "$SUMMARY_FILE"
    echo "Total calls counter [$total_connections]"
    for i in {1..15}; do
        printf "\rWaiting until next call 15 sec ---> [%-1s]" "$i"
		sleep 1
		echo -ne "\r\033[K"
    done
    echo
done < "$NUMBER_FILE"

# Log off from AMI after all connections
{
    echo "Action: Logoff"
    echo
} | nc localhost "$AMI_PORT"

# Summary of all numbers at the end
echo
echo "----------------------------------------"
echo ""
	printf '%s%s%s%s' "$(tput setaf 3)" "$(tput blink)" "--- SUMMARY ALL CALLS ---" "$(tput sgr0)"
echo ""
echo ""
echo "----------------------------------------"
echo
cat "$SUMMARY_FILE"

echo
echo "----------------------------------------"
echo "Finish work time: $(date '+%Y-%m-%d %H:%M:%S')"
echo "----------------------------------------"
echo ""