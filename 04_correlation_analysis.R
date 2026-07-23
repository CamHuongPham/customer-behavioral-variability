# Compute pairwise correlations among the behavioral descriptors.

cor_table <- data.frame(
  `Descriptor pair` = c(
    "Frequency – Diversity",
    "Frequency – Entropy",
    "Diversity – Entropy"
  ),
  `Correlation coefficient (r)` = round(c(
    cor(customer_metrics$Frequency,
        customer_metrics$Diversity,
        use = "complete.obs"),
    cor(customer_metrics$Frequency,
        customer_metrics$Entropy,
        use = "complete.obs"),
    cor(customer_metrics$Diversity,
        customer_metrics$Entropy,
        use = "complete.obs")
  ), 2),
  check.names = FALSE
)

# Export the correlation table.

write.csv(
  cor_table,
  "results/correlation_table.csv",
  row.names = FALSE
)

# Display the correlation table.

print(cor_table)
