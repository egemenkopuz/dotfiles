FROM debian:stable-slim

ARG USER_NAME=user

ENV PLATFORM="docker"

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

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
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales

# general packages

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

RUN git clone https://github.com/neovim/neovim
WORKDIR /neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo && git checkout stable && make install

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

# user config

RUN adduser --disabled-password --gecos '' ${USER_NAME} \
    && adduser ${USER_NAME} sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chsh -s "$(which zsh)" ${USER_NAME}

RUN mkdir /home/${USER_NAME}/.ssh
RUN chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.ssh \
   && chmod 700 /home/${USER_NAME}/.ssh

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

ENV PATH=/home/${USER_NAME}/.local/bin:/usr/local/bin/go/bin:/home/${USER_NAME}/go/bin:/home/${USER_NAME}/.cargo/bin:$PATH

COPY --chown=${USER_NAME}:${USER_NAME} . ./.config
# COPY --chown=${USER_NAME}:${USER_NAME} id_rsa /home/${USER_NAME}/.ssh

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN make -C ./.config/

CMD ["tail", "-f", "/dev/null"]
