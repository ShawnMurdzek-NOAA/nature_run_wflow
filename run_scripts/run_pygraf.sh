#!/bin/sh

mkdir ${GRAPHICSDIR}

cd ${PYGRAFDIR}

source ./pre.sh

python create_graphics.py \
         maps \
         --all_leads \
         -d ${WRFDIR}/run \
         -f 0 \
         --file_tmpl "wrfnat_hrconus_{FCST_TIME:02d}.grib2" \
         --file_type nat \
         --images ./image_lists/wrfnat.yml hourly \
         -m "Nature Run" \
         -n ${NPROC} \
         -o ${GRAPHICSDIR} \
         -s ${START} \
         --tiles full

python create_graphics.py \
         maps \
         --all_leads \
         -d ${WRFDIR}/run \
         -f 0 \
         --file_tmpl "wrfprs_hrconus_{FCST_TIME:02d}.grib2" \
         --file_type prs \
         --images ./image_lists/wrfprs.yml hourly \
         -m "Nature Run" \
         -n ${NPROC} \
         -o ${GRAPHICSDIR} \
         -s ${START} \
         --tiles full

python create_graphics.py \
         skewts \
         --all_leads \
         -d ${WRFDIR}/run \
         -f 0 \
         --file_tmpl "wrfnat_hrconus_{FCST_TIME:02d}.grib2" \
         --file_type nat \
         --max_plev 100 \
         -m "Nature Run" \
         -n ${NPROC} \
         -o ${GRAPHICSDIR} \
         -s ${START} \
         --sites ./static/sites.txt

exit $?
