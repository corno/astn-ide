#!/usr/bin/env bash

if [ -d "$1" ]
then
    rm -rf "$1/dist" && \
    tsc -p "$1"
fi