#!/usr/bin/env bash

if [ -d $1 ]
then
    pushd $1 && \
    ncu -u --packageFile package.json && \
    nsi && \
    popd
fi