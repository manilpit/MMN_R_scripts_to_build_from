# Load necessary libraries
install.packages(c("dplyr", "ggplot2", "car", "broom"))
library(dplyr)  # For data manipulation
library(ggplot2)  # For data visualization
library(car)  # For regression diagnostics
library(broom)  # For tidying model outputs

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation for linear regression
set.seed(123)  # For reproducibility
data_linear <- data.frame(
  Age = rnorm(100, mean = 50, sd = 10),
  Income = rnorm(100, mean = 60000, sd = 15000),
  Expenses = rnorm(100, mean = 30000, sd = 5000)
)

# Adding a dependent variable that is linearly related to Age and Income
data_linear$SpendingScore <- 50 + 0.5 * data_linear$Age + 0.4 * data_linear$Income + rnorm(100, mean = 0, sd = 2000)

### 1. Linear Regression

# Fit a linear regression model
linear_model <- lm(SpendingScore ~ Age + Income + Expenses, data = data_linear)

# Summary of the linear regression model
print("Linear Regression Model Summary:")
print(summary(linear_model))

# Model diagnostics: Variance Inflation Factor (VIF) to check multicollinearity
print("Variance Inflation Factor (VIF):")
vif_values <- vif(linear_model)
print(vif_values)

# Visualizing regression diagnostics using ggplot2
par(mfrow = c(2, 2))  # Set up 2x2 plotting space
plot(linear_model)  # Base R diagnostic plots

# Tidy model output using broom
print("Tidy Model Output using broom:")
linear_model_tidy <- tidy(linear_model)
print(linear_model_tidy)

### 2. Logistic Regression

# Sample data creation for logistic regression
data_logistic <- data.frame(
  Age = rnorm(100, mean = 50, sd = 10),
  Income = rnorm(100, mean = 60000, sd = 15000),
  OwnsHouse = sample(c(0, 1), 100, replace = TRUE)
)

# Adding a dependent variable that is binary
data_logistic$PurchaseDecision <- ifelse(0.5 * data_logistic$Age + 0.4 * data_logistic$Income - 100000 > 0, 1, 0)

# Fit a logistic regression model
logistic_model <- glm(PurchaseDecision ~ Age + Income + OwnsHouse, data = data_logistic, family = "binomial")

# Summary of the logistic regression model
print("Logistic Regression Model Summary:")
print(summary(logistic_model))

# Tidy model output using broom
print("Tidy Model Output for Logistic Regression using broom:")
logistic_model_tidy <- tidy(logistic_model)
print(logistic_model_tidy)

# Model diagnostics: Checking multicollinearity with VIF (only for explanatory variables)
print("Variance Inflation Factor (VIF) for Logistic Regression:")
vif_logistic <- vif(logistic_model)
print(vif_logistic)

### 3. Model Validation

# a) Predicting on new data for linear regression
print("Predictions from Linear Regression Model:")
new_data_linear <- data.frame(Age = c(40, 60), Income = c(70000, 80000), Expenses = c(35000, 30000))
linear_predictions <- predict(linear_model, newdata = new_data_linear)
print(linear_predictions)

# b) Predicting probabilities on new data for logistic regression
print("Predicted Probabilities from Logistic Regression Model:")
new_data_logistic <- data.frame(Age = c(40, 60), Income = c(70000, 80000), OwnsHouse = c(1, 0))
logistic_predictions <- predict(logistic_model, newdata = new_data_logistic, type = "response")
print(logistic_predictions)
