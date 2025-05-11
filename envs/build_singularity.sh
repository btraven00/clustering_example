#!/bin/sh
CMD=singularity
BUILD=build --fakeroot
$CMD $BUILD sklearn_optimized.sif sklearn_singularity_optimized.def
$CMD $BUILD clustbench-optimized.sif clustbench_singularity.def
$CMD $BUILD r.sif r_singularity.def
$CMD $BUILD fcps.sif fcps_singularity.def
