# Install and load necessary packages
install.packages(c("DBI", "RMySQL", "RSQLite", "mongolite", "odbc"))
library(DBI)         # For database connectivity
library(RMySQL)      # For MySQL connectivity
library(RSQLite)     # For SQLite connectivity
library(mongolite)   # For MongoDB connectivity
library(odbc)        # For ODBC connections to various databases

#----------------------------------

### Connecting to a MySQL Database Using `RMySQL`

# MySQL database connection details
host <- "your_mysql_host"      # Replace with your MySQL host
port <- 3306                   # MySQL default port
dbname <- "your_database"      # Replace with your database name
user <- "your_username"        # Replace with your MySQL username
password <- "your_password"    # Replace with your MySQL password

# Establish a connection to the MySQL database
mysql_conn <- dbConnect(
  RMySQL::MySQL(),
  host = host,
  port = port,
  dbname = dbname,
  user = user,
  password = password
)

# List tables in the database
tables <- dbListTables(mysql_conn)
print("Tables in MySQL Database:")
print(tables)

# Execute a simple query
query_result <- dbGetQuery(mysql_conn, "SELECT * FROM your_table_name LIMIT 5;")  # Replace with your table name
print("Query Result:")
print(query_result)

# Close the MySQL connection
dbDisconnect(mysql_conn)
print("MySQL connection closed.")

#----------------------------------


### Connecting to an SQLite Database Using `RSQLite`

# Specify the path to the SQLite database file
sqlite_db_file <- "your_database.sqlite"  # Replace with your SQLite file path

# Establish a connection to the SQLite database
sqlite_conn <- dbConnect(RSQLite::SQLite(), sqlite_db_file)

# List tables in the SQLite database
tables <- dbListTables(sqlite_conn)
print("Tables in SQLite Database:")
print(tables)

# Execute a query to read data from a table
query_result <- dbGetQuery(sqlite_conn, "SELECT * FROM your_table_name LIMIT 5;")  # Replace with your table name
print("Query Result:")
print(query_result)

# Write a data frame to the SQLite database
df <- data.frame(id = 1:5, value = c("A", "B", "C", "D", "E"))
dbWriteTable(sqlite_conn, "new_table", df, overwrite = TRUE)
print("New table 'new_table' has been created in the SQLite database.")

# Close the SQLite connection
dbDisconnect(sqlite_conn)
print("SQLite connection closed.")

#----------------------------------
### Connecting to a MongoDB NoSQL Database Using `mongolite`

# MongoDB connection details
mongo_url <- "mongodb://your_mongodb_host:27017"  # Replace with your MongoDB host and port
database_name <- "your_database"                  # Replace with your database name
collection_name <- "your_collection"              # Replace with your collection name

# Establish a connection to the MongoDB database
mongo_conn <- mongo(collection = collection_name, db = database_name, url = mongo_url)

# List collections in the MongoDB database
collections <- mongo_conn$run('{"listCollections": 1}')
print("Collections in MongoDB Database:")
print(collections)

# Query data from the MongoDB collection
query_result <- mongo_conn$find('{}', limit = 5)  # Fetch first 5 records
print("Query Result from MongoDB:")
print(query_result)

# Insert a new document into the MongoDB collection
new_data <- data.frame(name = "John Doe", age = 30, occupation = "Data Scientist")
mongo_conn$insert(new_data)
print("New document inserted into MongoDB collection.")

# Close the MongoDB connection
mongo_conn$disconnect()
print("MongoDB connection closed.")

#----------------------------------
### Connecting to Databases Using ODBC

# Example: Connecting to an ODBC Data Source (replace DSN, username, and password with actual values)
odbc_conn <- dbConnect(odbc::odbc(), 
                       DSN = "your_dsn_name", 
                       UID = "your_username", 
                       PWD = "your_password")

# List tables in the ODBC-connected database
tables <- dbListTables(odbc_conn)
print("Tables in ODBC Database:")
print(tables)

# Execute a query to read data
query_result <- dbGetQuery(odbc_conn, "SELECT * FROM your_table_name LIMIT 5;")  # Replace with your table name
print("Query Result:")
print(query_result)

# Close the ODBC connection
dbDisconnect(odbc_conn)
print("ODBC connection closed.")

#----------------------------------