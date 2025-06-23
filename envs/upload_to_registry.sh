#!/bin/sh
USER=user
REGISTRY=quay.io
ORGANIZATION=omnibenchmark
CLUSTBENCH_REPO=clustbench-vanilla
CLUSTBENCH_TAG=0.1.2
FCPS_REPO=fcps
FCPS_TAG=0.1.2

#singularity registry login --username {$USER} docker://${REGISTRY}
singularity push ${CLUSTBENCH_REPO}.sif oras://${REGISTRY}/${ORGANIZATION}/${CLUSTBENCH_REPO}:${CLUSTBENCH_TAG}
singularity push ${FCPS_REPO}.sif oras://${REGISTRY}/${ORGANIZATION}/${FCPS_REPO}:${FCPS_TAG}
