#!/bin/bash

# --- build all version of Go1.4
# interate over all available Go1.4 versions
go14_list=( 1.4 1.4.1 1.4.2 1.4.3 )
go14_list=( 1.4.3 )
for go14 in "${go14_list[@]}"
do
  export GO_VERSION=${go14}
  export GOARM=6
  time SKIP_TESTS=y ./make-tarball-go1.4.sh | tee "make-tarball-go${GO_VERSION}-armv${GOARM}.log"
done

# --- build all version of Go1.5
# interate over all available Go1.5 versions
go15_list=( 1.5 1.5.1 1.5.2 )
go15_list=( 1.5.1 1.5.2 )
for go15 in "${go15_list[@]}"
do
  export GO_VERSION=${go15}
  export GO_BOOTSTRAP_GOARMV=v6
  export GO_BOOTSTRAP_VERSION=1.4.3
  export GOARMV=v6
  time SKIP_TESTS=y ./make-tarball-go1.5.2.sh | tee "make-tarball-go${GO_VERSION}-arm${GOARM}.log"
done
