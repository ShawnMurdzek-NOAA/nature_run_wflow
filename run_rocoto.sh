#!/bin/sh

# Change directory to where this script is located
fullpath=$( readlink -f "${BASH_SOURCE[0]}" )
path=$( dirname "${fullpath}" )
cd $path

# Add ability to load modules and use slurm (Hera + Jet)
source /etc/profile.d/modules.sh
source /etc/profile.d/slurm.sh

# Add ability to load modules and use slurm (Orion + Hercules)
source /etc/profile

module load rocoto
rocotorun -w nature_wflow.xml -d nature_wflow.db
