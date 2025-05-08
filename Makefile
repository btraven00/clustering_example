MAX_CORES ?= 10
# by default, we want to run all snakemake rules even if there are failures (-k)
OB_CMD=ob run benchmark -k --local --task-timeout "4h" --cores ${MAX_CORES}
prepare_apptainer_env:
	cd envs && ./build_singularity.sh
prepare_envmodules_env:
	cd envs && eb clustbench.eb --robot
	cd envs && eb fcps.eb --robot
run_with_apptainer_backend:
	 ${OB_CMD} -b Clustering_singularity.yml
	 mv out out_apptainer
run_with_conda_backend:
	 ${OB_CMD} -b Clustering_conda.yml
	 mv out out_conda
run_with_envmodules_backend:
	 ${OB_CMD} -b Clustering_envmodules.yml
	 mv out out_lmod
