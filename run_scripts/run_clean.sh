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

# Save WRF output to HPSS
module load hpss
hsi mkdir ${HPSSDIR}
CURRENT=${START}
while [ ${CURRENT} -le ${END} ]; do
  fname=wrfout_${CURRENT}.tar.gz
  t=${CURRENT::4}-${CURRENT:4:2}-${CURRENT:6:2}_${CURRENT:8:2}:${CURRENT:10:2}:00
  echo "saving wrfout files for ${t}"
  
  tar cvzf ${fname} ${WORKDIR}/WRF/wrfout_d01_${t}*
  e=$?
  if [ $e -lt 1 ]; then
    rm ${WORKDIR}/WRF/wrfout_d01_${t}*
  fi
  hsi put ${WORKDIR}/WRF/${fname} : ${HPSSDIR}/${fname}
 
  d=${CURRENT::8}
  t=${CURRENT:8:12}
  CURRENT=`date '+%Y%m%d%H%M' --date="$d $t ${STEP} minutes"`

done

# WRF
#rm ${WORKDIR}/WRF/wrfout*

# JOINER
rm ${WORKDIR}/JOIN/wrfout*
rm ${WORKDIR}/JOIN/DONE.wrfout*
