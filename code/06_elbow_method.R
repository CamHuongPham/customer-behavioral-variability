# Determine the optimal number of clusters using the Elbow method.

cluster_data <- customer_metrics[, c("Frequency", "Diversity", "Entropy")]

cluster_scaled <- scale(cluster_data)

set.seed(123)

wss <- numeric(10)

for (k in 1:10) {
  kmeans_model <- kmeans(
    cluster_scaled,
    centers = k,
    nstart = 25
  )

  wss[k] <- kmeans_model$tot.withinss
}

# Save the elbow plot.

png(
  filename = "figures/elbow_method.png",
  width = 1800,
  height = 1200,
  res = 300
)

plot(
  1:10,
  wss,
  type = "b",
  pch = 19,
  frame = FALSE,
  xlab = "Number of clusters (K)",
  ylab = "Within-cluster sum of squares"
)

dev.off()

# Display the elbow plot.

plot(
  1:10,
  wss,
  type = "b",
  pch = 19,
  frame = FALSE,
  xlab = "Number of clusters (K)",
  ylab = "Within-cluster sum of squares"
)
