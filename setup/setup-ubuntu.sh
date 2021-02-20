#!/bin/bash
set -euxo pipefail

apt-get update -qq
apt-get install -y -qqq --no-install-recommends \
  sudo zsh tmux git vim wget curl htop rsync \
	strace ltrace tree make cmake elfutils \
  gdb locales python3 python3-pip binutils \
  gcc musl-tools nasm radare2 \
	build-essential libncurses-dev libssl-dev libffi-dev \
	bc bison flex perl openssl
	# mingw-w64 qemu-system 
apt-get purge -y
apt-get clean -y
rm -rf /var/lib/apt/lists/*

locale-gen --purge "en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' >> /etc/default/locale
dpkg-reconfigure --frontend=noninteractive locales
# echo export LANG=en_US.UTF-8 >> ~/.bashrc
# wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
# echo source ~/.gdbinit-gef.py >> ~/.gdbinit

if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

python3 -m pip install pwntools unicorn capstone ropper keystone-engine
