#!/bin/sh

# Create work directory
cd ${RESTARTDIR}
mkdir GEOGRID
cd GEOGRID

# Run geogrid
cp ${NAMELISTDIR}/namelist.wps.RAP ./namelist.wps
cp ${WPSDIR}/geogrid.exe .
if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./geogrid.exe
  e=$?
  tar cvf geogrid.logs.tar geogrid.log.*
  rm geogrid.log.*
else
  ./geogrid.exe
  e=$?
fi

# Clean up
rm geogrid.exe

exit $e
