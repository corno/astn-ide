#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

#validate that everything is committed (to make sure we're not messing with open work with updatePackage)
git diff --exit-code && \

$dir/update2latest.sh && \
$dir/buildAndTest.sh && \
git commit -am "u2l" && \
$dir/publish.sh $1