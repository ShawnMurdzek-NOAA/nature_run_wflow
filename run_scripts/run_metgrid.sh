#!/bin/sh

cd ${WPSDIR}
if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./metgrid.exe
else
  ./metgrid.exe
fi
