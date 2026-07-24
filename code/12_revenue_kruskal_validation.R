library(rstatix)
library(knitr)

# Evaluate revenue differences across customer segments using Kruskal–Wallis test.

kw <- kruskal_test(
  customer_metrics,
  Total_Revenue ~ Cluster
)

effect <- kruskal_effsize(
  customer_metrics,
  Total_Revenue ~ Cluster
)

revenue_kw_table <- data.frame(
  Variable = "Total revenue",
  `Kruskal-Wallis statistic` = round(kw$statistic, 0),
  df = kw$df,
  `p-value` = ifelse(
    kw$p < 0.001,
    "< 0.001",
    sprintf("%.3f", kw$p)
  ),
  `Eta-squared` = round(effect$effsize, 3),
  `Effect size` = effect$magnitude,
  check.names = FALSE
)

# Save the revenue Kruskal–Wallis validation results.

write.csv(
  revenue_kw_table,
  "results/revenue_kruskal_validation.csv",
  row.names = FALSE
)

# Display the revenue Kruskal–Wallis validation results.

print(revenue_kw_table)
