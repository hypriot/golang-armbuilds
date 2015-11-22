#!/bin/bash

# --- build all version of Go1.4
# interate over all available Go1.4 versions
go14_list=( 1.4 1.4.1 1.4.2 1.4.3 )
for go14 in "${go14_list[@]}"
do
  # interate over all available GOARM versions
  goarm_list=( 5 6 7 )
  for goarm in "${goarm_list[@]}"
  do
    export GOARM=${goarm}
    export GO_VERSION=${go14}
    echo "./make-tarball-go1.4.sh | tee make-tarball-go${GO_VERSION}-armv${GOARM}.log"
  done
done

# --- build all version of Go1.5
# interate over all available Go1.5 versions
go15_list=( 1.5 1.5.1 )
for go15 in "${go15_list[@]}"
do
  # interate over all available GOARM versions
  goarm_list=( 5 6 7 )
  for goarm in "${goarm_list[@]}"
  do
    export GOARM=${goarm}
    export GO_VERSION=${go15}
    echo "./make-tarball-go1.5.sh | tee make-tarball-go${GO_VERSION}-armv${GOARM}.log"
  done
done

