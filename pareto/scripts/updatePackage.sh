#!/usr/bin/env bash

part="../$1"

if [ -d "$part" ]
then
    npx npm-check-updates -u --packageFile "$part/package.json" && \
    npx npm-safe-install -t "$part/"
fi