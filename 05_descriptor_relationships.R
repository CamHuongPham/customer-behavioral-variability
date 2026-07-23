library(ggplot2)
library(patchwork)

# Visualize the relationships among the behavioral descriptors.

p1 <- ggplot(customer_metrics, aes(x = Frequency, y = Diversity)) +
  geom_point(alpha = 0.4, color = "steelblue") +
  theme_minimal(base_size = 16) +
  labs(
    x = "Frequency",
    y = "Diversity"
  )

p2 <- ggplot(customer_metrics, aes(x = Diversity, y = Entropy)) +
  geom_point(alpha = 0.4, color = "orange") +
  theme_minimal(base_size = 16) +
  labs(
    x = "Diversity",
    y = "Entropy"
  )

relationship_plot <- (p1 + p2) +
  plot_annotation(tag_levels = "A") &
  theme(
    plot.tag = element_text(face = "bold", size = 18),
    plot.tag.position = c(0, 1)
  )

# Save the figure.

ggsave(
  filename = "figures/descriptor_relationships.png",
  plot = relationship_plot,
  width = 10,
  height = 5,
  dpi = 300
)

# Display the figure.

relationship_plot
