# golang-armbuilds
Pre-compiled GOLANG tarballs for ARM devices.

In this repo we'd like to document all steps how to compile the GOLANG compiler from source and package
the results as pre-compiled tarballs. So everyone can easily reproduce these steps on a bare ARM Linux machine
without the need of having Go already installed. You can use this informations to compile Go on all different
CPU architectures as well.

To make a developers live even easier, we're providing in the [release section](https://github.com/hypriot/golang-armbuilds/releases)
all pre-compiled Go tarballs for all supported ARM versions:
- ARMv5
- ARMv6 (Raspberry Pi A, A+, B, B+, Zero)
- ARMv7 (Raspberry Pi 2, Scaleway C1)
- ARM64 (which is also known as AARCH64)


## How to install and use a pre-compiled GOLANG tarball
Just download the correct tarball for your ARM CPU from the [release section](https://github.com/hypriot/golang-armbuilds/releases)
and install it to `/usr/local/go`, set the `PATH` env variable and you can instantly start to compile your Go programs.
```
tar -xvzf go1.5.1.linux-armv7.tar.gz -C /usr/local
export PATH=/usr/local/go/bin:$PATH
```

Now let's test if it works.
```
which go
/usr/local/go/bin/go

go version
go version go1.5.1 linux/arm
```

Don't forget to set the `PATH` env variable within your `~/.bashrc` or `~/.profile` as well for your Linux user account.  
You can use this code snipped:
```
# set PATH so it includes GO bin if it exists
if [ -d "/usr/local/go/bin" ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi
```

## How to create a pre-compiled GOLANG 1.4 tarball
Unfortunately there are no pre-compiled GOLANG tarballs for ARM officially available yet and
the preferred way to build such a tarball from source isn't well documented at all.

This is a simple approach to compile Go from source and package it as a tarball. This tarball
should work like the official tarballs from the [GOLANG download page](https://golang.org/dl/).
For the sake of simplicity this build steps are meant to be used on a freshly installed Linux
distro on any ARM machine.

Please feel free to use this build recipe and report any issues AND when you could
successfully build Go on a new machine. And don't forget to send us this informations
so we can include this machine to the list of supported devices!

### 1. Prepare the build machine

Just install all necessary packages, for details see the official guide
[Installing Go from source](https://golang.org/doc/install/source).
At least you'll need `gcc` to compile Go 1.4 from source and additionally `curl` and `git`.

For a [Scaleway](https://www.scaleway.com) C1 server (Ubuntu 15.04): ARMv7
```
apt-get update
apt-get install -y build-essential
```

For a Raspberry Pi A, A+, B, B+ (HypriotOS 0.6.1 "hector"): ARMv6  
For a Raspberry Pi 2B (HypriotOS 0.6.1 "hector"): ARMv7
```
apt-get update
apt-get install -y build-essential
```

For a Nvidia Jetson TK1 (Ubuntu 14.04.1 LTS): ARMv7
```
apt-get update
apt-get install -y build-essential
```

### 2. Clone this repo
```
git clone https://github.com/hypriot/golang-armbuilds.git
cd golang-armbuilds
```

### 3. Run the compile script
Here you can easily parameterize your build with `GOARM` (5, 6, 7. Default=7) and
`GO_VERSION` (1.4, 1.4.1, 1.4.2, 1.4.3. Default=1.4.3) variables.
```
./make-tarball-go1.4.sh |& tee make-tarball-go1.4.3-armv7.log

export GO_VERSION=1.4.2 && ./make-tarball-go1.4.sh |& tee make-tarball-go${GO_VERSION}-armv7.log

export GOARM=5 GO_VERSION=1.4.1 && ./make-tarball-go1.4.sh |& tee make-tarball-go${GO_VERSION}-armv${GOARM}.log
```

While compiling GOLANG from source all the tests will be run by default, which
will take a lot of time. If you'd just like to create the binary tarball without
actually running the full test suite, you can easily skip the tests by setting
the env variable `SKIP_TESTS` to anything.
```
export SKIP_TESTS=1
```
On some of the Linux ARM devices the tests are failing! So keep this option in
mind and deactivate testing.

### 4. Use it directly or upload the created tarball to GitHub releases
```
go1.4.3.linux-armv5.tar.gz
go1.4.3.linux-armv6.tar.gz
go1.4.3.linux-armv7.tar.gz
```


## How to create a pre-compiled GOLANG 1.5 tarball
In order to build Go 1.5 from source, we need to have at least a Go 1.4 version installed on
our dev machine and additionally `curl` and `git`. For this reason we just install our pre-compiled
Go 1.4 tarball and use it to bootstrap Go 1.5 with it.

### 1. Prepare the build machine

Just install all necessary packages, for details see the official guide
[Installing Go from source](https://golang.org/doc/install/source).

For a [Scaleway](https://www.scaleway.com) C1 server (Ubuntu 15.04): ARMv7
```
apt-get update
apt-get install -y build-essential
```

For a Raspberry Pi A, A+, B, B+ (HypriotOS 0.6.1 "hector"): ARMv6  
For a Raspberry Pi 2B (HypriotOS 0.6.1 "hector"): ARMv7
```
apt-get update
apt-get install -y build-essential
```

For a Nvidia Jetson TK1 (Ubuntu 14.04.1 LTS): ARMv7
```
apt-get update
apt-get install -y build-essential
```

### 2. Clone this repo
```
git clone https://github.com/hypriot/golang-armbuilds.git
cd golang-armbuilds
```

### 3. Run the compile script
Here you can easily parameterize your build with `GOARM` (5, 6, 7. Default=7)
and `GO_VERSION` (1.5, 1.5.1. Default=1.5.1) variables.

For bootstrapping Go1.5 we need to install Go1.4 first, which is also able to parameterize with
`GO_BOOTSTRAP_GOARM` (5, 6, 7. Default=7)
and `GO_BOOTSTRAP_VERSION` (1.4, 1.4.1, 1.4.2, 1.4.3. Default=1.4.3).
```
export GOARM=5 && ./make-tarball-go1.5.sh |& tee make-tarball-go1.5.1-armv${GOARM}.log
export GOARM=6 && ./make-tarball-go1.5.sh |& tee make-tarball-go1.5.1-armv${GOARM}.log
export GOARM=7 && ./make-tarball-go1.5.sh |& tee make-tarball-go1.5.1-armv${GOARM}.log
```

### 4. Use it directly or upload the created tarball to GitHub releases
```
go1.5.1.linux-armv5.tar.gz
go1.5.1.linux-armv6.tar.gz
go1.5.1.linux-armv7.tar.gz
```


## Building within a Docker container
```
docker build --build-arg GOARM=7 --build-arg GO_VERSION=1.4.3 -t golang-builder -f Dockerfile.arm .
docker run --rm golang-builder tar cf - go1.4.3.linux-armv7.tar.gz | tar xvf -
```


## Known issues
On Scaleway one of the GOLANG tests are already failing:
```
--- FAIL: TestFilePacketConn (0.01s)
	file_test.go:121: WriteTo failed: write ip: bad address
FAIL
FAIL	net	3.108s
```
This failure seems to be already documented in https://github.com/golang/go/issues/10730.


## TODO
- [x] include the standard GOLANG tests for all builds
- [x] run builds for ARMv5, ARMv6 and ARMv7
- [ ] automate builds via CI/CD (travis or circle-ci)
- [ ] cleanup README.md
- [x] detailed documentation for building GOLANG from scratch, see http://blog.hypriot.com/post/how-to-compile-go-on-arm/
- [ ] detailed documentation for setting up a CI build pipeline


## Additional sources for building GOLANG on ARM
- GoArm Wiki, https://github.com/golang/go/wiki/GoArm
- Build from source, http://dave.cheney.net/2015/09/04/building-go-1-5-on-the-raspberry-pi by Dave Cheney
- Cross compile, http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5 by Dave Cheney
- Unofficial ARM tarballs for Go, http://dave.cheney.net/unofficial-arm-tarballs by Dave Cheney
- Issue golang/go/#13066: build: provide ARM release binaries?, https://github.com/golang/go/issues/13066


# Acknowledgements
Many thanks to the GOLANG team at Google and all maintainers and contributers.
