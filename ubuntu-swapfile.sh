#!/bin/sh

#SWAPFILE
echo "starting swapfile install script ..."
echo "would you like to create a 2G swapfile? [Y/n]"
read SWAP_CONFIRM
if [ "$SWAP_CONFIRM" != "${SWAP_CONFIRM#[Yy]}" ] ;then
    fallocate -l 2G /swapfile
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

rm -- "$0"
exit
