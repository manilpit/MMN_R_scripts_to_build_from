# Load necessary libraries
install.packages(c("readxl", "writexl", "jsonlite", "DBI", "RSQLite"))
library(readxl)    # For reading Excel files
library(writexl)   # For writing Excel files
library(jsonlite)  # For handling JSON data
library(DBI)       # For database connectivity
library(RSQLite)   # For SQLite database connectivity

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

# 1. CSV: Read and Write
# Read CSV file
data_csv <- read.csv("input_data.csv")
print("Data from CSV:")
print(head(data_csv))

# Write CSV file
write.csv(data_csv, "output_data.csv", row.names = FALSE)

# 2. Excel: Read and Write
# Read Excel file (first sheet by default)
data_excel <- read_excel("input_data.xlsx")
print("Data from Excel:")
print(head(data_excel))

# Write Excel file
write_xlsx(data_excel, "output_data.xlsx")

# 3. JSON: Read and Write
# Read JSON file
data_json <- fromJSON("input_data.json")
print("Data from JSON:")
print(head(data_json))

# Write JSON file
write_json(data_json, "output_data.json", pretty = TRUE)

# 4. Database: Read and Write (using SQLite as an example)
# Create an SQLite database connection
con <- dbConnect(RSQLite::SQLite(), dbname = "example_database.sqlite")

# Write data to a table in the database
dbWriteTable(con, "data_table", data_csv, overwrite = TRUE)

# Read data from the database table
data_db <- dbReadTable(con, "data_table")
print("Data from Database:")
print(head(data_db))

# Close the database connection
dbDisconnect(con)
