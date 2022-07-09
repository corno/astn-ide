#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

"$dir/updatePackage.sh" ../dev
"$dir/updatePackage.sh" ../api
"$dir/updatePackage.sh" ../lib
"$dir/updatePackage.sh" ../res
"$dir/updatePackage.sh" ../test
"$dir/updatePackage.sh" ../bin