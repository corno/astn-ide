#!/usr/bin/env bash

if [ -d "$1" ]
then
    npx npm-check-updates -u --packageFile "$1/package.json" && \
    npx npm-safe-install -t "$1/"
fi