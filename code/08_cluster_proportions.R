# Calculate the proportion of customers assigned to each behavioral segment.

cluster_prop <- data.frame(
  Cluster = paste("Cluster", levels(customer_metrics$Cluster)),
  `Customer proportion` = paste0(
    sprintf(
      "%.2f",
      prop.table(table(customer_metrics$Cluster)) * 100
    ),
    "%"
  ),
  check.names = FALSE
)

# Display the cluster proportions.

print(cluster_prop)
