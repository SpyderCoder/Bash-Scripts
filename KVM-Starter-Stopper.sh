#!/bin/bash

# If you plan on using this and repurposing it I really recommend checking if your screen is compatible with ddcutil
# otherwise YOU COULD POSSIBLY BRICK YOUR SCREENS FIRMWARE!!!! You can learn more about ddcutil at https://www.ddcutil.com/
# I'm not responsible for any misfortune this script causes so use at your own risk.

kvm_running=$(virsh -c qemu:///session list --state-running | grep -c $1)
on_display_port=$(ddcutil -d 1 getvcp 0x60 | grep -c 0x0f)

if [[ $kvm_running -eq 0 ]]
then
    kdialog --title "Starting $1" --passivepopup "KVM should be ready to go in a few seconds." 5
    virsh -c qemu:///session start $1

    if [[ $on_display_port -eq 1 ]]
    then
        ddcutil -d 1 setvcp 0x60 0x12
    fi

else
    virsh -c qemu:///session destroy $1
    kdialog --title "Stopping $1" --passivepopup "KVM has been shutdown." 5

    if [[ $on_display_port -eq 0 ]]
    then
        ddcutil -d 1 setvcp 0x60 0x0f
    fi
fi
