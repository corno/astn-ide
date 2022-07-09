#!/usr/bin/env bash
scriptDir=`realpath $(dirname "$0")`

#api
$scriptDir/buildPackage.sh "$(pwd)/../api" && \
$scriptDir/setContentFingerprint.sh "$(pwd)/../api" && \

#lib
$scriptDir/buildPackage.sh "$(pwd)/../lib" && \
$scriptDir/setContentFingerprint.sh "$(pwd)/../lib" && \


#res
$scriptDir/buildPackage.sh "$(pwd)/../res" && \
$scriptDir/setContentFingerprint.sh "$(pwd)/../res" && \

#test
$scriptDir/buildPackage.sh "$(pwd)/../test" && \

#bin
$scriptDir/buildPackage.sh "$(pwd)/../bin" && \
$scriptDir/setContentFingerprint.sh "$(pwd)/../bin" && \

if [ -d "$(pwd)/../bin" ]
then
    find ../bin/dist/bin/* -name "*.js" -exec chmod 777 {} +
fi
