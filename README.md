# tSNE Sweep with Slurm

I got tired of guessing which perplexity parameters made sense for my data.
tSNE is well-suited for visualizing many types of data in two dimensions, though the algorithm is sensitive to perplexity parameterization.
This simply utility is designed to parallelize tSNE runs at varying perplexities and combine the computed embeddings as a facet plot.

To run, point the submit.sh script to your datafile you wish to visualize with tSNE and name a save directory.
The file should be saved as a flat csv file with no rownames or headers (see example data file).

```bash
sbatch submit.sh etc/sample_data.csv results
```

The output should look something like this (though not exactly as tSNE is a stochastic algorithm)

![tSNEsweep][etc/tSNEsweep.png]

