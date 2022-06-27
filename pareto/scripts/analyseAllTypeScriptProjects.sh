#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`
if [ -d "../dev" ]
then
    $dir/analyseTypeScriptProject.sh ../dev/tsconfig.json
fi && \

$dir/analyseTypeScriptProject.sh ../api/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../lib/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../test/tsconfig.json