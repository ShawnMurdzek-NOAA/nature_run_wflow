#!/bin/sh

cd ${WORKDIR}
export NPROC=$(( NODES * PPN ))
cp ${WFDIR}/other_scripts/run_upp_wrf .
./run_upp_wrf
e=$?

exit $e
