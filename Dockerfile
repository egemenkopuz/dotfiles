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
    xclip \
    openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales

# general packages

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install
RUN rm -rf /root/TMP

RUN apt-get update && apt-get -y install --no-install-recommends \
    fzf \
    zsh \
    tmux \
    python3-pip \
    python3-venv \
    nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -L -sLo go.tar.gz https://go.dev/dl/go1.19.4.linux-amd64.tar.gz \
    && tar -C /usr/local/bin -xzf go.tar.gz \
    && rm go.tar.gz

RUN chsh -s "$(which zsh)" root

ENV PATH=/root/.local/bin:/usr/local/bin/go/bin:/root/go/bin:/root/.cargo/bin:$PATH

COPY . /root/.config
RUN mkdir -p /root/workspace

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN make -C /root/.config/

WORKDIR /root/workspace

CMD ["tail", "-f", "/dev/null"]
