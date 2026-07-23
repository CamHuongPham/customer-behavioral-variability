# Perform K-means clustering and summarize customer segment profiles.

set.seed(123)

kmeans_final <- kmeans(
  cluster_scaled,
  centers = 3,
  nstart = 25
)

customer_metrics$Cluster <- factor(kmeans_final$cluster)

cluster_profile <- aggregate(
  customer_metrics[, c("Frequency", "Diversity", "Entropy")],
  by = list(Cluster = customer_metrics$Cluster),
  FUN = mean
)

cluster_profile[, 2:4] <- round(cluster_profile[, 2:4], 2)

# Display the cluster profiles.

print(cluster_profile)
