#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

$dir/updatePackage.sh .
$dir/updatePackage.sh ../api
$dir/updatePackage.sh ../lib
$dir/updatePackage.sh ../test

$dir/copyTemplate.sh
if [ -d "../dev" ]
then
    $dir/updatePackage.sh "../dev"
fi
