#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

"$dir/updatePackage.sh" pareto

"$dir/copyTemplate.sh"
