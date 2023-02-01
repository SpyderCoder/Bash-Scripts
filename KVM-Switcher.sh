#!/bin/bash

# If you plan on using this and repurposing it I really recommend checking if your screen is compatible with ddcutil
# otherwise YOU COULD POSSIBLY BRICK YOUR SCREENS FIRMWARE!!!! You can learn more about ddcutil at https://www.ddcutil.com/
# I'm not responsible for any misfortune this script causes so use at your own risk.

kvm_running=$(virsh -c qemu:///session list --state-running | grep running -c $1)
on_display_port=$(ddcutil -d 1 getvcp 0x60 | grep -c 0x0f)

if [[ $kvm_running -eq 1 ]]
then
    if [[ $on_display_port -eq 0 ]]
    then
        ddcutil -d 1 setvcp 0x60 0x0f
    else
        ddcutil -d 1 setvcp 0x60 0x12
    fi
else
    kdialog --title "Can't Switch" --passivepopup "No KVM's are currently running." 5
fi
