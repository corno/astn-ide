#!/usr/bin/env bash
pushd $1 && \
ncu -u --packageFile package.json && \
nsi && \
popd