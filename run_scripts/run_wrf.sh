#!/bin/sh

cd ${WRFDIR}/run
if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./wrf.exe
else
  ./wrf.exe
fi
