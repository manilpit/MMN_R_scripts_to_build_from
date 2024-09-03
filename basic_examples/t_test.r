# basic_statistical_analysis.R

# Sample data
data <- data.frame(
  group = rep(c("Control", "Treatment"), each = 50),
  value = c(rnorm(50, mean = 5), rnorm(50, mean = 7))
)

# Perform a t-test to compare means between groups
t_test_result <- t.test(value ~ group, data = data)

# Print the results of the t-test
print(t_test_result)
