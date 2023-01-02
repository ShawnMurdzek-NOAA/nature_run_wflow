#!/bin/bash

date

task="$1"

# Load environment
case $MACHINE in
"JET")
  source ./env/wrf_jet.env;;
"HERA")
  source ./env/wrf_hera.env;;
esac

$task
e=$?

report-mem
date

exit $e
