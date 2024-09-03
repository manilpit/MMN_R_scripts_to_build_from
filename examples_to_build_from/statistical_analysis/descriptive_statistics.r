# Load necessary libraries
install.packages(c("dplyr", "skimr", "Hmisc"))
library(dplyr)  # For data manipulation and summarization
library(skimr)  # For comprehensive summary statistics
library(Hmisc)  # For correlation matrices with significance levels

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility
data <- data.frame(
  Category = rep(c("A", "B", "C"), each = 20),
  Value1 = rnorm(60, mean = 50, sd = 10),
  Value2 = rnorm(60, mean = 30, sd = 5),
  Value3 = rnorm(60, mean = 100, sd = 20)
)

### 1. Summary Statistics

# a) Using Base R summary() function
print("Summary Statistics using Base R:")
print(summary(data))

# b) Using dplyr's summarize() for custom summaries
print("Summary Statistics using dplyr:")
summary_data <- data %>%
  group_by(Category) %>%
  summarize(
    Mean_Value1 = mean(Value1, na.rm = TRUE),
    SD_Value1 = sd(Value1, na.rm = TRUE),
    Mean_Value2 = mean(Value2, na.rm = TRUE),
    SD_Value2 = sd(Value2, na.rm = TRUE),
    Mean_Value3 = mean(Value3, na.rm = TRUE),
    SD_Value3 = sd(Value3, na.rm = TRUE),
    Count = n()
  )

print(summary_data)

# c) Using skimr for a comprehensive summary
print("Summary Statistics using skimr:")
skimmed_data <- skim(data)
print(skimmed_data)

### 2. Correlation Matrices

# a) Using Base R cor() function
print("Correlation Matrix using Base R:")
cor_matrix <- cor(data[, c("Value1", "Value2", "Value3")], use = "complete.obs")
print(cor_matrix)

# b) Using Hmisc::rcorr() for correlation matrix with significance levels
print("Correlation Matrix with Significance using Hmisc:")
cor_matrix_hmisc <- rcorr(as.matrix(data[, c("Value1", "Value2", "Value3")]))
print(cor_matrix_hmisc$r)  # Correlation coefficients
print(cor_matrix_hmisc$P)  # P-values for significance

# Correlation matrix with both correlation coefficients and p-values
correlation_results <- list(
  Correlation_Coefficients = cor_matrix_hmisc$r,
  P_Values = cor_matrix_hmisc$P
)

print("Correlation Coefficients:")
print(correlation_results$Correlation_Coefficients)

print("P-Values for Significance:")
print(correlation_results$P_Values)
