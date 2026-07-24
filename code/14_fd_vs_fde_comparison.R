library(dplyr)
library(rstatix)
library(knitr)

# Compare FD and FDE representations using revenue-based validation.

cluster_data_FD <- customer_metrics[, c("Frequency", "Diversity")]

cluster_scaled_FD <- scale(cluster_data_FD)

set.seed(123)

kmeans_FD <- kmeans(
  cluster_scaled_FD,
  centers = 3,
  nstart = 25
)

customer_metrics$Cluster_FD <- as.factor(kmeans_FD$cluster)

# Evaluate revenue differentiation for the FD representation.

kw_FD <- kruskal_test(
  customer_metrics,
  Total_Revenue ~ Cluster_FD
)

effect_FD <- kruskal_effsize(
  customer_metrics,
  Total_Revenue ~ Cluster_FD
)

# Evaluate revenue differentiation for the FDE representation.

kw <- kruskal_test(
  customer_metrics,
  Total_Revenue ~ Cluster
)

effect <- kruskal_effsize(
  customer_metrics,
  Total_Revenue ~ Cluster
)


comparison_table <- data.frame(
  Representation = c("FD", "FDE"),
  `Kruskal-Wallis statistic` = c(
    round(kw_FD$statistic, 0),
    round(kw$statistic, 0)
  ),
  df = c(
    kw_FD$df,
    kw$df
  ),
  `p-value` = c(
    ifelse(
      kw_FD$p < 0.001,
      "< 0.001",
      sprintf("%.3f", kw_FD$p)
    ),
    ifelse(
      kw$p < 0.001,
      "< 0.001",
      sprintf("%.3f", kw$p)
    )
  ),
  `Eta-squared` = c(
    round(effect_FD$effsize, 3),
    round(effect$effsize, 3)
  ),
  `Effect size` = c(
    effect_FD$magnitude,
    effect$magnitude
  ),
  check.names = FALSE
)

# Save the FD versus FDE comparison results.

write.csv(
  comparison_table,
  "results/fd_vs_fde_comparison.csv",
  row.names = FALSE
)

# Display the comparison results.

print(comparison_table)
