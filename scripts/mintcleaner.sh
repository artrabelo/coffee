#!/bin/bash

# --------------------------------------------
# A script to keep Linux clean.
# --------------------------------------------

echo "** Removing unnecessary apps and APT cache..."
# Note: Make sure you know what autoremove will do before run this!
apt-get autoremove -y && apt-get clean

echo "** Cleaning journal logs..."
journalctl --vacuum-size=100M

echo "** Cleaning thumbnails cache..."
rm -rf ~/.cache/thumbnails/*

echo "** Deleting files from cache accessed more than 7 days..."
find ~/.cache -type f -atime +7 -delete

echo "** Cleaning trash bin..."
# This used to be done with gio but i'll keep it raw for compatibility
rm -rf $HOME/.local/share/Trash/*

echo "Done!"
exit
