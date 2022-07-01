#!/usr/bin/env bash

node ./node_modules/pareto-ts-validator-lib/dist/esc/bin/analyseTypeScriptProject.js "$1" > /dev/null #only want the errors
