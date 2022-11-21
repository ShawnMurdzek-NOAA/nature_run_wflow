#!/bin/sh

cd ${WPSDIR}

if [ ! -e namelist.wps ]; then
  ln -sf namelist.wps.RAP namelist.wps
fi

if [ ${NPROC} > 1 ]; then
  ${APRUN} ${NPROC} ./metgrid.exe
else
  ./metgrid.exe
fi
