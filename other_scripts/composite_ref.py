"""
Compute Composite Reflectivity

Passed arguments:
    1. wrfout netCDF filename

shawn.s.murdek@noaa.gov
Date Created: 2 January, 2023
"""

#---------------------------------------------------------------------------------------------------
# Import Modules
#---------------------------------------------------------------------------------------------------

import xarray as xr
import sys


#---------------------------------------------------------------------------------------------------
# Compute Composite Reflectivity
#---------------------------------------------------------------------------------------------------

fname = sys.argv[1]
ref_name = 'COMPOSITE_REFL_10CM'

ds = xr.open_dataset(fname)

new_ds = xr.Dataset(data_vars={ref_name:ds['REFL_10CM'].max(dim=['bottom_top'])})
new_ds[ref_name].attrs['units'] = 'dBZ'
new_ds[ref_name].attrs['description'] = 'Composite radar reflectivity (lamda = 10 cm)'

ds.close()
new_ds.to_netcdf(fname, mode='a')


"""
End composite_ref.py
"""
