"""
Append wrfinput Fields to Final wrfout File

Passed Arguments:
    1. Number of files
    2. Date string (YYYY-mm-dd_HH:MM:SS)
    3. Directory containing wrfinput and wrfout files
    4. Number of processors

shawn.s.murdzek@noaa.gov
Date Created: 5 January 2023
"""

#---------------------------------------------------------------------------------------------------
# Import Modules
#---------------------------------------------------------------------------------------------------

from multiprocessing import Pool
import xarray as xr
import sys


#---------------------------------------------------------------------------------------------------
# Input Parameters
#---------------------------------------------------------------------------------------------------

nfiles = int(sys.argv[1])
time = sys.argv[2]
path = sys.argv[3]
nproc = int(sys.argv[4])

fields = ['LANDUSEF', 'SOILCTOP', 'SOILCBOT', 'LAKE_DEPTH',
          'LAT_LL_T', 'LAT_UL_T', 'LAT_UR_T', 'LAT_LR_T',
          'LAT_LL_U', 'LAT_UL_U', 'LAT_UR_U', 'LAT_LR_U',
          'LAT_LL_V', 'LAT_UL_V', 'LAT_UR_V', 'LAT_LR_V',
          'LAT_LL_D', 'LAT_UL_D', 'LAT_UR_D', 'LAT_LR_D',
          'LON_LL_T', 'LON_UL_T', 'LON_UR_T', 'LON_LR_T',
          'LON_LL_U', 'LON_UL_U', 'LON_UR_U', 'LON_LR_U',
          'LON_LL_V', 'LON_UL_V', 'LON_UR_V', 'LON_LR_V',
          'LON_LL_D', 'LON_UL_D', 'LON_UR_D', 'LON_LR_D',
          'LAKEFLAG', 'LAKE_DEPTH_FLAG']


#---------------------------------------------------------------------------------------------------
# Append Fields
#---------------------------------------------------------------------------------------------------

# Print inputs
print()
print('nfiles = %d', nfiles)
print('time = %s', time)
print('path = %s', path)
print('nproc = %d', nproc)
print()

def append_data(i, nfiles=nfiles, time=time, path=path, fields=fields):

    print('processing file %d of %d' % (i+1, nfiles))

    if nfiles == 1:
        wrfin = '%s/wrfinput_d01' % path
        wrfout = '%s/wrfout_d01_%s' % (path, time)
    else:
        wrfin = '%s/wrfinput_d01_%04d' % (path, i)
        wrfout = '%s/wrfout_d01_%s_%04d' % (path, time, i)

    # Extract data we need from wrfinput file
    ds = xr.open_dataset(wrfin)
    data = {}
    for f in fields:
        data[f] = ds[f]
    new_ds = xr.Dataset(data_vars=data)
    ds.close()

    # Append to wrfout file
    new_ds.to_netcdf(wrfout, mode='a')

# Run in parallel
with Pool(processes=nproc) as p:
    p.map(append_data, list(range(nfiles)))


"""
End append_wrfinput_fields.py
"""
