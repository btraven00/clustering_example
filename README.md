A clustering example for omnibenchmark

# clustbench logics

First, install Gagolewski's:

```{shell}
pip install clustering-benchmarks
```

and check it loads with

```{python}
import clustbench
```

Second, download the data

```{shell}
git clone https://github.com/gagolews/clustering-data-v1
```

Third, unpack these in an omnibenchmark-friendly way so datasets are this initial note params

```
for each dataset d:
  move the output to ./data/gagolewski/d/d.txt and ./data/gagolewski/d/d.labels 
```

Fourth, use `clustbench` to run methods, I guess with one git module each? or shall we do the method param trick?

And consider running them... with the method being a parameter?

https://github.com/gagolews/clustering-results-v1/blob/master/.devel/catalogue_generate.py

Methods list at https://github.com/gagolews/clustering-results-v1/tree/master/.devel

Finally, compute metrics via genie - rather, via clustbench.

# Layout

```mermaid
flowchart LR
	classDef param fill:#f96
	subgraph data
		clustbench
	end
	subgraph clustering
		fastcluster
		clustbench --> fastcluster
	end
	subgraph metrics
		partition_metrics
		fastcluster --> partition_metrics
	end
	subgraph danielsdata
		iris_manual
		penguins
	end
	subgraph distances
		D1
		iris_manual --> D1
		penguins --> D1
	end
	subgraph danielmethods
		kmeans
		D1 --> kmeans
		ward
		D1 --> ward
	end
	subgraph danielsmetrics
		ari
		kmeans --> ari
		ward --> ari
		accuracy
		kmeans --> accuracy
		ward --> accuracy
	end
	subgraph params_clustbench
		-5565374754020884143['--dataset_generator', 'other', '--dataset_name', 'iris']
		8983997727873894073['--dataset_generator', 'wut', '--dataset_name', 'circles']
		-4602440467579321589['--dataset_generator', 'wut', '--dataset_name', 'cross']
		-7995422560476383722['--dataset_generator', 'wut', '--dataset_name', 'graph']
		4963981407642443080['--dataset_generator', 'wut', '--dataset_name', 'isolation']
	end
	params_clustbench:::param --o clustbench
	subgraph params_fastcluster
		-8296509647199038086['--linkage', 'complete']
		7436816576096085389['--linkage', 'ward']
		-6855714871391765199['--linkage', 'average']
		-1413812507111616190['--linkage', 'weighted']
		-2903241202758703087['--linkage', 'median']
		-181528400336016550['--linkage', 'centroid']
	end
	params_fastcluster:::param --o fastcluster
	subgraph params_partition_metrics
		187761634663550070['--metric', 'normalized_clustering_accuracy']
		8608787562393366551['--metric', 'adjusted_fm_score']
	end
	params_partition_metrics:::param --o partition_metrics
	subgraph params_D1
		-1397408468904890194['--measure', 'cosine']
		8994418791209828694['--measure', 'euclidean']
		-5037505237485033655['--measure', 'manhattan']
		3003222312609624864['--measure', 'chebyshev']
	end
	params_D1:::param --o D1


```
