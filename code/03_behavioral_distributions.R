library(ggplot2)

# Visualize the distributions of the three behavioral descriptors.

# Distribution of purchase frequency
freq_hist <- ggplot(customer_metrics, aes(x = Frequency)) +
  geom_histogram(
    bins = 30,
    fill = "steelblue"
  ) +
  labs(
    x = "Purchase Frequency",
    y = "Number of Customers"
  ) +
  theme_minimal(base_size = 11)

ggsave(
  filename = "figures/frequency_distribution.png",
  plot = freq_hist,
  width = 6,
  height = 4,
  dpi = 300
)


# Distribution of product diversity
diversity_hist <- ggplot(customer_metrics, aes(x = Diversity)) +
  geom_histogram(
    bins = 30,
    fill = "steelblue"
  ) +
  labs(
    x = "Number of Unique Products Purchased",
    y = "Number of Customers"
  ) +
  theme_minimal(base_size = 11)

ggsave(
  filename = "figures/diversity_distribution.png",
  plot = diversity_hist,
  width = 6,
  height = 4,
  dpi = 300
)


# Distribution of behavioral entropy
entropy_hist <- ggplot(customer_metrics, aes(x = Entropy)) +
  geom_histogram(
    bins = 30,
    fill = "steelblue"
  ) +
  labs(
    x = "Behavioral Entropy",
    y = "Number of Customers"
  ) +
  theme_minimal(base_size = 11)

ggsave(
  filename = "figures/entropy_distribution.png",
  plot = entropy_hist,
  width = 6,
  height = 4,
  dpi = 300
)
