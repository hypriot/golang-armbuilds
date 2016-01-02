#!/bin/bash

# --- build all version of Go1.5
# interate over all available Go1.5 versions
go15_list=( 1.5 1.5.1 1.5.2 )
go15_list=( 1.5.1 1.5.2 )
for go15 in "${go15_list[@]}"
do
  export GO_VERSION=${go15}
  time ./make-tarball-go1.5-arm64.sh | tee "make-tarball-go${GO_VERSION}-arm64.log"
done
