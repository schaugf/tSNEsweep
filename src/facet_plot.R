suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
suppressMessages(library(ggplot2))

args <- commandArgs(trailingOnly = TRUE)
# load all csv encoding files into memory and facet plot as a 6x6 grid
results_dir = args[1]

coord_dir = file.path(results_dir, 'coords')

all_coords = NULL
for (file in list.files(coord_dir)) {
  data = read.table(file.path(coord_dir, file))
  data$filename = rep(file, nrow(data))
  all_coords = rbind(all_coords, data)
}

names(all_coords) = c('tsne1', 'tsne2', 'filename')
all_coords = all_coords[order(all_coords$filename), ]

ggplot(all_coords) + 
  geom_point(aes(x=tsne1, y=tsne2), size=0.2) +
  theme_minimal() +
  facet_wrap(~filename) +
  ggsave(file.path(results_dir, 'tSNEsweep.pdf'),
         height=10, width=10, units='in', device='pdf')
