#!/bin/sh

cd ${WPSDIR}
if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./geogrid.exe
else
  ./geogrid.exe
fi
