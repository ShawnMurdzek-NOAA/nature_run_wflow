#!/bin/sh

source py_jet.env

cd ${FAKEOBS_CODE_DIR}
python wrf_precondition.py
e=$?

exit $e
