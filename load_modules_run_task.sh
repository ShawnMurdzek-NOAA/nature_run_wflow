#!/bin/bash

date

task_name="$1"
task="$2"

hrrr_env

$task

report-mem
date
