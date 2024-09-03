# Load necessary libraries
install.packages(c("ggplot2", "plotly"))
library(ggplot2)  # For advanced plotting
library(plotly)   # For interactive plotting

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility
data <- data.frame(
  Category = rep(c("A", "B", "C"), each = 20),
  SubCategory = rep(c("X", "Y"), times = 30),
  Value1 = rnorm(60, mean = 50, sd = 10),
  Value2 = rnorm(60, mean = 30, sd = 5),
  Group = rep(c("G1", "G2"), times = 30)
)

### 1. Creating Custom Themes in ggplot2

# Custom ggplot2 theme
custom_theme <- theme(
  plot.title = element_text(face = "bold", size = 14, hjust = 0.5, color = "darkblue"),
  axis.title = element_text(face = "bold", size = 12),
  axis.text = element_text(size = 10, color = "darkgray"),
  legend.position = "top",
  legend.title = element_text(face = "bold"),
  panel.background = element_rect(fill = "white", color = "black"),
  panel.grid.major = element_line(color = "lightgray", size = 0.5),
  panel.grid.minor = element_blank()
)

# Scatter plot with custom theme
ggplot(data, aes(x = Value1, y = Value2, color = Category)) +
  geom_point(size = 3) +
  ggtitle("Scatter Plot with Custom Theme") +
  xlab("Value1") +
  ylab("Value2") +
  custom_theme

### 2. Faceting and Multi-Panel Plots

# Facet wrap by SubCategory
ggplot(data, aes(x = Value1, y = Value2, color = Category)) +
  geom_point(size = 2) +
  ggtitle("Facet Wrap by SubCategory") +
  xlab("Value1") +
  ylab("Value2") +
  custom_theme +
  facet_wrap(~ SubCategory)  # Create multiple panels by SubCategory

# Facet grid by Category and Group
ggplot(data, aes(x = Value1, y = Value2, color = Category)) +
  geom_point(size = 2) +
  ggtitle("Facet Grid by Category and Group") +
  xlab("Value1") +
  ylab("Value2") +
  custom_theme +
  facet_grid(Category ~ Group)  # Create a grid of panels by Category and Group

### 3. Interactive Plots using plotly

# Convert ggplot2 scatter plot to an interactive plotly plot
p <- ggplot(data, aes(x = Value1, y = Value2, color = Category)) +
  geom_point(size = 3) +
  ggtitle("Interactive Scatter Plot") +
  xlab("Value1") +
  ylab("Value2") +
  custom_theme

# Convert ggplot to interactive plotly plot
interactive_plot <- ggplotly(p)

# Display the interactive plot
interactive_plot
