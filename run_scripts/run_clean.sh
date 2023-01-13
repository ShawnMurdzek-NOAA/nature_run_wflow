#!/bin/sh

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
  echo "saving wrfout files for ${CURRENT}"

  fname=wrfout_${CURRENT}.tar.gz
  tar cvzf ${fname} ${WORKDIR}/WRF/wrfout*
  rm ${WORKDIR}/WRF/wrfout_d01*
  hsi put ${WORKDIR}/WRF/${fname} ${HPSSDIR}/${fname}
 
  d=${CURRENT::8}
  t=${CURRENT:8:12}
  CURRENT=`date '+%Y%m%d%H%M' --date="$d $t ${STEP} minutes"`

done

# WRF
#rm ${WORKDIR}/WRF/wrfout*

# JOINER
rm ${WORKDIR}/JOIN/wrfout*
rm ${WORKDIR}/JOIN/DONE.wrfout*
