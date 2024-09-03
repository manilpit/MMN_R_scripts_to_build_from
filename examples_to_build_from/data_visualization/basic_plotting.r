# Load necessary libraries
install.packages("ggplot2")
library(ggplot2)  # For advanced plotting

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility
data <- data.frame(
  Category = rep(c("A", "B", "C"), each = 10),
  Value1 = rnorm(30, mean = 50, sd = 10),
  Value2 = rnorm(30, mean = 30, sd = 5)
)

# Base R Plotting

## 1. Scatter Plot using Base R
plot(data$Value1, data$Value2,
     main = "Scatter Plot (Base R)",
     xlab = "Value1",
     ylab = "Value2",
     pch = 19,        # Plotting character (filled circles)
     col = "blue")    # Color of points

## 2. Histogram using Base R
hist(data$Value1,
     main = "Histogram of Value1 (Base R)",
     xlab = "Value1",
     col = "lightblue",
     border = "black")

## 3. Boxplot using Base R
boxplot(Value1 ~ Category, data = data,
        main = "Boxplot of Value1 by Category (Base R)",
        xlab = "Category",
        ylab = "Value1",
        col = c("orange", "green", "purple"))

# ggplot2 Plotting

## 1. Scatter Plot using ggplot2
ggplot(data, aes(x = Value1, y = Value2)) +
  geom_point(color = "blue", size = 2) +
  ggtitle("Scatter Plot (ggplot2)") +
  xlab("Value1") +
  ylab("Value2") +
  theme_minimal()

## 2. Histogram using ggplot2
ggplot(data, aes(x = Value1)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +
  ggtitle("Histogram of Value1 (ggplot2)") +
  xlab("Value1") +
  ylab("Frequency") +
  theme_minimal()

## 3. Boxplot using ggplot2
ggplot(data, aes(x = Category, y = Value1, fill = Category)) +
  geom_boxplot() +
  ggtitle("Boxplot of Value1 by Category (ggplot2)") +
  xlab("Category") +
  ylab("Value1") +
  theme_minimal() +
  scale_fill_manual(values = c("orange", "green", "purple"))

## 4. Bar Chart using ggplot2
ggplot(data, aes(x = Category, fill = Category)) +
  geom_bar() +
  ggtitle("Bar Chart of Category (ggplot2)") +
  xlab("Category") +
  ylab("Count") +
  theme_minimal() +
  scale_fill_manual(values = c("orange", "green", "purple"))

## 5. Line Plot using ggplot2
# Create sample data for line plot
time_data <- data.frame(
  Time = 1:10,
  Measurement = cumsum(rnorm(10, mean = 0, sd = 1))
)

ggplot(time_data, aes(x = Time, y = Measurement)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  ggtitle("Line Plot (ggplot2)") +
  xlab("Time") +
  ylab("Measurement") +
  theme_minimal()
