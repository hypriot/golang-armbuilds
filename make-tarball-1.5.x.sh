#!/bin/bash
set -ex

GOARM=${GOARM:-7}

# we need this env var for the Go 1.5.x bootstrap build process
GOROOT_BOOTSTRAP=$HOME/go1.4 

# install a pre-compiled Go 1.4.x tarball to bootstrap
GO_BOOTSTRAP_VERSION=${GO_BOOTSTRAP_VERSION:-1.4.3}
rm -fr $GOROOT_BOOTSTRAP
mkdir -p $GOROOT_BOOTSTRAP
curl -sSL https://github.com/hypriot/golang-armbuilds/releases/download/v${GO_BOOTSTRAP_VERSION}/go${GO_BOOTSTRAP_VERSION}.linux-armv${GOARM}.tar.gz | tar xz -C $GOROOT_BOOTSTRAP --strip-components=1

# fetch Go 1.5.x source tarball
GO_VERSION=${GO_VERSION:-1.5.1}
rm -fr /usr/local/go
curl -sSL https://storage.googleapis.com/golang/go${GO_VERSION}.src.tar.gz | tar xz -C /usr/local

# now compile Go 1.5.x and package it as a tarball
pushd /usr/local/go/src
#time ./all.bash 2>&1
time ./make.bash 2>&1
cd ../..
tar cfz go${GO_VERSION}.linux-armv${GOARM}.tar.gz go
popd
mv /usr/local/go${GO_VERSION}.linux-armv${GOARM}.tar.gz .

# cleanup
rm -fr $GOROOT_BOOTSTRAP
rm -fr /usr/local/go
