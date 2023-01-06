#!/bin/sh

# Copy wrfinput and wrfbdy files
cp ${OUTDIR}/${END}/WRF/wrfinput* ${WORKDIR}/
cp ${OUTDIR}/${END}/WRF/wrfbdy* ${WORKDIR}/

tar cvzf wrfinput_${END}.tar.gz wrfinput_d01*
rm wrfinput_d01*

# Delete wrfinput and wrfbdy files generated since last time this script was run
CURRENT=${START}
while [ ${CURRENT} -le ${END} ]; do

  echo "deleting files in ${CURRENT}"

  rm ${OUTDIR}/${CURRENT}/WRF/wrfinput*
  rm ${OUTDIR}/${CURRENT}/WRF/wrfbdy*

  d=${CURRENT::8}
  t=${CURRENT:8:12}
  CURRENT=`date '+%Y%m%d%H%M' --date="$d $t ${STEP} minutes"`

done
