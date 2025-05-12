MAX_CORES ?= 10
# by default, we want to run all snakemake rules even if there are failures (-k)
OB_CMD=ob run benchmark -k --local --task-timeout "4h" --cores ${MAX_CORES}
prepare_apptainer_env:
	cd envs && ./build_singularity.sh
prepare_envmodules_env:
	cd envs && eb clustbench.eb --robot
	cd envs && eb fcps.eb --robot
	cd envs && eb rmarkdown.eb --robot

# short versions, to debug runs & environments
run_with_apptainer_backend_short:
	 ${OB_CMD} -b Clustering_apptainer_vanilla_smoketest.yml
	 mv out out_apptainer_short
run_with_conda_backend_short:
	 ${OB_CMD} -b Clustering_conda_smoketest.yml
	 mv out out_conda
run_with_envmodules_backend_short:
	 ${OB_CMD} -b Clustering_envmodules_smoketest.yml
	 mv out out_lmod_short

# full versions (expect hours)
run_with_apptainer_backend_vanilla:
	 ${OB_CMD} -b Clustering_apptainer_vanilla.yml
	 mv out out_apptainer_vanilla
run_with_apptainer_backend_optimized:
	 ${OB_CMD} -b Clustering_apptainer_optimized.yml
	 mv out out_apptainer_vanilla
run_with_conda_backend:
	 ${OB_CMD} -b Clustering_conda.yml
	 mv out out_conda
run_with_envmodules_backend:
	 ${OB_CMD} -b Clustering_envmodules.yml
	 mv out out_lmod
