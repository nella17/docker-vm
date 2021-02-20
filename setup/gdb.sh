#!/bin/sh
apt-get update -y -qq
apt-get install -y -qqq gdb wget python3 locales
locale-gen --purge "en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' >> /etc/default/locale
dpkg-reconfigure --frontend=noninteractive locales
echo export LANG=en_US.UTF-8 >> ~/.bashrc
wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit
