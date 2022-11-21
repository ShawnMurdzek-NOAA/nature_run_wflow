#!/bin/sh

cd ${WPSDIR}

if [ ! -e namelist.wps ]; then
  ln -sf namelist.wps.RAP namelist.wps
fi

if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./metgrid.exe
  e=$?
  tar cvf metgrid.log.tar metgrid.log.*
  rm metgrid.log.1*
  rm metgrid.log.0*
  if [ e==0 ]; then
    tar cvf geo_em.d01.tar geo_em.d01.nc*
    rm geo_em.d01.nc* 
  fi
else
  ./metgrid.exe
  e=$?
fi

exit $e
