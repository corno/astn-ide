#!/usr/bin/env bash

cd "../$1"


name=$(npm pkg get name | cut -c2- | rev | cut -c2- |rev) 
localFingerprint=$(npm pkg get content-fingerprint | cut -c2- | rev | cut -c2- |rev)
remoteFingerprint=$(npm view $name@latest content-fingerprint)

if [ $localFingerprint != $remoteFingerprint ]
then
    echo "NOT EQUAL!!!!!!!!!!!!!!!!!!!!!!"
fi

echo $localFingerprint $remoteFingerprint       