# Install and load necessary packages
install.packages("log4r")
library(log4r)  # For logging

# Set the working directory (adjust the path as needed)
setwd("your/working/directory/path")
#---------------------------------------
### Logging Setup Using `log4r`

# Create a logger object
logger <- create.logger()

# Set the log file path and log level
logfile <- "script_log.log"  # Specify the log file name
logfile_path <- file.path(getwd(), logfile)
log_appender(logger) <- file_appender(logfile_path)  # Output to a log file
log_level(logger) <- "INFO"  # Set log level to INFO (can be DEBUG, INFO, WARN, ERROR)

# Log a message indicating the start of the script
info(logger, "Script started.")
#---------------------------------------
### 1. Example Function with Logging and Error Handling

safe_divide <- function(x, y) {
  # A function to safely divide two numbers with error handling
  tryCatch({
    result <- x / y
    info(logger, paste("Successfully divided", x, "by", y, "Result:", result))
    return(result)
  }, warning = function(w) {
    warn(logger, paste("Warning in dividing", x, "by", y, "-", conditionMessage(w)))
  }, error = function(e) {
    error(logger, paste("Error in dividing", x, "by", y, "-", conditionMessage(e)))
  }, finally = {
    info(logger, "Division operation completed.")
  })
}

# Example usage
safe_divide(10, 2)  # Successful division
safe_divide(10, 0)  # Division by zero (error)

### 2. Example of Logging Script Progress

# Function to simulate a task with logging
process_data <- function(data) {
  info(logger, "Data processing started.")
  
  # Try to summarize the data
  tryCatch({
    summary_stats <- summary(data)
    info(logger, "Data summary completed.")
    return(summary_stats)
  }, error = function(e) {
    error(logger, paste("Error in data processing:", conditionMessage(e)))
  }, finally = {
    info(logger, "Data processing task completed.")
  })
}

# Example usage
# Simulate some data
data <- data.frame(a = rnorm(10), b = rnorm(10))
print(process_data(data))  # Should work fine

# Simulate an error by passing NULL
print(process_data(NULL))  # Should log an error
