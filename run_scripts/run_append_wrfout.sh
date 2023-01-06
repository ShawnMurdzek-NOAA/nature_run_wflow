#!/bin/sh

case $MACHINE in
"JET")
  source ${WFDIR}/env/py_jet.env;;
"HERA")
  source ${WFDIR}/env/py_hera.env;;
esac

cd ${WORKDIR}

# Run Python script to append wrfinput files to the final wrfout files
python ${WFDIR}/other_scripts/append_wrfinput_fields.py ${NFILES} ${TIME} ${WORKDIR} ${NPROC}
e=$?

exit $e
