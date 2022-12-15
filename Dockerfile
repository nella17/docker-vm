FROM ubuntu:tag

RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
      apt-get install -y -qqq --no-install-recommends \
      sudo file less zsh tmux git vim wget curl rsync htop zip unzip \
      strace ltrace tree make cmake elfutils netcat locales net-tools \
      binutils g++ g++-multilib musl-tools nasm gdb \
      lib32z1 libseccomp-dev \
      build-essential perl openssl ruby-dev socat \
      python3-dev python3-pip \
    && ln -sf python3 /usr/bin/python \
    \
    && locale-gen --purge "en_US.UTF-8" \
    && printf 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' >> /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    \
    && python -m pip install --no-cache-dir -U pip setuptools wheel \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -qqq --no-install-recommends \
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
    && rm -rf /var/lib/apt/lists/* \
    && :

# RUN cd /root && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh

COPY root /root

ENV PATH="/root/bin:${PATH}"
ENV LANG="en_US.UTF-8"

CMD ["/usr/bin/zsh"]
