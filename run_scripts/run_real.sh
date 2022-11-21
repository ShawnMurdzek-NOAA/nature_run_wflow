#!/bin/sh

cd ${WRFDIR}/run
ln -sf ${WPSDIR}/met_em* .

if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./real.exe
  e=$?
else
  ./real.exe
  e=$?
fi

exit $e
