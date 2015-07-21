#!/bin/bash -ex

export PACKER_PLUGIN=packer-post-processor-docker-dockerfile
export DEBIAN_FRONTEND=noninteractive

apt-get update -qq && apt-get install -y --no-install-recommends mercurial

test -d $PACKER_PLUGIN && rm -fr $PACKER_PLUGIN

git clone https://github.com/avishai-ish-shalom/packer-post-processor-docker-dockerfile.git $PACKER_PLUGIN

pushd $PACKER_PLUGIN

export GOPATH=$(pwd)

go get github.com/nitrous-io/goop && go build github.com/nitrous-io/goop

./goop install && ./goop go build

cp $PACKER_PLUGIN /usr/bin/$PACKER_PLUGIN

popd

rm -fr $PACKER_PLUGIN
