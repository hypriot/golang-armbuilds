#!/bin/bash
set -ex

# log infos about Linux kernel, OS system release and gcc version
uname -a
cat /etc/*release
gcc --version

# fetch Go 1.4.x source tarball
GOARM=${GOARM:-7}
GO_VERSION=${GO_VERSION:-1.4.3}
rm -fr /usr/local/go
curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.src.tar.gz" | tar xz -C /usr/local

# now compile Go 1.4.x and package it as a tarball
pushd /usr/local/go/src
if [ "x${SKIP_TESTS}" != "x" ]; then
  echo "Compile Go, skip tests."
  time ./make.bash 2>&1
else
  echo "Compile Go, run tests."
  time ./all.bash 2>&1
fi
cd ../..
tar --numeric-owner -czf "go${GO_VERSION}.linux-armv${GOARM}.tar.gz" go
popd
mv "/usr/local/go${GO_VERSION}.linux-armv${GOARM}.tar.gz" .

# cleanup
rm -fr /usr/local/go
