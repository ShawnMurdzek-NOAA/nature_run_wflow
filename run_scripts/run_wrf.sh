#!/bin/sh

cd ${WRFDIR}/run
if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./wrf.exe
  e=$?
else
  ./wrf.exe
  e=$?
fi

exit $e
