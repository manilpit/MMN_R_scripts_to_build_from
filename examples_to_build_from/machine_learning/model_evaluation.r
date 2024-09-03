# Load necessary libraries
install.packages(c("caret", "randomForest", "e1071", "ROCR"))
library(caret)          # For confusion matrix and model evaluation
library(randomForest)   # For Random Forest algorithm
library(e1071)          # For Support Vector Machines (SVM)
library(ROCR)           # For ROC curves and AUC calculation

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

### Model Training (Random Forest Example)

# Train a Random Forest model
set.seed(123)
rf_model <- randomForest(Purchase ~ ., data = train_data, ntree = 100, mtry = 2)

# Predict on test data
rf_predictions <- predict(rf_model, newdata = test_data)

### 1. Confusion Matrix and Performance Metrics using `caret`

# Create a confusion matrix using caret
rf_confusion <- confusionMatrix(rf_predictions, test_data$Purchase)
print("Confusion Matrix for Random Forest Model:")
print(rf_confusion)

# Extract performance metrics
accuracy <- rf_confusion$overall['Accuracy']
sensitivity <- rf_confusion$byClass['Sensitivity']
specificity <- rf_confusion$byClass['Specificity']
print(paste("Accuracy: ", round(accuracy, 3)))
print(paste("Sensitivity: ", round(sensitivity, 3)))
print(paste("Specificity: ", round(specificity, 3)))

### 2. ROC Curve and AUC using `ROCR`

# Predict probabilities for ROC curve
rf_prob_predictions <- predict(rf_model, newdata = test_data, type = "prob")[, 2]  # Probability of class "1"

# Create a prediction object for ROCR
pred <- prediction(rf_prob_predictions, test_data$Purchase)

# Performance metrics for ROC curve
perf <- performance(pred, "tpr", "fpr")

# Plot ROC curve
plot(perf, main = "ROC Curve for Random Forest Model", col = "blue", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "red")  # Diagonal line

# Calculate AUC
auc <- performance(pred, "auc")
auc_value <- as.numeric(auc@y.values)
print(paste("AUC: ", round(auc_value, 3)))

### 3. SVM Model Training and Evaluation (Support Vector Machine Example)

# Train an SVM model
set.seed(123)
svm_model <- svm(Purchase ~ ., data = train_data, kernel = "radial", probability = TRUE)

# Predict on test data using SVM model
svm_predictions <- predict(svm_model, newdata = test_data, probability = TRUE)

# Confusion matrix for SVM model
svm_confusion <- confusionMatrix(svm_predictions, test_data$Purchase)
print("Confusion Matrix for SVM Model:")
print(svm_confusion)

# Predict probabilities for ROC curve for SVM
svm_prob_predictions <- attr(svm_predictions, "probabilities")[, 2]

# Create a prediction object for ROCR for SVM
svm_pred <- prediction(svm_prob_predictions, test_data$Purchase)

# Performance metrics for ROC curve for SVM
svm_perf <- performance(svm_pred, "tpr", "fpr")

# Plot ROC curve for SVM
plot(svm_perf, main = "ROC Curve for SVM Model", col = "blue", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "red")  # Diagonal line

# Calculate AUC for SVM
svm_auc <- performance(svm_pred, "auc")
svm_auc_value <- as.numeric(svm_auc@y.values)
print(paste("AUC for SVM: ", round(svm_auc_value, 3)))
