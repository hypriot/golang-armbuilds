# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Add build script
ADD make-tarball-go1.4.sh /

# Compile Go 1.4 and package as a tarball
ARG GOARM
ARG GO_VERSION
RUN /make-tarball-go1.4.sh
