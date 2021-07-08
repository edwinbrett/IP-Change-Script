# IP-Change-Script
A script to change IPs on specific interfaces.

ROAD MAP

1. Create a list of selectable adapters, Example: Ethernet & Uplink. Script should prompt for a selection of the adapters by entering 1 or 2 into the command prompt

2. From there, the script should ask if the user would like to set a static IP address, this should prompt the user with a yes or no, that can be responded with y/n

3. After which the script should prompt the user to enter the static IP address.

4. Then it should prompt for the Subnet Mask

5. And then it should prompt for the gateway

6. The script should then ask if the user wants to set custom DNS servers, this should prompt the user with a yes or no, that can be responded with y/n

7. After which it should prompt the user to input the first DNS server. Then it should prompt for a second one, but the second one should not require a response.

8. Once completed, the scipt should validate the settings via a Ping of 1.1.1.1

PIPE DREAM/WISHES

1. The ability to select an interface to disable, and an interface to enable, before all of the other prompts.