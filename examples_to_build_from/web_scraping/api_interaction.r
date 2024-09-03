# Install and load necessary packages
install.packages(c("httr", "jsonlite"))
library(httr)      # For making HTTP requests
library(jsonlite)  # For parsing JSON data

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")


#---------------------------------------------------------

### API Interaction Example: Fetching Data from a Public API

# Define the API endpoint URL
api_url <- "https://api.coindesk.com/v1/bpi/currentprice.json"  # Example: Bitcoin price index API from CoinDesk

# Make a GET request to the API using `httr::GET()`
response <- GET(api_url)

# Check the status of the response
if (status_code(response) == 200) {  # 200 is the HTTP status code for "OK"
  print("API request successful.")
  
  # Extract the content of the response as text
  response_content <- content(response, "text", encoding = "UTF-8")
  
  # Parse the JSON response into a list or data frame using `jsonlite::fromJSON()`
  data <- fromJSON(response_content)
  
  # Print the parsed data
  print("Parsed JSON Data:")
  print(data)
  
  ### Extract specific information from the JSON data
  # Example: Extracting the current Bitcoin price in USD
  bitcoin_price_usd <- data$bpi$USD$rate
  print(paste("Current Bitcoin Price (USD):", bitcoin_price_usd))
  
} else {
  print(paste("Failed to fetch data. HTTP Status Code:", status_code(response)))
}

### Handling JSON Data

# Convert JSON data to a data frame for analysis (if applicable)
# Example: Extracting time and price for Bitcoin in USD
bitcoin_data <- data.frame(
  Time = data$time$updated,
  Price_USD = data$bpi$USD$rate_float
)

# Print the extracted data frame
print("Bitcoin Price Data:")
print(bitcoin_data)

# Visualize the data (if time-series data is available)
# This is just an example for potential visualization; adjust as needed
# plot(bitcoin_data$Time, bitcoin_data$Price_USD, type = "l", col = "blue", main = "Bitcoin Price in USD Over Time", xlab = "Time", ylab = "Price (USD)")
