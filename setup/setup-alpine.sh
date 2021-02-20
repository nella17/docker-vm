#!/bin/sh
set -euxo pipefail

apk add --no-cache ca-certificates

PYTHONUNBUFFERED=1
apk add --no-cache python3-dev
python3 -m ensurepip
python3 -m pip install --no-cache --upgrade pip setuptools wheel

if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

apk add --no-cache bash zsh tmux git vim wget curl htop rsync \
  g++ make cmake nasm gdb radare2 linux-headers \
  file tree strace ltrace elfutils \
  libffi-dev libressl-dev openssl-dev musl-dev cargo
	# bison flex \
	# bc perl 

wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

python3 -m pip install --no-cache pwntools unicorn capstone ropper keystone-engine
