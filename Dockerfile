FROM ubuntu:tag

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/bin:${PATH}"
ENV LANG="en_US.UTF-8"
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN <<EOF
    set -eux
    apt-get update
    apt-get -qqq install -y --no-install-recommends \
      sudo file less zsh tmux git vim wget curl rsync htop zip unzip \
      strace ltrace tree make cmake elfutils locales net-tools \
      binutils g++ g++-multilib musl-tools nasm gdb patchelf \
      lib32z1 libseccomp-dev \
      build-essential perl openssl ruby-dev socat xinetd \
      python3-dev python3-pip python-is-python3 \
      glibc-source gawk bison
    (apt-get -qqq install -y --no-install-recommends netcat || true)
    (apt-get -qqq install -y --no-install-recommends ncat || true)

    locale-gen --purge "en_US.UTF-8"
    printf 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' >> /etc/default/locale
    dpkg-reconfigure locales

    cd /usr/src/glibc
    tar xf glibc-*.tar.xz
    mkdir glibc_dbg && cd glibc_dbg
    ../glibc-*/configure --prefix $PWD --enable-debug
    make -j$(nproc) > /dev/null
    make -j$(nproc) clean > /dev/null

    rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
    set -eux
    apt-get update
    LIBS="libncurses-dev libssl-dev libffi-dev cargo ninja-build meson"
    apt-get -qqq install -y --no-install-recommends $LIBS 

    YNETD_VERSION=v0.14
    wget -qO /tmp/ynetd.zip https://github.com/rwstauner/ynetd/releases/download/$YNETD_VERSION/ynetd-linux-amd64.zip
    unzip -d /usr/local/bin/ /tmp/ynetd.zip
    rm -f /tmp/ynetd.zip

    python -m pip install --no-cache-dir -U \
        setuptools
    python -m pip install --no-cache-dir -U \
        pwntools unicorn capstone ropper keystone-engine ptrlib \
        pycryptodome tqdm joblib

    VERSION_ID=$(grep '^VERSION_ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    case "$VERSION_ID" in
        "20.04")
            gem install --no-document elftools:1.2.0 one_gadget:1.9.0
            ;;
        *)
            gem install --no-document one_gadget
            ;;
    esac
    
    gem install --no-document seccomp-tools

    wget -O /opt/gdbinit-gef.py -q https://gef.blah.cat/py

    cd /opt && git clone https://github.com/pwndbg/pwndbg && cd pwndbg
    case "$VERSION_ID" in
        "20.04")
            git checkout 2024.08.29
            curl -sSL https://install.python-poetry.org | python3 - --version 1.8.5
            export PATH="/root/.local/bin:$PATH"
            ;;
        *)
            ;;
    esac
    ./setup.sh

    cd /opt && git clone https://github.com/jerdna-regeiz/splitmind

    cd /opt
    git clone --depth=1 https://github.com/radareorg/radare2
    radare2/sys/install.sh
    r2pm -U
    r2pm -ci r2ghidra || true
    r2pm -ci r2dec || true
    python -m pip install --no-cache-dir -U r2pipe

    apt-get remove -y --auto-remove $LIBS
    apt-get purge --auto-remove $LIBS
    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

COPY ./root/ /root/

RUN <<EOF
    set -eux
    echo set substitute-path ../ /usr/src/glibc/glibc-*/ | tee -a ~/.gdbinit
    echo set substitute-path ./ /usr/src/glibc/glibc-*/ | tee -a ~/.gdbinit
EOF

CMD ["/usr/bin/zsh"]
