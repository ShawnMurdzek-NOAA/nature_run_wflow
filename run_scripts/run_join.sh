#!/bin/sh

cd ${JOIN_OUT}
cp ${WF_DIR}/other_scripts/namelist.join .
cp ${JOIN_HOME}/joinwrf .

# Format times

# Update namelist file with correct parameters
sed -i "s|WRFDIR|${WRF_RUN}|g" namelist.join
sed -i "s|ITIME||g" namelist.join
sed -i "s|STIME||g" namelist.join
sed -i "s|INTERVAL|00_00:$(printf %02d ${incrementmin}):00|g" namelist.join
sed -i "s|ETIME||g" namelist.join

${APRUN} ${NPROC} joinwrf < namelist.join
e=$?

exit $e
