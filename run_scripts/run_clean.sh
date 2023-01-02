#!/bin/sh

# Geogrid
rm ${WORKDIR}/WPS/geo_em*

# Ungrib
rm ${WORKDIR}/WPS/link_grib.csh
rm ${WORKDIR}/WPS/ungrib.exe
rm ${WORKDIR}/RAP*
rm ${WORKDIR}/HRRR*

# Metgrid
rm ${WORKDIR}/WPS/metgrid.exe
rm ${WORKDIR}/WPS/met_em.d01*

# Real
rm ${WORKDIR}/WRF/met_em*
rm ${WORKDIR}/real.exe

# WRF
rm ${WORKDIR}/WRF/wrf.exe
rm ${WORKDIR}/WRF/wrfout*

# JOINER
rm ${WORKDIR}/JOIN/wrfout*
