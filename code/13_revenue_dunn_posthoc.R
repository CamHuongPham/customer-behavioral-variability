library(dplyr)
library(rstatix)
library(knitr)

# Perform Dunn's post-hoc tests for pairwise revenue comparisons across clusters.

posthoc <- dunn_test(
  customer_metrics,
  Total_Revenue ~ Cluster,
  p.adjust.method = "holm"
)

revenue_dunn_table <- posthoc %>%
  transmute(
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

# Save the Dunn's post-hoc revenue validation results.

write.csv(
  revenue_dunn_table,
  "results/revenue_dunn_posthoc.csv",
  row.names = FALSE
)

# Display the Dunn's post-hoc revenue validation results.

print(revenue_dunn_table)
