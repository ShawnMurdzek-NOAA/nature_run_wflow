# Nature Run Workflow

Rocoto workflow and supporting scripts for running a WRF-based nature run (NR) for an Observing System Simulation Experiment (OSSE). Documentation for Rocoto can be found [here](https://christopherwharrop.github.io/rocoto/). 

## Organization:

- `wflow`: Contains the workflow XML file and supporting scripts to run the workflow tasks.
- `wrf_wps_namelists`: Contains the namelists for the various workflow tasks.

### Components:

Components are housed in the `src` directory, which is specified in `wflow/nature_wflow.xml`. Components include:

- NCAR's Weather Research & Forecasting Model (WRF). [Version 4.4.2](https://github.com/wrf-model/WRF/releases/tag/v4.4.2) was used for this project.
- NCAR's WRF Pre-Processing System (WPS). [Version 4.4](https://github.com/wrf-model/WPS/releases/tag/v4.4) was used for this project.
- NOAA/EMC's Unified Post Processor (UPP). The [Nature_Run_SSM](https://github.com/ShawnMurdzek-NOAA/UPP/tree/Nature_Run_SSM) branch was used for this project.
- NOAA/GSL's Pygraf, which is a python-based graphics package. The [nature_run](https://github.com/ShawnMurdzek-NOAA/pygraf/tree/nature_run) branch was used for this project.

### Input Data:

The nature run relies on various datasets for initial conditions (ICs), lateral boundary conditions (LBCs), and various static fields. Paths for these datasets are set in `wflow/nature_wflow.xml`. Datasets include:

- Rapid Refresh (RAP) GRIB2 output (for ICs and LBCs) in `RAPDIR`. RAP GRIB2 output should be further organized into subdirectories in RAPDIR based on the day the RAP was initialized. These subdirectories need to follow the naming convention `YYYYmmdd`. Data can be found on Amazon AWS [here](https://noaa-rap-pds.s3.amazonaws.com/index.html).
- High-Resolution Rapid Refresh (HRRR) GRIB2 output (for ICs) in `HRRRDIR`. Data can be found on Amazon AWS [here](https://noaa-hrrr-bdp-pds.s3.amazonaws.com/index.html).
- Static data required for GEOG (a component of WPS) in `STATICDIR`. Data can be found on the NCAR WRF website [here](https://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html).

## Running The Nature Run

1. Download the various input datasets listed above (RAP, HRRR, GEOG static datasets).
2. Download and compile the various components listed above (WRF, WPS, UPP, pygraf).
3. Update the directories in `wflow/nature_wflow.xml` as well as the namelists in `wrf_wps_namelists` to match your machine. Job parameters (e.g., account, queue) will also need to be updated in `wflow/nature_wflow.xml`. 
4. If not running on a supported machine (Hera, Jet, Orion), add `wflow/env/*.env` files to configure the environment for the various workflow tasks.

### Using Cron

It's easiest to run this workflow using cron so that rocotorun is executed every _X_ minutes. To
edit your crontab, use the following command in your home directory:

`crontab -e`

The following two lines should be at the beginning of your crontab to insure than code runs properly 
and that you are emailed with error messages:

```
#!/bin/sh --login
MAILTO=email@noaa.gov
```

Add the following line to run the workflow every 15 minutes:

`*/15 * * * * /path/to/workflow/run_rocoto.sh`
