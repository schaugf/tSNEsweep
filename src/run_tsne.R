library(Rtsne)
library(ggplot2)
library(stringr)

args <- commandArgs(trailingOnly = TRUE)

data.file = args[1]
perplexity = as.numeric(args[2])
results_dir = args[3]

data = read.csv(data.file)

suppressWarnings(dir.create(file.path(results_dir)))
suppressWarnings(dir.create(file.path(results_dir, 'coords')))
suppressWarnings(dir.create(file.path(results_dir, 'plots')))

tsne_results = Rtsne(data, perplexity=perplexity)

write.table(tsne_results$Y, 
            file=file.path(results_dir, 'coords', paste0('tsne_coords_', str_pad(perplexity, 2, pad='0'), '.csv')),
            row.names=F, col.names=F, quote=F)

pd <- as.data.frame(tsne_results$Y)
names(pd) = c('tsne1', 'tsne2')

ggplot(pd) +
    geom_point(aes(x=tsne1, y=tsne2)) +
    theme_minimal() +
    ggtitle(paste('Perplexity:', perplexity)) +
    ggsave(file.path(results_dir, 'plots', paste0('tsne_plot_', perplexity, '.pdf')),
           height=5, width=5, units='in', device='pdf')



