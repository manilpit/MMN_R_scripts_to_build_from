# Install the necessary packages if not already installed
install.packages("readxl")
install.packages("dplyr")

# Load the packages
library(readxl)
library(dplyr)

# Load the data from the Excel file
# Replace "your_file.xlsx" with your actual file path
data <- read_excel("your_file.xlsx", sheet = "Sheet1")  # Specify the sheet name if needed

# Create a summary table for all variables
summary_table <- summary(data)

# Print the summary table
print(summary_table)

# Install and load skimr package
install.packages("skimr")
library(skimr)

# Create a detailed summary table for all variables
summary_table <- skim(data)

# Print the summary table
print(summary_table)

# Save the summary table as a CSV file
write.csv(summary_table, "summary_table.csv")

# Install the necessary packages if not already installed
install.packages("readxl")
install.packages("dplyr")
install.packages("skimr")  # Optional for detailed summary

# Load the packages
library(readxl)
library(dplyr)
library(skimr)  # Optional for detailed summary

# Load the data from the Excel file
data <- read_excel("your_file.xlsx", sheet = "Sheet1")

# Create a summary table for all variables
# summary_table <- summary(data)  # Use this for a basic summary
summary_table <- skim(data)  # Use this for a detailed summary

# Print the summary table
print(summary_table)

# Optional: Save the summary table as a CSV file
write.csv(summary_table, "summary_table.csv")
