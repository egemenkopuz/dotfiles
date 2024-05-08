FROM debian:stable-slim

ENV PLATFORM="docker"
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get -y install --no-install-recommends \
    locales \
    git \
    sudo \
    python3-pip \
    openssh-client \
    openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales

ENV PIP_BREAK_SYSTEM_PACKAGES 1
RUN python3 -m pip install --no-cache-dir ansible==9.5.1

COPY . /root/.config

WORKDIR /root/.config
RUN ansible-playbook /root/.config/setup.ansible.yml

RUN chsh -s "$(which zsh)" root

RUN mkdir -p /root/workspace
WORKDIR /root

# EXPOSE 22
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 8080 8081 8082 8083 8084 8085

CMD ["tail", "-f", "/dev/null"]

