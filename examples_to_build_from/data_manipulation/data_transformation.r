# Load necessary libraries
install.packages(c("dplyr", "tidyr"))
library(dplyr)  # For data manipulation
library(tidyr)  # For data reshaping

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Sample data creation
data <- data.frame(
  ID = 1:6,
  Category = c("A", "B", "A", "B", "A", "B"),
  Value1 = c(10, 15, 10, 15, 20, 25),
  Value2 = c(5, 10, 15, 10, 5, 15)
)

print("Original Data:")
print(data)

### 1. Reshaping Data

# a) Using pivot_longer to convert wide format to long format
data_long <- data %>%
  pivot_longer(cols = c(Value1, Value2), names_to = "Variable", values_to = "Value")

print("Data after pivot_longer (Wide to Long):")
print(data_long)

# b) Using pivot_wider to convert long format back to wide format
data_wide <- data_long %>%
  pivot_wider(names_from = Variable, values_from = Value)

print("Data after pivot_wider (Long to Wide):")
print(data_wide)

### 2. Summarizing Data

# Summarize data by Category
summary_data <- data %>%
  group_by(Category) %>%
  summarize(
    Mean_Value1 = mean(Value1, na.rm = TRUE),
    Sum_Value2 = sum(Value2, na.rm = TRUE)
  )

print("Summarized Data by Category:")
print(summary_data)

### 3. Joining Datasets

# Sample data creation for joining
data_left <- data.frame(
  ID = 1:4,
  Name = c("John", "Paul", "George", "Ringo")
)

data_right <- data.frame(
  ID = 3:6,
  Score = c(85, 90, 75, 80)
)

print("Left Dataset:")
print(data_left)

print("Right Dataset:")
print(data_right)

# a) Left Join
data_left_join <- left_join(data_left, data_right, by = "ID")
print("Data after left_join:")
print(data_left_join)

# b) Inner Join
data_inner_join <- inner_join(data_left, data_right, by = "ID")
print("Data after inner_join:")
print(data_inner_join)

# c) Full Join
data_full_join <- full_join(data_left, data_right, by = "ID")
print("Data after full_join:")
print(data_full_join)

# d) Anti Join
data_anti_join <- anti_join(data_left, data_right, by = "ID")
print("Data after anti_join:")
print(data_anti_join)
