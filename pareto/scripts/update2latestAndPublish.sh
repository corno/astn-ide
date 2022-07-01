#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

#validate that everything is committed and pushed (to make sure we're not messing with open work with updatePackage)
git diff --exit-code && git log origin/master..master --exit-code && \

"$dir/update2latestBuildEnvironment.sh" && \
"$dir/update2latestDependencies.sh" && \
"$dir/buildAndTest.sh" && \
git commit -am "u2l" && \
"$dir/publish.sh" "$1"