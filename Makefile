MAX_CORES ?= 10
# by default, we want to run all snakemake rules even if there are failures
OB_CMD=ob run benchmark -k --local --task-timeout "4h"
prepare_apptainer_env:
	cd envs && ./build_singularity.sh
run_with_apptainer_backend:
	 ${OB_CMD} -b Clustering_singularity.yml --cores ${MAX_CORES}
	 mv out out_apptainer
run_with_conda_backend:
	 ${OB_CMD} -b Clustering_conda.yml --cores ${MAX_CORES}
	 mv out out_conda
