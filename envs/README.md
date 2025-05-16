We distribute `Clustering.yml` runs with different backends.

- `Clustering_conda.yml`. Conda semi-reproducible (no pinning, using pip)
- `Clustering_apptainer.yml`. Singularity semi-reproducible, local SIF files.
- `Clustering_oras.yml`. Singularity semi-reproducible, prebuilt remote images from an ORAS registry.
- `Clustering_envmodules.yml`. Easybuild backend with default optimization.

## Conda

### Files

- `clustbench.yml`
- `fcps.yml`
- `rmarkdown.yml`

### How to build

No need to `ob software conda pin / prepare`; let `ob run benchmark -b Clustering_conda.yml --local` do it.

## Apptainer semi-reproducible and local

### Files

The apptainer images are based in ubuntu-noble docker images.

The "optimized" one does a custom python 3.12 compilation; the vanillapy stocks the default py3.12 interpreter from the official ubuntu docker image.

- `clustbench_apptainer_optimized.def`
- `clustbench_apptainer_vanillapy.def`
- `fcps.def`

### How to build

- `make prepare_apptainer_env` from the root folder.

## Aptainer semi-reproducible with registry pull

No need to prepare/build anything; let `ob run benchmark -b Clustering_oras.yml --local` do it using pre-built images from https://quay.io/omnibenchmark registry.

## envmodules - reproducible builds with easybuild

### Files

- `clustbench.eb`
- `fcps.eb`
- `rmarkdown.eb`
- `rmarkdown-python.eb`

### How to build

- `make prepare_envmodules_env` from the root folder.

