#!/bin/sh

cd ${WPSDIR}
./link_grib.csh ${DATADIR}/*
./ungrib.exe
rm GRIB*
