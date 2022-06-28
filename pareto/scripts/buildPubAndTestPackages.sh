#!/usr/bin/env bash
scriptDir=`realpath $(dirname "$0")`

$scriptDir/buildPackage.sh $(pwd)/../api && \
$scriptDir/setContentFingerprint.sh $(pwd)/../api && \
$scriptDir/buildPackage.sh $(pwd)/../lib && \
$scriptDir/setContentFingerprint.sh $(pwd)/../lib && \

#only execute these 2 if the build was successful
{
    find ../lib/dist/esc/bin/* ../lib/dist/bin/* -name "*.js" -exec chmod 777 {} + 2> /dev/null
    $scriptDir/buildPackage.sh $(pwd)/../test
}