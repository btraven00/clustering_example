MAX_THREADS ?= 30
OB_CMD="ob run benchmark -k --local"
prepare_apptainer_env:
	cd envs && ./build_singularity.sh
run_with_apptainer_backend:
	 ${OB_CMD} -b Clustering_singularity.yml --threads ${MAX_THREADS}
	 mv out out_apptainer
run_with_conda_backend:
	 ${OB_CMD} -b Clustering_conda.yml --threads ${MAX_THREADS}
	 mv out out_conda
