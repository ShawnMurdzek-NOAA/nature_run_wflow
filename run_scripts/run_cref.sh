#!/bin/sh

case $MACHINE in
"JET")
  source ../env/py_jet.env;;
"HERA")
  source ../env/py_hera.env;;
esac

cd ${WORKDIR}

# Format startdate
itime="${startdate:0:4}-${startdate:4:2}-${startdate:6:2}_${startdate:8:2}:${startdate:10:2}:00"

cdate=${startdate}
while [ ${cdate} -le ${lastdate} ]; do

  # Fomat date
  t="${cdate:0:4}-${cdate:4:2}-${cdate:6:2}_${cdate:8:2}:${cdate:10:2}:00"
  echo $t

  # Run Python script to append composite reflectivity to wrfout file
  python ${WF_DIR}/other_scripts/composite_ref.py wrfout_d01_${t} 
  e=$?

  # Update current date (cdate)
  cdate=`date '+%Y%m%d%H%M' -d "${cdate:0:8} ${cdate:8:4} ${incrementmin} minutes"`

done
exit $e
