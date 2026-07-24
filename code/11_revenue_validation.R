library(dplyr)
library(knitr)

# Calculate customer revenue for managerial validation.

data_clean <- data_clean %>%
  mutate(Revenue = Quantity * Price)

customer_revenue <- data_clean %>%
  group_by(`Customer ID`) %>%
  summarise(
    Total_Revenue = sum(Revenue, na.rm = TRUE),
    .groups = "drop"
  )

# Attach customer revenue to the behavioral representation.

customer_metrics <- customer_metrics %>%
  left_join(customer_revenue, by = "Customer ID")


# Summarize revenue differences across customer segments.

revenue_table <- customer_metrics %>%
  group_by(Cluster) %>%
  summarise(
    Mean = round(mean(Total_Revenue), 0),
    Median = round(median(Total_Revenue), 0),
    SD = round(sd(Total_Revenue), 0),
    Min = round(min(Total_Revenue), 0),
    Max = round(max(Total_Revenue), 0),
    n = n(),
    .groups = "drop"
  ) %>%
  mutate(
    Cluster = paste("Cluster", Cluster),
    across(
      c(Mean, Median, SD, Min, Max, n),
      ~ format(.x, big.mark = ",", scientific = FALSE)
    )
  )

# Save the revenue validation results.

write.csv(
  revenue_table,
  "results/revenue_validation.csv",
  row.names = FALSE
)

# Display the revenue validation results.

print(revenue_table)
