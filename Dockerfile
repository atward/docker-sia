FROM ubuntu:16.04

ENV SIA_VERSION 1.2.2
ENV SIA_PACKAGE Sia-v$SIA_VERSION-linux-amd64
ENV SIA_ZIP ${SIA_PACKAGE}.zip
ENV SIA_RELEASE https://github.com/NebulousLabs/Sia/releases/download/v$SIA_VERSION/$SIA_ZIP
ENV SIA_DIR /opt/$SIA_PACKAGE

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && apt-get install -y wget unzip coreutils && \
    wget $SIA_RELEASE && \
    unzip $SIA_ZIP -d /opt && \
    echo export PATH=\$PATH:/opt/$SIA_PACKAGE >> /etc/profile.d/sia.sh

# Only expose ports 9981 and 9982.
# 9980, is for security reasons, not exposed.
EXPOSE 9981-9982

WORKDIR $SIA_DIR

CMD ./siad -M gctwh -d /mnt/sia & /bin/bash -l
