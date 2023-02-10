#!/bin/sh

# Create work directory
cd ${WORKDIR}

# Copy executables
cp ${WPSDIR}/link_grib.csh .
cp ${WPSDIR}/ungrib.exe .

if [ -e ${NAMELISTDIR}/namelist.wps.HRRR ]; then

  # Only have HRRR data for ICs. Give priority to HRRR data in ungrib
  # program, then backfill with RAP data
  cp ${NAMELISTDIR}/namelist.wps.HRRR .
  sed -i "s|START|${startdate}|g" namelist.wps.HRRR
  sed -i "s|END|${lastdate}|g" namelist.wps.HRRR
  ln -sf namelist.wps.HRRR namelist.wps
  ./link_grib.csh ${HRRRDIR}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  rm GRIB*

  # Only grab RAP data for the day the cycle is starting (RAPDIR1) and
  # the next day (RAPDIR2) otherwise ungrib takes too long to run
  cp ${NAMELISTDIR}/namelist.wps.RAP .
  sed -i "s|START|${startdate}|g" namelist.wps.RAP
  sed -i "s|END|${lastdate}|g" namelist.wps.RAP
  ln -sf namelist.wps.RAP namelist.wps
  ./link_grib.csh ${RAPDIR1}/* ${RAPDIR2}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?

elif [ -e ${NAMELISTDIR}/namelist.wps.RAP ]; then

  cp ${NAMELISTDIR}/namelist.wps.RAP .
  sed -i "s|START|${startdate}|g" namelist.wps.RAP
  sed -i "s|END|${lastdate}|g" namelist.wps.RAP
  ln -sf namelist.wps.RAP namelist.wps
  ./link_grib.csh ${RAPDIR1}/* ${RAPDIR2}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?

else

  cp ${NAMELISTDIR}/namelist.wps .
  sed -i "s|START|${startdate}|g" namelist.wps
  sed -i "s|END|${lastdate}|g" namelist.wps
  ./link_grib.csh ${RAPDIR1}/* ${RAPDIR2}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?

fi

# Clean up
rm GRIB*

exit $e
