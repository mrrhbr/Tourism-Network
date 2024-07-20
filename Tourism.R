# Load necessary libraries
library(igraph)
library(RColorBrewer)

# Define the countries
countries <- c("China", "Japan", "S. Korea", "India", "Thailand", "Malaysia", "Singapore")

# Simulated adjacency matrix with tourist exchange data (in thousands, averaged from 2000 to 2010)
tourist_matrix <- matrix(c(
  0, 3200, 4100, 2300, 3700, 1600, 1900,
  3200, 0, 2100, 600, 1600, 1300, 1500,
  4100, 2100, 0, 800, 1800, 1400, 1700,
  2300, 600, 800, 0, 1000, 500, 700,
  3700, 1600, 1800, 1000, 0, 2200, 2700,
  1600, 1300, 1400, 500, 2200, 0, 900,
  1900, 1500, 1700, 700, 2700, 900, 0
), nrow = 7, byrow = TRUE)

# Create the graph object
tourist_graph <- graph.adjacency(tourist_matrix, mode = "directed", weighted = TRUE, diag = TRUE)

# Set vertex attributes
V(tourist_graph)$name <- countries
V(tourist_graph)$color <- brewer.pal(7, "Set3")

# Set vertex size related to the total amount of exchanges
V(tourist_graph)$size <- rowSums(tourist_matrix) / 300

# Set edge attributes
E(tourist_graph)$weight <- E(tourist_graph)$weight / 1000  # scale weights for better visualization
E(tourist_graph)$color <- "grey"
E(tourist_graph)$width <- E(tourist_graph)$weight

# Plot the graph with longer edge lengths and visible arrow tips
plot(tourist_graph, vertex.label = V(tourist_graph)$name, vertex.label.cex = .5, edge.arrow.size = 0.5, layout = layout_with_fr(tourist_graph, niter = 200000), vertex.label.dist = 0)

