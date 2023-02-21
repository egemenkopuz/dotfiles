FROM debian:stable-slim as core-builder

ARG NVIM_BUILD=nightly
ARG USER_NAME=user

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
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales

FROM core-builder as general-builder

# general packages

RUN curl -L -O "https://github.com/neovim/neovim/releases/download/${NVIM_BUILD}/nvim-linux64.deb"
RUN apt-get -y install --no-install-recommends ./nvim-linux64.deb && rm ./nvim-linux64.deb

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

RUN apt-get update && apt-get -y install --no-install-recommends \
    fzf \
    zsh \
    zoxide \
    ripgrep \
    tmux \
    python3-pip \
    python3-venv \
    nodejs \
    exa \
    fd-find \
    bat \
    xclip \
    tree \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -L -sLo go.tar.gz https://go.dev/dl/go1.19.4.linux-amd64.tar.gz \
    && tar -C /usr/local/bin -xzf go.tar.gz \
    && rm go.tar.gz

# user config

RUN adduser --disabled-password --gecos '' ${USER_NAME} \
    && adduser ${USER_NAME} sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chsh -s "$(which zsh)" ${USER_NAME}

FROM general-builder as user

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

ENV PATH=/home/${USER_NAME}/.local/bin:/usr/local/bin/go/bin:/home/${USER_NAME}/go/bin:$PATH

# user packages

COPY --chown=${USER_NAME}:${USER_NAME} . ./.config

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN make -C ./.config/ docker-dependencies \
    && source ~/.zshenv

RUN pip3 install --no-cache-dir --user virtualenv black isort flake8 pydocstyle mypy pynvim
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN go install github.com/jesseduffield/lazygit@latest

CMD ["tail", "-f", "/dev/null"]
