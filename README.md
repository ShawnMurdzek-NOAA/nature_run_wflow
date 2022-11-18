# Nature Run Workflow

Rocoto workflow for running a WRF simulation that will serve as an Observing System Simulation Experiment (OSSE) nature run.

### Prerequisites:

- Compiled version of WRF in WRFDIR
- Compiled version of WPS in WPSDIR
- Compiled version of UPP in UPPDIR
- RAP GRIB2 output (ICs and LBCs) in DATADIR
- namelist.wps configured so that ungrib.exe produces RAP:YY-MM-DD\_HH files
- Appropriate Vtable linked in WPS
- WRFDIR contains a run directory with real.exe, wrf.exe, and namelist.input

### Other Notes:

- Workflow has thus far only been tested for the geogrid, ungrib, metgrid, real, and WRF tasks
