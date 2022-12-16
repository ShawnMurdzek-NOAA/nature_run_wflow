#!/bin/sh

cd ${WPSDIR}

if [ ! -e namelist.wps ]; then
  ln -sf namelist.wps.RAP namelist.wps
fi

if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./geogrid.exe
  e=$?
  tar cvf geogrid.log.tar geogrid.log.*
  rm geogrid.log.1*
  rm geogrid.log.0*
else
  ./geogrid.exe
  e=$?
fi

exit $e
