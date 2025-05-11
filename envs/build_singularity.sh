#!/bin/sh
CMD=singularity
BUILD='build --fakeroot'
$CMD ${BUILD} clustbench-vanilla.sif clustbench_apptainer_vanillapy.def
$CMD ${BUILD} clustbench-optimized.sif clustbench_apptainer_optimized.def
$CMD ${BUILD} fcps.sif fcps_singularity_optimized.def
