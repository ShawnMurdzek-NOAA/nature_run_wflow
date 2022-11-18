#!/bin/bash

date

task="$1"

source wrf_jet.env

# Determine number of processors being used
export NPROC=$((${NODES}*${PPN}))

$task

report-mem
date
