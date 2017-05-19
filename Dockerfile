FROM ubuntu:16.04

ENV SIA_VERSION 1.2.1
ENV SIA_PACKAGE Sia-v$SIA_VERSION-linux-amd64
ENV SIA_ZIP ${SIA_PACKAGE}.zip
ENV SIA_RELEASE https://github.com/NebulousLabs/Sia/releases/download/v$SIA_VERSION/$SIA_ZIP
ENV SIA_DIR /opt/$SIA_PACKAGE

RUN apt-get update && apt-get install -y wget unzip && \
    wget $SIA_RELEASE && \
    unzip $SIA_ZIP -d /opt

# Only expose ports 9981 and 9982.
# 9980, is for security reasons, not exposed.
EXPOSE 9981-9982

WORKDIR $SIA_DIR

# Specify the Sia directory as /mnt/sia
# And binds the api to 127.0.0.1:9980 to increase security.
ENTRYPOINT printf "a\n" | ./siad --sia-directory /mnt/sia --authenticate-api
