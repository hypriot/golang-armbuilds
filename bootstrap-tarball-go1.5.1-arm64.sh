#!/bin/bash
set -ex

# log infos about Linux kernel, OS system release and gcc version
uname -a
cat /etc/*release
gcc --version

# we need this env var for the Go 1.5.x bootstrap build process
GOROOT_BOOTSTRAP=$HOME/go1.5

# install a pre-compiled Go 1.5.x tarball to bootstrap
GO_BOOTSTRAP_GOARM=${GO_BOOTSTRAP_GOARM:-7}
GO_BOOTSTRAP_VERSION=${GO_BOOTSTRAP_VERSION:-1.5.1}
rm -fr "$GOROOT_BOOTSTRAP"
mkdir -p "$GOROOT_BOOTSTRAP"
curl -sSL "https://github.com/hypriot/golang-armbuilds/releases/download/v${GO_BOOTSTRAP_VERSION}/go${GO_BOOTSTRAP_VERSION}.linux-armv${GO_BOOTSTRAP_GOARM}.tar.gz" | tar xz -C "$GOROOT_BOOTSTRAP" --strip-components=1

# clone Go 1.5.x source
GO_VERSION=${GO_VERSION:-1.5.1}
rm -fr "$HOME/go"
git clone https://go.googlesource.com/go "$HOME/go"

# now compile Go 1.5.x and package it as a tarball
pushd "$HOME/go/src"
git checkout release-branch.go1.5
echo "Bootstrap Go for linux/arm64."
rm -fr ../../go-linux-arm64-bootstrap
time GOROOT_BOOTSTRAP="$HOME/go1.5" GOOS=linux GOARCH=arm64 ./bootstrap.bash 2>&1
#echo "Bootstrap Go for linux/ppc64"
#rm -fr ../../go-linux-ppc64-bootstrap
#time GOROOT_BOOTSTRAP=$HOME/go1.5 GOOS=linux GOARCH=ppc64 ./bootstrap.bash 2>&1
cd ../..
pwd
ls -al go-linux-*-bootstrap.tbz
popd
mv "$HOME/go-linux-*-bootstrap.tbz" .

# cleanup
rm -fr "$HOME/go"
rm -fr "$HOME/go1.5"
rm -fr "$HOME/go-linux-*-bootstrap"
