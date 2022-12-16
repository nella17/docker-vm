FROM ubuntu:tag

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/bin:${PATH}"
ENV LANG="en_US.UTF-8"

COPY root /root

RUN : \
    && apt-get update \
    && apt-get install -y -qqq --no-install-recommends \
      sudo file less zsh tmux git vim wget curl rsync htop zip unzip \
      strace ltrace tree make cmake elfutils netcat locales net-tools \
      binutils g++ g++-multilib musl-tools nasm gdb patchelf \
      lib32z1 libseccomp-dev \
      build-essential perl openssl ruby-dev socat \
      python3-dev python3-pip \
      glibc-source gawk bison \
    && ln -sf python3 /usr/bin/python \
    \
    && locale-gen --purge "en_US.UTF-8" \
    && printf 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' >> /etc/default/locale \
    && dpkg-reconfigure locales \
    \
    && wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py \
    \
    && YNETD_VERSION=v0.14 \
    && wget -qO /tmp/ynetd.zip https://github.com/rwstauner/ynetd/releases/download/$YNETD_VERSION/ynetd-linux-amd64.zip \
    && unzip -d /usr/local/bin/ /tmp/ynetd.zip \
    && rm -f /tmp/ynetd.zip \
    \
    && python -m pip install --no-cache-dir -U pip setuptools wheel \
    && apt-get install -y -qqq --no-install-recommends \
        libncurses-dev libssl-dev libffi-dev cargo \
    && python -m pip install --no-cache-dir -U pwntools unicorn capstone ropper keystone-engine \
            pycryptodome \
    && apt-get remove -y --auto-remove \
        libncurses-dev libssl-dev libffi-dev cargo \
    && apt-get purge --auto-remove \
        libncurses-dev libssl-dev libffi-dev cargo \
    && apt-get clean \
    \
    && gem install --no-document one_gadget seccomp-tools \
    \
    && cd /usr/src/glibc \
    && tar xvf glibc-*.tar.xz \
    && mkdir glibc_dbg && cd glibc_dbg \
    && ../glibc-*/configure --prefix $PWD --enable-debug \
    && nproc \
    && make -j$(nproc) > /dev/null \
    \
    && rm -rf /var/lib/apt/lists/* \
    && :

# RUN cd /root && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh

CMD ["/usr/bin/zsh"]
