#!/usr/bin/env bash

if [ -d $1 ]
then
    pushd $1 > /dev/null && \
    ncu -u --packageFile package.json && \
    nsi && \
    popd
fi