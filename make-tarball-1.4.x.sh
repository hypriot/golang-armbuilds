#!/bin/bash

# fetch Go 1.4.x source tarball
GO_VERSION=1.4.3
GOARM=7
rm -fr /usr/local/go
curl -sSL https://storage.googleapis.com/golang/go${GO_VERSION}.src.tar.gz | tar xz -C /usr/local

# now compile Go 1.4.x and package it as a tarball
pushd /usr/local/go/src
time ./make.bash --no-clean 2>&1
cd ../..
tar cfz go${GO_VERSION}.linux-armv${GOARM}.tar.gz ./go
popd
mv /usr/local/go${GO_VERSION}.linux-armv${GOARM}.tar.gz .

# cleanup
rm -fr /usr/local/go
