FROM debian:stable-slim

ENV PLATFORM="docker"
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

EXPOSE 8080 8081 8082 8083 8084 8085

# core packages

RUN apt-get update && apt-get -y install --no-install-recommends \
    apt-transport-https \
    autoconf \
    automake \
    ca-certificates \
    cmake \
    coreutils \
    curl \
    locales \
    doxygen \
    g++ \
    gettext \
    git \
    gnupg \
    libtool \
    libtool-bin \
    make \
    pkg-config \
    sudo \
    tar \
    unzip \
    wget \
    zip \
    openssh-client \
    python3-pip \
    openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales

RUN python3 -m pip install --no-cache-dir ansible==9.5.1  pynvim --break-system-packages

COPY . /root/.config
RUN ansible-playbook /root/.config/bootstrap.ansible.yml

RUN chsh -s "$(which zsh)" root

RUN mkdir -p /root/workspace

# EXPOSE 22
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

CMD ["tail", "-f", "/dev/null"]
