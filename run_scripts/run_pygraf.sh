#!/bin/sh

if [ ! -d ${GRAPHICSDIR} ]; then
  echo "creating pygraf ouput directory"
  mkdir ${GRAPHICSDIR}
fi

cd ${PYGRAFDIR}

source ./pre.sh

# Pygraf is designed to operate on forecasts valid at the top of the hour. In order to handle 
# multiple output files each hour, we will treat each output time as a 0-hour forecast with the
# output time as the start time. Thus, we will loop over each output time in this script and run 
# pygraf separately for each output time

CURRENT=${START}
while [ ${CURRENT} -le ${END} ]; do

  echo "creating graphics for ${CURRENT}"

  python create_graphics.py \
           maps \
           -d ${UPP_OUT} \
           -f 00 \
           --file_tmpl "wrfnat_${CURRENT}.grib2" \
           --file_type nat \
           --images ./image_lists/wrfnat.yml hourly \
           -m "Nature Run" \
           -n ${NPROC} \
           -o ${GRAPHICSDIR} \
           -s ${CURRENT} \
           --tiles full

  python create_graphics.py \
           maps \
           -d ${UPP_OUT} \
           -f 00 \
           --file_tmpl "wrfprs_${CURRENT}.grib2" \
           --file_type prs \
           --images ./image_lists/wrfprs.yml hourly \
           -m "Nature Run" \
           -n ${NPROC} \
           -o ${GRAPHICSDIR} \
           -s ${CURRENT} \
           --tiles full

  python create_graphics.py \
           skewts \
           -d ${UPP_OUT} \
           -f 00 \
           --file_tmpl "wrfnat_${CURRENT}.grib2" \
           --file_type nat \
           --max_plev 100 \
           -m "Nature Run" \
           -n ${NPROC} \
           -o ${GRAPHICSDIR} \
           -s ${CURRENT} \
           --sites ./static/sites.txt

  e=$?

  # Zip up graphics
  cd ${GRAPHICSDIR}
  tar cvzf graphics_${CURRENT}.tar.gz ./${CURRENT}00/*
  rm -rf ${CURRENT}00

  d=${CURRENT::8}
  t=${CURRENT:8:12}
  CURRENT=`date '+%Y%m%d%H%M' --date="$d $t ${STEP} minutes"`

  cd ${PYGRAFDIR}

done

exit $e
