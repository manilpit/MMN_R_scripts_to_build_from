# Load necessary libraries
install.packages(c("caret", "randomForest", "e1071"))
library(caret)          # For machine learning model training and cross-validation
library(randomForest)   # For Random Forest algorithm
library(e1071)          # For Support Vector Machines (SVM)

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
set.seed(123)  # For reproducibility
data <- data.frame(
  Age = rnorm(100, mean = 50, sd = 10),
  Income = rnorm(100, mean = 60000, sd = 15000),
  Expenses = rnorm(100, mean = 30000, sd = 5000),
  Purchase = factor(sample(c(0, 1), 100, replace = TRUE))  # Binary target variable
)

# Train-test split (80% training, 20% testing)
set.seed(123)
trainIndex <- createDataPartition(data$Purchase, p = 0.8, list = FALSE)
train_data <- data[trainIndex, ]
test_data <- data[-trainIndex, ]

### 1. Random Forest Model Building with Cross-Validation and Hyperparameter Tuning

# Define cross-validation method
control_rf <- trainControl(method = "cv", number = 5)  # 5-fold cross-validation

# Define grid for hyperparameter tuning
tune_grid_rf <- expand.grid(
  mtry = c(1, 2, 3),  # Number of variables randomly sampled as candidates at each split
  splitrule = c("gini", "extratrees"),  # Split rule
  min.node.size = c(1, 5, 10)  # Minimum size of terminal nodes
)

# Train the Random Forest model with cross-validation
set.seed(123)
rf_model <- train(
  Purchase ~ ., data = train_data,
  method = "rf",
  trControl = control_rf,
  tuneGrid = tune_grid_rf
)

# Print the Random Forest model summary
print("Random Forest Model with Cross-Validation:")
print(rf_model)

# Predict on test data
rf_predictions <- predict(rf_model, newdata = test_data)
print("Random Forest Predictions on Test Data:")
print(rf_predictions)

# Confusion matrix for Random Forest model
rf_confusion <- confusionMatrix(rf_predictions, test_data$Purchase)
print("Confusion Matrix for Random Forest Model:")
print(rf_confusion)

### 2. Support Vector Machine (SVM) Model Building with Cross-Validation and Hyperparameter Tuning

# Define cross-validation method for SVM
control_svm <- trainControl(method = "cv", number = 5)  # 5-fold cross-validation

# Define grid for hyperparameter tuning for SVM
tune_grid_svm <- expand.grid(
  C = c(0.1, 1, 10),  # Regularization parameter
  sigma = c(0.01, 0.1, 1)  # RBF kernel parameter
)

# Train the SVM model with cross-validation
set.seed(123)
svm_model <- train(
  Purchase ~ ., data = train_data,
  method = "svmRadial",
  trControl = control_svm,
  tuneGrid = tune_grid_svm
)

# Print the SVM model summary
print("SVM Model with Cross-Validation:")
print(svm_model)

# Predict on test data using SVM model
svm_predictions <- predict(svm_model, newdata = test_data)
print("SVM Predictions on Test Data:")
print(svm_predictions)

# Confusion matrix for SVM model
svm_confusion <- confusionMatrix(svm_predictions, test_data$Purchase)
print("Confusion Matrix for SVM Model:")
print(svm_confusion)
