library(rstatix)

# Evaluate behavioral differentiation across customer segments using Kruskal–Wallis tests.

kw_frequency <- kruskal.test(
  Frequency ~ Cluster,
  data = customer_metrics
)

kw_diversity <- kruskal.test(
  Diversity ~ Cluster,
  data = customer_metrics
)

kw_entropy <- kruskal.test(
  Entropy ~ Cluster,
  data = customer_metrics
)

eps_frequency <- kruskal_effsize(
  customer_metrics,
  Frequency ~ Cluster
)

eps_diversity <- kruskal_effsize(
  customer_metrics,
  Diversity ~ Cluster
)

eps_entropy <- kruskal_effsize(
  customer_metrics,
  Entropy ~ Cluster
)

kruskal_table <- data.frame(
  `Behavioral descriptor` = c(
    "Frequency",
    "Diversity",
    "Entropy"
  ),
  `Kruskal-Wallis statistic` = round(
    c(
      kw_frequency$statistic,
      kw_diversity$statistic,
      kw_entropy$statistic
    ),
    2
  ),
  df = c(
    kw_frequency$parameter,
    kw_diversity$parameter,
    kw_entropy$parameter
  ),
  `p-value` = ifelse(
    c(
      kw_frequency$p.value,
      kw_diversity$p.value,
      kw_entropy$p.value
    ) < 0.001,
    "< 0.001",
    sprintf(
      "%.3f",
      c(
        kw_frequency$p.value,
        kw_diversity$p.value,
        kw_entropy$p.value
      )
    )
  ),
  `Eta-squared` = round(
    c(
      eps_frequency$effsize,
      eps_diversity$effsize,
      eps_entropy$effsize
    ),
    3
  ),
  `Effect size` = c(
    eps_frequency$magnitude,
    eps_diversity$magnitude,
    eps_entropy$magnitude
  ),
  check.names = FALSE
)

# Save the Kruskal-Wallis test results.

write.csv(
  kruskal_table,
  "results/kruskal_table.csv",
  row.names = FALSE
)

# Display the Kruskal-Wallis test results.

print(kruskal_table)
