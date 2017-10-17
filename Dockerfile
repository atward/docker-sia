FROM ubuntu:16.04

ENV SIA_VERSION 1.3.0
ENV SIA_PACKAGE Sia-v$SIA_VERSION-linux-amd64
ENV SIA_ZIP ${SIA_PACKAGE}.zip
ENV SIA_RELEASE https://github.com/NebulousLabs/Sia/releases/download/v$SIA_VERSION/$SIA_ZIP
ENV SIA_DIR /opt/$SIA_PACKAGE

# Only expose ports 9981 and 9982.
# 9980, is for security reasons, not exposed.
EXPOSE 9981-9982

WORKDIR $SIA_DIR

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && apt-get install -y wget unzip coreutils vim less
RUN wget $SIA_RELEASE && \
    unzip $SIA_ZIP -d /opt && \
    echo export PATH=\$PATH:/opt/$SIA_PACKAGE >> /etc/profile.d/sia.sh
#	&& $SIA_DIR/siac bash-completion /etc/bash_completion.d/siac

RUN apt-get install -y rsync zsh lsof
RUN wget -O /usr/bin/tmpfs-sync https://raw.githubusercontent.com/atward/tmpfs-syncer/master/tmpfs-sync && \
    chmod a+x /usr/bin/tmpfs-sync

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
