# Load necessary libraries
install.packages(c("zoo", "forecast"))
library(zoo)       # For advanced time series handling
library(forecast)  # For time series forecasting and decomposition

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### 1. Creating Time Series Objects

# Generate sample time series data
set.seed(123)  # For reproducibility
time_series_data <- rnorm(120, mean = 100, sd = 10)  # 120 monthly observations

# Create a time series object using `ts()` - monthly data over 10 years
ts_data <- ts(time_series_data, start = c(2010, 1), frequency = 12)  # Start in January 2010

# Print the time series object
print("Time Series Object (using ts()):")
print(ts_data)

# Plot the time series data
plot(ts_data, main = "Time Series Data (using ts())", xlab = "Year", ylab = "Value", col = "blue", lwd = 2)

# Create a time series object using `zoo::zoo()`
zoo_data <- zoo(time_series_data, order.by = as.Date(seq(from = as.Date("2010-01-01"), by = "month", length.out = 120)))

# Print the `zoo` time series object
print("Time Series Object (using zoo::zoo()):")
print(zoo_data)

# Plot the `zoo` time series data
plot(zoo_data, main = "Time Series Data (using zoo::zoo())", xlab = "Year", ylab = "Value", col = "red", lwd = 2)

### 2. Time Series Decomposition and Seasonal Adjustment

# Add seasonality and trend to the data
trend <- 0.1 * (1:120)  # Simple linear trend
seasonality <- 10 * sin(2 * pi * (1:120) / 12)  # Seasonal component

# Generate time series with trend and seasonality
ts_data_with_trend_season <- ts_data + trend + seasonality

# Plot the original time series with trend and seasonality
plot(ts_data_with_trend_season, main = "Time Series with Trend and Seasonality", xlab = "Year", ylab = "Value", col = "blue", lwd = 2)

# a) Decomposition using `forecast::decompose()`
decomposed_data <- decompose(ts_data_with_trend_season, type = "multiplicative")  # Multiplicative decomposition

# Plot decomposed components
print("Decomposed Time Series using forecast::decompose():")
plot(decomposed_data)

# b) Seasonal and Trend Decomposition using Loess (`stats::stl()`)
stl_decomposition <- stl(ts_data_with_trend_season, s.window = "periodic")

# Plot STL decomposition components
print("STL Decomposition using stats::stl():")
plot(stl_decomposition)

# Extract and plot the seasonally adjusted series from STL decomposition
seasonally_adjusted <- seasadj(stl_decomposition)

plot(seasonally_adjusted, main = "Seasonally Adjusted Time Series (using stats::stl())", xlab = "Year", ylab = "Value", col = "green", lwd = 2)

### Conclusion
print("Time series objects, decomposition, and seasonal adjustment complete.")
