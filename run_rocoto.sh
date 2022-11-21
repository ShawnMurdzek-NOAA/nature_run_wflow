#!/bin/sh

# Change directory to where this script is located

fullpath=$( readlink -f "${BASH_SOURCE[0]}" )
path=$( dirname "${fullpath}" )
cd $path

source /etc/profile.d/modules.sh
module load rocoto
rocotorun -w nature_wflow.xml -d nature_wflow.db
