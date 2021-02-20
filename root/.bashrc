# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias l='ls -ahl'
alias rm='rm -i'
export PATH="/project/bin:/project/vm/bin:$PATH"
export LANG=en_US.UTF-8
#export LC_CTYPE=C.UTF-8
#export LANGUAGEA="en_US"
#export LC_ALL="en_US.UTF-8"
#export LC_ALL=C.UTF-8
#export PYTHONIOENCODING=utf8
