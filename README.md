# golang-armbuilds
Pre-compiled GOLANG tarballs for ARM devices.

## How to create a pre-compiled GOLANG 1.4.x tarball
Unfortunately there are no pre-compiled GOLANG tarballs for ARM officially available yet and the preferred way to build such a tarball from source isn't well documented at all.

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
   At least you'll need `gcc` to compile Go 1.4.x from source.

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
./make-tarball-1.4.x.sh
```

### 4. Use it directly or upload the created tarball to GitHub releases
```
go1.4.3.linux-armv7.tar.gz
```

# Acknowledgements
Many thanks to the GOLANG team at Google and all maintainers and contributers.
