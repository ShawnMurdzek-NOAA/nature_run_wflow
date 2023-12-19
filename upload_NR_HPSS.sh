#!/bin/sh

# Upload Nature Run output to HPSS

year='2022'
month='05'
day='06'
hour='00 01 02 03 04 05 06 07 08 09 10 11'
HPSSpath='/BMC/wrfruc/5year/murdzek/springNR'
NRpath='/scratch1/BMC/wrfruc/murdzek/nature_run_spring'

module load hpss

for h in ${hour}; do

  echo "${year}${month}${day}${h}"
  d=${year}${month}${day}

  # UPP output
  cd ${NRpath}/output/${d}${h}00/UPP
  tar cvf ${d}${h}_UPP.tar ./*
  hsi put ${d}${h}_UPP.tar : ${HPSSpath}/UPP/${d}/${d}${h}_UPP.tar
  rm ${d}${h}_UPP.tar
  #rm ./*.grib2  

  # Graphics
  cd ${NRpath}/output/${d}${h}00/graphics
  tar cvf ${d}${h}_graphics.tar ./*
  hsi put ${d}${h}_graphics.tar : ${HPSSpath}/graphics/${d}/${d}${h}_graphics.tar
  rm ${d}${h}_graphics.tar
  #rm ./*.tar.gz

  # Restart files
  if [ -d ${NRpath}/restart/${d}${h}00 ]; then
    echo "restart found"
    cd "${NRpath}/restart/${d}${h}00/"
    tar cvf ${d}${h}_restart.tar ./*
    hsi put ${d}${h}_restart.tar : "${HPSSpath}/restart/${d}${h}_restart.tar"
    rm ${d}${h}_restart.tar
    #rm ./wrf*
  else
    echo "no restarts"
  fi

done 
