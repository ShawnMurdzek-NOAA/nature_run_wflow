#!/bin/sh

cd ${WPSDIR}

if [ -e namelist.wps.HRRR ]; then

  ln -sf namelist.wps.HRRR namelist.wps
  ./link_grib.csh ${HRRRDIR}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM.SFC Vtable
  ./ungrib.exe
  rm GRIB*

  ln -sf namelist.wps.RAP namelist.wps
  ./link_grib.csh ${RAPDIR}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?
  rm GRIB*

elif [ -e namelist.wps.RAP ]; then

  ln -sf namelist.wps.RAP namelist.wps
  ./link_grib.csh ${RAPDIR}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?
  rm GRIB*

else

  ./link_grib.csh ${RAPDIR}/*
  ln -sf ${STATICDIR}/WPS/Vtable.raphrrr.SSM Vtable
  ./ungrib.exe
  e=$?
  rm GRIB*

fi

exit $e
