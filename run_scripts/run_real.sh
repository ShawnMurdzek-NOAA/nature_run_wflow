#!/bin/sh

cd ${WORKDIR}

# Link and copy necessary files
# I don't know exactly which files in the WRF run directory are needed, so just copy all of them
ln -sf ${METDIR}/met_em* .
cp ${WRFDIR}/run/* .
cp ${NAMELISTDIR}/namelist.input .

# Extract initial time
syr=${startdate:0:4}
smon=${startdate:4:2}
sday=${startdate:6:2}
shr=${startdate:8:2}
smin=${startdate:10:2}
ssec=${startdate:12:2}

# Edit namelist.input
sed -i "s|SYEAR|${syr}|g" namelist.input
sed -i "s|SMONTH|${smon}|g" namelist.input
sed -i "s|SDAY|${sday}|g" namelist.input
sed -i "s|SHOUR|${shr}|g" namelist.input
sed -i "s|SMINUTE|${smin}|g" namelist.input
sed -i "s|SSECOND|${ssec}|g" namelist.input
sed -i "s|EYEAR|${lastdate:0:4}|g" namelist.input
sed -i "s|EMONTH|${lastdate:4:2}|g" namelist.input
sed -i "s|EDAY|${lastdate:6:2}|g" namelist.input
sed -i "s|EHOUR|${lastdate:8:2}|g" namelist.input
sed -i "s|EMINUTE|${lastdate:10:2}|g" namelist.input
sed -i "s|ESECOND|${lastdate:12:2}|g" namelist.input

# Run real.exe
if [ ${NPROC} -gt 1 ]; then
  ${APRUN} ${NPROC} ./real.exe
  e=$?
  tar cvf rsl.real.error.tar rsl.error.*
  tar cvf rsl.real.out.tar rsl.out.*
  rm rsl.error.*
  rm rsl.out.*
else
  ./real.exe
  e=$?
  mv rsl.error rsl.real.error
  mv rsl.out rsl.real.out
fi

# If not the first cycle, copy wrfout files from previous cycle
echo ${SPINUP}
if [ ${SPINUP} = "FALSE" ]; then
  echo "Using wrfout files from previous cycle"
  rm wrfinput*
  cp ${prevcyc}/wrfout_d01_${syr}-${smon}-${sday}_${shr}:${smin}:${ssec}* .
  for f in ./wrfout*; do
    mv $f ./wrfinput_d01_${f: -4:4}
  done
  e2=$?
  if [ $e2 -gt $e ]; then
    e=$e2
  fi
fi

exit $e
