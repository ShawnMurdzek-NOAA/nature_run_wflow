# Nature Run Workflow

Rocoto workflow for running a WRF simulation that will serve as an Observing System Simulation Experiment (OSSE) nature run.

### Prerequisites:

- Compiled version of WRF in WRFDIR
- Compiled version of WPS in WPSDIR
- Compiled version of UPP in UPPDIR
- RAP GRIB2 output (for ICs and LBCs) in RAPDIR
- HRRR GRIB2 output (for ICs and LBCs) in HRRRDIR
- namelist.wps.HRRR and namelist.wps.RAP files in WPSDIR
- WRFDIR contains a run directory with real.exe, wrf.exe, and namelist.input

### Using Cron

It's easiest to run this workflow using cron so that rocotorun is executed every _X_ minutes. To
edit your crontab, use the following command in your home direcory:

`crontab -e`

The following two lines should be at the beginning of your crontab to insure than code runs properly 
and that you are emailed with error messages:

```
#!/bin/sh --login
MAILTO=email@noaa.gov
```

Add the following line to run the workflow every 15 minutes:

`*/15 * * * * /path/to/workflow/run_rocoto.sh`

### Other Notes:

- Workflow has thus far only been tested for the geogrid, ungrib, metgrid, real, and WRF tasks
