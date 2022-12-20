#!/bin/bash

date

task="$1"

source ./env/wrf_jet.env

$task
e=$?

report-mem
date

exit $e
