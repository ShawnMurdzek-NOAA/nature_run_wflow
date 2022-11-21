#!/bin/sh

cd ${WRFDIR}/run
if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./wrf.exe
  e=$?
  tar cvf rsl.wrf.error.tar rsl.error.*
  tar cvf rsl.wrf.out.tar rsl.out.*
  rm rsl.error.*
  rm rsl.out.*
  if [ e==0 ]; then
    tar cvf wrfinput.tar wrfinput_d01*
    rm wrfinput_d01*
  fi
else
  ./wrf.exe
  e=$?
fi

exit $e
