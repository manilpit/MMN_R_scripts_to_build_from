# data_visualization.R

# Load necessary libraries
library(ggplot2)

# Sample data frame
data <- data.frame(
  x = rnorm(100),
  y = rnorm(100, mean = 1)
)

# Scatter plot of x vs. y
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  labs(title = "Scatter Plot of x vs. y", x = "X-axis", y = "Y-axis") +
  theme_minimal()
