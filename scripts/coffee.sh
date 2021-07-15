#!/bin/bash

# --------------------------------------------
# A simple post-install script for Linux Mint.
# --------------------------------------------

if [ ${UID} -ne 0 ]
then
    echo "Run as sudo or root."
    exit 1
fi

echo "
  (((
   )))     This may take a while.
  |~~~|    Why don't you go
 C|___|    grab a cup of coffee? 
"

sleep 5

echo "
  *  Upgrading system...
"
sleep 2
apt update && apt upgrade -y

echo "
  *  Installing software...
"
sleep 2
apt install xterm git pass fail2ban vim w3m -y
apt install python3 python3-pip -y
apt install audacious spotify-client -y

echo "
  *  Enabling firewall...
"
ufw enable

echo "
  *  Disabling unnecessary services...
"
systemctl disable ModemManager
systemctl disable pppd-dns
systemctl disable kerneloops
systemctl disable rsyslog
systemctl disable avahi-daemon

read -p "
  *  Do you want to enter Git credentials? (y/n) " opt

if [ $opt == "y" ]; then
    read -p "E-mail: " email
    git config --global user.email "$email"
    read -p "Username: " name
    git config --global user.name "$name"
fi

# Cleaning leftovers
echo "*  Cleaning leftovers..."
apt autoremove -y; apt clean
clear

echo "
  (((
   )))
  |~~~|    Your system is good to go!
 C|___|
"
exit
