#!/usr/bin/env bash

if [ -d "../dev" ]
then
    "$(dirname "$0")"/buildDevPackage.sh && \
    rm -rf ../api/src/generated && \
    rm -rf ../lib/src/generated && \
    node ../dev/dist/esc/bin/generateCode.js ..
fi \


"$(dirname "$0")"/buildPubAndTestPackages.sh && \
if [ -d "../test" ]
then
    node ../test/dist/esc/bin/index.js ../test/data
fi \

