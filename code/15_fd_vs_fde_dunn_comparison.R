library(dplyr)
library(rstatix)
library(knitr)

# Compare pairwise revenue differences between FD and FDE representations.

posthoc_FD <- dunn_test(
  customer_metrics,
  Total_Revenue ~ Cluster_FD,
  p.adjust.method = "holm"
)

posthoc_FDE <- dunn_test(
  customer_metrics,
  Total_Revenue ~ Cluster,
  p.adjust.method = "holm"
)


comparison_dunn <- bind_rows(
  posthoc_FD %>%
    mutate(Representation = "FD"),
  posthoc_FDE %>%
    mutate(Representation = "FDE")
) %>%
  transmute(
    Representation,
    `Cluster comparison` = paste(
      "Cluster", group1,
      "–",
      "Cluster", group2
    ),
    `Z statistic` = round(statistic, 2),
    `Adjusted p-value` = ifelse(
      p.adj < 0.001,
      "< 0.001",
      sprintf("%.3f", p.adj)
    )
  )


# Save the FD versus FDE Dunn post-hoc comparison results.

write.csv(
  comparison_dunn,
  "results/fd_vs_fde_dunn_comparison.csv",
  row.names = FALSE
)

# Display the Dunn post-hoc comparison results.

print(comparison_dunn)
