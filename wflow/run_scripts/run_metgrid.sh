#!/bin/sh

cd ${WORKDIR}

# Link or copy required files
ln -sf ${GEODIR}/geo_em* .
cp ${WPSDIR}/metgrid.exe .

# Double-check that namelist still exists from ungrib
if [ ! -e namelist.wps ]; then
  if [ ! -e namelist.wps.RAP ]; then
    cp ${NAMELISTDIR}/namelist.wps.RAP .
    sed -i "s|START|${startdate}|g" namelist.wps.RAP
    sed -i "s|END|${lastdate}|g" namelist.wps.RAP
  fi
  ln -sf namelist.wps.RAP namelist.wps
fi

if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./metgrid.exe
  e=$?
  tar cvf metgrid.logs.tar metgrid.log.*
  rm metgrid.log.*
else
  echo 'NPROC = 1'
  ./metgrid.exe
  e=$?
fi

exit $e
