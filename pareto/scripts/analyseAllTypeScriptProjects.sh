#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

$dir/analyseTypeScriptProject.sh ../api/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../bin/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../lib/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../res/tsconfig.json && \
$dir/analyseTypeScriptProject.sh ../test/tsconfig.json