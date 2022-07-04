#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`

#make sure everything is pushed
git push && \

#validate that everything is committed and pushed (to make sure we're not messing with open work with updatePackage)
git diff --exit-code && git log origin/master..master --exit-code && \

#make sure latest packages are installed
"$dir/updatePackage.sh" "../$2" && \

#buildAndTest
"$dir/buildAndTest.sh" && \

#validate that everything is still committed after the update and build
git diff --exit-code && \

#bump version and store in variable
pushd "../$2" > /dev/null && \
newVersion=$(npm version "$1") && \
popd && \

#commit package.json with new version number
git add .. && \
git commit -m "$2 version bumped to $newVersion" && \

#create a tag
git tag -a "$2-$newVersion" -m "$2:$newVersion" && \
git push && \

#publish
pushd "../$2" > /dev/null && \
npm publish && \
popd
