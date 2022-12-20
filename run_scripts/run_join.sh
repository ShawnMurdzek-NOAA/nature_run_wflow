#!/bin/sh

cd ${JOIN_OUT}
cp ${JOIN_HOME}/joinwrf .

# Format startdate
itime="${startdate:0:4}-${startdate:4:2}-${startdate:6:2}_${startdate:8:2}:${startdate:10:2}:00"

cdate=${startdate}
while [ ${cdate} -le ${lastdate} ]; do

  # Fomat date
  t="${cdate:0:4}-${cdate:4:2}-${cdate:6:2}_${cdate:8:2}:${cdate:10:2}:00"
  echo $t

  # Update namelist file with correct parameters
  cp ${WF_DIR}/other_scripts/namelist.join .
  sed -i "s|WRFDIR|${WRF_RUN}|g" namelist.join
  sed -i "s|ITIME|${itime}|g" namelist.join
  sed -i "s|STIME|${t}|g" namelist.join
  sed -i "s|INTERVAL|00_00:$(printf %02d ${incrementmin}):00|g" namelist.join
  sed -i "s|ETIME|${t}|g" namelist.join

  # Run JOINER
  ${APRUN} ${NPROC} joinwrf < namelist.join
  e=$?

  # Save namelist
  mv namelist.join namelist.join.${cdate}

  # Update current date (cdate)
  cdate=`date '+%Y%m%d%H%M' -d "${cdate:0:8} ${cdate:8:4} ${incrementmin} minutes"`

done
exit $e
