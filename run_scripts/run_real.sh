#!/bin/sh

cd ${WRFDIR}/run
ln -sf ${WPSDIR}/met_em* .

if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./real.exe
  e=$?
  if [ $e -eq 0 ]; then
    cd ${WPSDIR}
    tar cvf met_em.d01.tar met_em*
    rm met_em.d01.2021*
    cd ${WRFDIR}/run
  fi
else
  ./real.exe
  e=$?
fi

rm met_em*

exit $e
