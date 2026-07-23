library(dplyr)

# data_clean is created in 01_data_preprocessing.R

freq_table <- data_clean %>%
  group_by(`Customer ID`) %>%
  summarise(
    Frequency = n_distinct(Invoice),
    .groups = "drop"
  )

diversity_table <- data_clean %>%
  group_by(`Customer ID`) %>%
  summarise(
    Diversity = n_distinct(StockCode),
    .groups = "drop"
  )

entropy_detail <- data_clean %>%
  group_by(`Customer ID`, StockCode) %>%
  summarise(
    PurchaseCount = n(),
    .groups = "drop"
  ) %>%
  group_by(`Customer ID`) %>%
  mutate(
    Probability = PurchaseCount / sum(PurchaseCount)
  )

entropy_table <- entropy_detail %>%
  group_by(`Customer ID`) %>%
  summarise(
    Entropy = -sum(Probability * log2(Probability)),
    .groups = "drop"
  )

customer_metrics <- freq_table %>%
  inner_join(diversity_table, by = "Customer ID") %>%
  inner_join(entropy_table, by = "Customer ID")

summary_table <- data.frame(
  Statistic = c(
    "N",
    "Mean",
    "Median",
    "Standard Deviation",
    "Minimum",
    "Q1 (25%)",
    "Q3 (75%)",
    "Maximum"
  ),
  Frequency = c(
    nrow(customer_metrics),
    mean(customer_metrics$Frequency),
    median(customer_metrics$Frequency),
    sd(customer_metrics$Frequency),
    min(customer_metrics$Frequency),
    quantile(customer_metrics$Frequency, 0.25),
    quantile(customer_metrics$Frequency, 0.75),
    max(customer_metrics$Frequency)
  ),
  Diversity = c(
    nrow(customer_metrics),
    mean(customer_metrics$Diversity),
    median(customer_metrics$Diversity),
    sd(customer_metrics$Diversity),
    min(customer_metrics$Diversity),
    quantile(customer_metrics$Diversity, 0.25),
    quantile(customer_metrics$Diversity, 0.75),
    max(customer_metrics$Diversity)
  ),
  Entropy = c(
    nrow(customer_metrics),
    mean(customer_metrics$Entropy),
    median(customer_metrics$Entropy),
    sd(customer_metrics$Entropy),
    min(customer_metrics$Entropy),
    quantile(customer_metrics$Entropy, 0.25),
    quantile(customer_metrics$Entropy, 0.75),
    max(customer_metrics$Entropy)
  )
)

# Format summary statistics for reporting
summary_table[, -1] <- round(summary_table[, -1], 2)

summary_table[, -1] <- lapply(summary_table[, -1], function(x) sprintf("%.2f", x))

summary_table[1, 2:4] <- lapply(summary_table[1, 2:4], function(x) sprintf("%.0f", as.numeric(x)))
                                
# Save the summary statistics.

write.csv(
  summary_table,
  "results/summary_statistics.csv",
  row.names = FALSE
)

# Display the summary statistics.

print(summary_table)
