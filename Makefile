MAX_CORES ?= 10
TIMEOUT ?= 4h
YQ_MERGE=yq eval-all 'select(fileIndex==1) * select(fileIndex==0)'

# by default, we want to run all snakemake rules even if there are failures (-k)
OB_CMD=ob run benchmark -k --local --task-timeout ${TIMEOUT} --cores ${MAX_CORES}

APPTR = apptainer
APPTV = apptainer_vanilla
APPTO = apptainer_optimized
CONDA = conda
ENVMD = envmodules

BASE       = base.yml
BASE_SHORT = smoketest/base.yml

# Install dependencies to generate files (requires go in the system)
deps:
	go install github.com/mikefarah/yq/v4@latest

# Generate all the yaml files from base + overrides
generate:
	${YQ_MERGE} overrides/${APPTR}.yml ${BASE} > Clustering_${APPTR}.yml
	${YQ_MERGE} overrides/${APPTV}.yml ${BASE} > Clustering_${APPTV}.yml
	${YQ_MERGE} overrides/${APPTO}.yml ${BASE} > Clustering_${APPTO}.yml
	${YQ_MERGE} overrides/${CONDA}.yml ${BASE} > Clustering_${CONDA}.yml
	${YQ_MERGE} overrides/${ENVMD}.yml ${BASE} > Clustering_${ENVMD}.yml
	${YQ_MERGE} overrides/${APPTR}.yml ${BASE_SHORT} > Clustering_${APPTR}_short.yml
	${YQ_MERGE} overrides/${APPTV}.yml ${BASE_SHORT} > Clustering_${APPTV}_short.yml
	${YQ_MERGE} overrides/${APPTO}.yml ${BASE_SHORT} > Clustering_${APPTO}_short.yml
	${YQ_MERGE} overrides/${CONDA}.yml ${BASE_SHORT} > Clustering_${CONDA}_short.yml
	${YQ_MERGE} overrides/${ENVMD}.yml ${BASE_SHORT} > Clustering_${ENVMD}_short.yml


clean:
	rm Clustering_*.yml

prepare_apptainer_env:
	cd envs && ./build_singularity.sh
prepare_envmodules_env:
	cd envs && eb clustbench.eb --robot
	cd envs && eb fcps.eb --robot
	cd envs && eb rmarkdown.eb --robot

# short versions, to debug runs & environments
run_with_apptainer_backend_registry_short:
	 ${OB_CMD} -b Clustering_registry_short.yml
run_with_apptainer_backend_short:
	 ${OB_CMD} -b Clustering_apptainer_short.yml
	 mv out out_apptainer_short
run_with_conda_backend_short:
	 ${OB_CMD} -b Clustering_conda_short.yml
	 mv out out_conda_short
run_with_envmodules_backend_short:
	 ${OB_CMD} -b Clustering_envmodules_short.yml
	 mv out out_lmod_short

# full versions (expect hours)
run_with_apptainer_backend_registry:
	 ${OB_CMD} -b Clustering_apptainer_registry.yml
	 mv out out_apptainer_registry
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
