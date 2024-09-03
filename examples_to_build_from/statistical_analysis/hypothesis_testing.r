# Load necessary libraries
install.packages(c("dplyr"))
library(dplyr)  # For data manipulation

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility

# Data for t-tests
data_ttest <- data.frame(
  Group = rep(c("A", "B"), each = 30),
  Score = c(rnorm(30, mean = 50, sd = 10), rnorm(30, mean = 55, sd = 10))
)

# Data for Chi-square test
data_chisq <- data.frame(
  Gender = rep(c("Male", "Female"), times = 50),
  Preference = sample(c("Product X", "Product Y"), 100, replace = TRUE)
)

# Data for ANOVA
data_anova <- data.frame(
  Treatment = rep(c("Control", "Treatment1", "Treatment2"), each = 20),
  Outcome = c(rnorm(20, mean = 5, sd = 2), rnorm(20, mean = 7, sd = 2), rnorm(20, mean = 9, sd = 2))
)

### 1. T-Tests

# a) One-sample t-test
print("One-sample t-test:")
one_sample_test <- t.test(data_ttest$Score, mu = 50)  # Test if the mean score is 50
print(one_sample_test)

# b) Two-sample t-test (independent t-test)
print("Two-sample t-test (Independent):")
two_sample_test <- t.test(Score ~ Group, data = data_ttest, var.equal = TRUE)  # Test difference between Group A and Group B
print(two_sample_test)

# c) Paired t-test
# Creating a paired dataset for demonstration
data_paired <- data.frame(
  Before = rnorm(30, mean = 100, sd = 15),
  After = rnorm(30, mean = 105, sd = 15)
)

print("Paired t-test:")
paired_test <- t.test(data_paired$Before, data_paired$After, paired = TRUE)  # Test difference between paired samples
print(paired_test)

### 2. Chi-Square Test

# Create a contingency table for Gender vs. Preference
contingency_table <- table(data_chisq$Gender, data_chisq$Preference)

print("Contingency Table for Chi-Square Test:")
print(contingency_table)

# Perform Chi-square test
print("Chi-square test:")
chisq_test <- chisq.test(contingency_table)  # Test independence between Gender and Preference
print(chisq_test)

### 3. ANOVA (Analysis of Variance)

# One-way ANOVA to test differences between Treatment groups
print("One-way ANOVA:")
anova_test <- aov(Outcome ~ Treatment, data = data_anova)
print(summary(anova_test))  # Show ANOVA table

# Post-hoc test (Tukey's HSD) to check which groups are different
print("Post-hoc analysis using Tukey's HSD:")
tukey_test <- TukeyHSD(anova_test)
print(tukey_test)
