#!/usr/bin/env bash
dir=`realpath $(dirname "$0")`
cp -R ./node_modules/pareto-ts-validator-lib/data/projectTemplate/. .. \

#npm messes with .gitignore, that's why I need to handle it separately
cp ./node_modules/pareto-ts-validator-lib/data/gitignore ../.gitignore \



if [ -d "../api/" ]
then
    cp ./node_modules/pareto-ts-validator-lib/data/tsconfig.json ../api/
    cp ./node_modules/pareto-ts-validator-lib/data/_apiGlobals.ts ../api/src/
fi

if [ -d "../lib/" ]
then
    nativeFlag=$(npm --prefix "../lib" pkg get native )
    if [ $nativeFlag != "true" ]
    then
        cp ./node_modules/pareto-ts-validator-lib/data/tsconfig.json ../lib/
        cp ./node_modules/pareto-ts-validator-lib/data/_libGlobals.ts ../lib/src/
    fi
fi

parts=("bin" "test")
for part in "${parts[@]}"
do
    if [ -d "../$part/" ]
    then
        cp ./node_modules/pareto-ts-validator-lib/data/tsconfig.json "../$part/"
        cp ./node_modules/pareto-ts-validator-lib/data/_libGlobals.ts "../$part/src/"
    fi

done

#update this package because the copied package.json contains an old version of pareto-ts-validator-lib (by design, the template is not updated every time the package is published)
"$dir/updatePackage.sh" .
