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

### Other Notes:

- Workflow has thus far only been tested for the geogrid, ungrib, metgrid, real, and WRF tasks
