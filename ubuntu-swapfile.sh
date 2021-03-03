#!/bin/sh

#SWAPFILE
echo "starting swapfile install script ..."

#VARIABLES
echo "gathering arguments from commandline ..."
if [ -z "$1" ]
    then
        echo -e "\e[32mwould you like to create a 4G swapfile? [Y/n]"
        read SWAP_CONFIRM
    else
    SWAP_CONFIRM="${1}"
fi

#CREATE SWAPFILE LOGIC
if [ "$SWAP_CONFIRM" != "${SWAP_CONFIRM#[Yy]}" ] ;then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "updating /etc/fstab file to run swap file on system startup ..."
    echo "# linux swapfile use sudo free -h to view available space" >> /etc/fstab
    echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
    echo "success: swapfile created ..."
else
    echo "notice: swapfile skipped by user ..."
fi

#DELETE SELF AND EXIT
rm -- "$0"
exit
