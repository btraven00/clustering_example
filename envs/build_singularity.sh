#!/bin/sh
CMD=singularity
BUILD='build --fakeroot'
$CMD ${BUILD} clustbench-vanilla.sif clustbench_apptainer_vanillapy.def
# enable this if you want to compare with the custom python compilation
# $CMD ${BUILD} clustbench-optimized.sif clustbench_apptainer_optimized.def
$CMD ${BUILD} fcps.sif fcps.def
$CMD ${BUILD} rmarkdown.sif rmarkdown.def
