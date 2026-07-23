# Dunn's post-hoc pairwise comparisons with Holm adjustment

library(dplyr)
library(FSA)
library(knitr)

# Pairwise comparisons for each behavioral descriptor
dunn_frequency <- dunnTest(
  Frequency ~ Cluster,
  data = customer_metrics,
  method = "holm"
)$res %>%
  mutate(`Behavioral descriptor` = "Frequency")

dunn_diversity <- dunnTest(
  Diversity ~ Cluster,
  data = customer_metrics,
  method = "holm"
)$res %>%
  mutate(`Behavioral descriptor` = "Diversity")

dunn_entropy <- dunnTest(
  Entropy ~ Cluster,
  data = customer_metrics,
  method = "holm"
)$res %>%
  mutate(`Behavioral descriptor` = "Entropy")

# Combine and format Dunn's test results
dunn_table <- bind_rows(
  dunn_frequency,
  dunn_diversity,
  dunn_entropy
) %>%
  transmute(
    `Behavioral descriptor`,
    `Cluster comparison` = gsub(
      "(\\d+) - (\\d+)",
      "Cluster \\1 – Cluster \\2",
      Comparison
    ),
    `Z statistic` = round(Z, 2),
    `Adjusted p-value` = ifelse(
      P.adj < 0.001,
      "< 0.001",
      sprintf("%.3f", P.adj)
    )
  )


# Save results
write.csv(
  dunn_table,
  "results/dunn_posthoc_results.csv",
  row.names = FALSE
)

# Display the Dunn's post-hoc results
print(dunn_table)
