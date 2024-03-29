#!/bin/sh

cd ${WORKDIR}

# Run wrf.exe
if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./wrf.exe
  e=$?
  tar cvf rsl.wrf.error.tar rsl.error.*
  tar cvf rsl.wrf.out.tar rsl.out.*
  rm rsl.error.*
  rm rsl.out.*
else
  ./wrf.exe
  e=$?
  mv rsl.error rsl.wrf.error
  mv rsl.out rsl.wrf.out
fi

exit $e
