#!/bin/sh

cd ${WORKDIR}

# Geogrid
rm ${WORKDIR}/WPS/geo_em*

# Ungrib
rm ${WORKDIR}/WPS/link_grib.csh
rm ${WORKDIR}/WPS/ungrib.exe
rm ${WORKDIR}/WPS/RAP*
rm ${WORKDIR}/WPS/HRRR*

# Metgrid
rm ${WORKDIR}/WPS/metgrid.exe
rm ${WORKDIR}/WPS/met_em.d01*

# Real
rm ${WORKDIR}/WRF/met_em*

# WRF
rm ${WORKDIR}/WRF/wrfout*

# JOINER
rm ${WORKDIR}/JOIN/wrfout*
rm ${WORKDIR}/JOIN/DONE.wrfout*
