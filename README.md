# golang-armbuilds
Pre-compiled GOLANG tarballs for ARM devices.


## How to create a pre-compiled GOLANG 1.4 tarball
Unfortunately there are no pre-compiled GOLANG tarballs for ARM officially available yet and
the preferred way to build such a tarball from source isn't well documented at all.

This is a simple approach to compile Go from source and package it as a tarball. This tarball
should work like the official tarballs from the [GOLANG download page](https://golang.org/dl/).
For the sake of simplicity this build steps are meant to be used on a freshly installed Linux
distro on any ARM machine.

Please feel free to use this build recipe and report any issues AND when you could
successfully build Go on a new machine send us this information so we can include this machine
to the list of supported devices!

### 1. Prepare the build machine

   Just install all necessary packages, for details see the official guide
   [Installing Go from source](https://golang.org/doc/install/source).
   At least you'll need `gcc` to compile Go 1.4 from source.

   For a [Scaleway](https://www.scaleway.com) C1 server (Ubuntu 15.04):
   ```
   apt-get update
   apt-get install -y curl git gcc
   ```

### 2. Clone this repo
```
git clone https://github.com/hypriot/golang-armbuilds.git
cd golang-armbuilds
```

### 3. Run the compile script
```
./make-tarball-go1.4.sh | tee make-tarball-go1.4.3-armv7.log
```

### 4. Use it directly or upload the created tarball to GitHub releases
```
go1.4.3.linux-armv7.tar.gz
```


## How to create a pre-compiled GOLANG 1.5 tarball
In order to build Go 1.5 from source, we need to have at least a Go 1.4 version installed on
our dev machine. For this reason we just install our pre-compiled Go 1.4 tarball and use it
to bootstrap Go 1.5 with it.

### 1. Prepare the build machine

   Just install all necessary packages, for details see the official guide
   [Installing Go from source](https://golang.org/doc/install/source).

   For a [Scaleway](https://www.scaleway.com) C1 server (Ubuntu 15.04):
   ```
   apt-get update
   apt-get install -y curl git
   ```

### 2. Clone this repo
```
git clone https://github.com/hypriot/golang-armbuilds.git
cd golang-armbuilds
```

### 3. Run the compile script
```
GOARM=5 ./make-tarball-go1.5.sh | tee make-tarball-go1.5.1-armv${GOARM}.log
GOARM=6 ./make-tarball-go1.5.sh | tee make-tarball-go1.5.1-armv${GOARM}.log
GOARM=7 ./make-tarball-go1.5.sh | tee make-tarball-go1.5.1-armv${GOARM}.log
```

### 4. Use it directly or upload the created tarball to GitHub releases
```
go1.5.1.linux-armv5.tar.gz
go1.5.1.linux-armv6.tar.gz
go1.5.1.linux-armv7.tar.gz
```


## Building within a Docker container
```
docker build --build-arg GOARM=7 -t golang-builder -f Dockerfile.arm .
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


## Additional sources for building GOLANG on ARM
- GoArm Wiki, https://github.com/golang/go/wiki/GoArm
- Build from source, http://dave.cheney.net/2015/09/04/building-go-1-5-on-the-raspberry-pi by Dave Cheney
- Cross compile, http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5 by Dave Cheney
- Unofficial ARM tarballs for Go, http://dave.cheney.net/unofficial-arm-tarballs by Dave Cheney
- Issue golang/go/#13066: build: provide ARM release binaries?, https://github.com/golang/go/issues/13066


# Acknowledgements
Many thanks to the GOLANG team at Google and all maintainers and contributers.
