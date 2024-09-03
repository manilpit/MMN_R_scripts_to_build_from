# data_import_summary.R

# Load necessary library
library(readr)

# Import data from a CSV file
data <- read_csv("path/to/your/data.csv")

# Display the first few rows of the dataset
head(data)

# Display a summary of the dataset
summary(data)

# Display the structure of the dataset
str(data)
