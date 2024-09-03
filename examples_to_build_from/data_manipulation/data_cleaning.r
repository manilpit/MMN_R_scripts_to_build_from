# Load necessary libraries
install.packages(c("readxl", "writexl", "jsonlite", "DBI", "RSQLite", "dplyr", "tidyr", "stringr"))
library(readxl)    # For reading Excel files
library(writexl)   # For writing Excel files
library(jsonlite)  # For handling JSON data
library(DBI)       # For database connectivity
library(RSQLite)   # For SQLite database connectivity
library(dplyr)     # For data manipulation
library(tidyr)     # For data tidying
library(stringr)   # For string manipulation

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Function to clean data: Remove missing values, handle duplicates, and clean column names
clean_data <- function(data) {
  # Remove duplicate rows
  data <- distinct(data)
  
  # Remove rows with all NA values
  data <- data[!apply(is.na(data), 1, all), ]
  
  # Fill missing values with mean for numeric columns and mode for categorical columns
  data <- data %>%
    mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
    mutate(across(where(is.character), ~ ifelse(is.na(.), Mode(.), .)))
  
  # Clean column names
  data <- data %>%
    rename_with(~str_replace_all(., "[^[:alnum:]_]", "_"))
  
  return(data)
}

# Helper function to calculate mode for categorical data
Mode <- function(x) {
  ux <- na.omit(unique(x))
  ux[which.max(tabulate(match(x, ux)))]
}

# 1. CSV: Read, Clean, and Write
# Read CSV file
data_csv <- read.csv("input_data.csv")
print("Original Data from CSV:")
print(head(data_csv))

# Clean CSV data
data_csv_cleaned <- clean_data(data_csv)
print("Cleaned Data from CSV:")
print(head(data_csv_cleaned))

# Write cleaned CSV file
write.csv(data_csv_cleaned, "output_data_cleaned.csv", row.names = FALSE)

# 2. Excel: Read, Clean, and Write
# Read Excel file (first sheet by default)
data_excel <- read_excel("input_data.xlsx")
print("Original Data from Excel:")
print(head(data_excel))

# Clean Excel data
data_excel_cleaned <- clean_data(data_excel)
print("Cleaned Data from Excel:")
print(head(data_excel_cleaned))

# Write cleaned Excel file
write_xlsx(data_excel_cleaned, "output_data_cleaned.xlsx")

# 3. JSON: Read, Clean, and Write
# Read JSON file
data_json <- fromJSON("input_data.json")
print("Original Data from JSON:")
print(head(data_json))

# Clean JSON data
data_json_cleaned <- clean_data(data_json)
print("Cleaned Data from JSON:")
print(head(data_json_cleaned))

# Write cleaned JSON file
write_json(data_json_cleaned, "output_data_cleaned.json", pretty = TRUE)

# 4. Database: Read, Clean, and Write (using SQLite as an example)
# Create an SQLite database connection
con <- dbConnect(RSQLite::SQLite(), dbname = "example_database.sqlite")

# Write data to a table in the database
dbWriteTable(con, "data_table", data_csv, overwrite = TRUE)

# Read data from the database table
data_db <- dbReadTable(con, "data_table")
print("Original Data from Database:")
print(head(data_db))

# Clean database data
data_db_cleaned <- clean_data(data_db)
print("Cleaned Data from Database:")
print(head(data_db_cleaned))

# Write cleaned data back to the database
dbWriteTable(con, "data_table_cleaned", data_db_cleaned, overwrite = TRUE)

# Close the database connection
dbDisconnect(con)
