# Load necessary libraries
install.packages(c("caret", "dplyr"))
library(caret)   # For machine learning functions like train-test split and preprocessing
library(dplyr)   # For data manipulation

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility
data <- data.frame(
  Age = rnorm(100, mean = 50, sd = 10),
  Income = rnorm(100, mean = 60000, sd = 15000),
  Expenses = rnorm(100, mean = 30000, sd = 5000),
  Purchase = sample(c(0, 1), 100, replace = TRUE)  # Binary target variable
)

# Preview the first few rows of the data
print("Original Data:")
print(head(data))

### 1. Train-Test Split

# Create a train-test split (80% training, 20% testing)
set.seed(123)  # Set seed for reproducibility
trainIndex <- createDataPartition(data$Purchase, p = 0.8, list = FALSE)

# Split the data into training and testing sets
train_data <- data[trainIndex, ]
test_data <- data[-trainIndex, ]

# Preview the train and test datasets
print("Training Data:")
print(head(train_data))
print("Testing Data:")
print(head(test_data))

### 2. Feature Scaling and Normalization

# a) Using Base R scale() for feature scaling

# Apply scaling to the training data
train_data_scaled <- train_data %>%
  mutate(
    Age = scale(Age),
    Income = scale(Income),
    Expenses = scale(Expenses)
  )

# Apply the same scaling to the testing data
test_data_scaled <- test_data %>%
  mutate(
    Age = scale(Age),
    Income = scale(Income),
    Expenses = scale(Expenses)
  )

print("Scaled Training Data (Using Base R scale()):")
print(head(train_data_scaled))

print("Scaled Testing Data (Using Base R scale()):")
print(head(test_data_scaled))

# b) Using caret::preProcess() for feature scaling and normalization

# Define preprocessing steps: center and scale
preprocessing_model <- preProcess(train_data[, c("Age", "Income", "Expenses")], method = c("center", "scale"))

# Apply preprocessing to training and testing data
train_data_preprocessed <- train_data
train_data_preprocessed[, c("Age", "Income", "Expenses")] <- predict(preprocessing_model, train_data[, c("Age", "Income", "Expenses")])

test_data_preprocessed <- test_data
test_data_preprocessed[, c("Age", "Income", "Expenses")] <- predict(preprocessing_model, test_data[, c("Age", "Income", "Expenses")])

print("Preprocessed Training Data (Using caret::preProcess()):")
print(head(train_data_preprocessed))

print("Preprocessed Testing Data (Using caret::preProcess()):")
print(head(test_data_preprocessed))
