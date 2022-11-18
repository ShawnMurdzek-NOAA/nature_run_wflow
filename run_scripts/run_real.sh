#!/bin/sh

cd ${WRFDIR}/run
ln -sf ${WPSDIR}/met_em* .

if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./real.exe
else
  ./real.exe
fi
