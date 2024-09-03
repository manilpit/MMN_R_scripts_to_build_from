# Load necessary libraries
install.packages(c("forecast", "zoo"))
library(forecast)  # For ARIMA and ETS forecasting models
library(zoo)       # For advanced time series handling

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### 1. Generate Sample Time Series Data

# Generate sample time series data
set.seed(123)  # For reproducibility
time_series_data <- rnorm(120, mean = 100, sd = 10)  # 120 monthly observations

# Create a time series object using `ts()` - monthly data over 10 years
ts_data <- ts(time_series_data, start = c(2010, 1), frequency = 12)  # Start in January 2010

# Plot the original time series
plot(ts_data, main = "Original Time Series Data", xlab = "Year", ylab = "Value", col = "blue", lwd = 2)

### 2. Time Series Forecasting Using ARIMA Models

# a) Using `forecast::auto.arima()`
arima_model_auto <- auto.arima(ts_data)
print("ARIMA Model Summary (using auto.arima()):")
print(summary(arima_model_auto))

# Forecast for the next 12 months using the ARIMA model
arima_forecast_auto <- forecast(arima_model_auto, h = 12)

# Plot the ARIMA forecast
plot(arima_forecast_auto, main = "ARIMA Forecast (using auto.arima())", xlab = "Year", ylab = "Value", col = "blue")

# b) Using `stats::arima()`
# Fit an ARIMA model with manually specified orders (e.g., ARIMA(1,1,1))
arima_model_manual <- arima(ts_data, order = c(1, 1, 1))
print("ARIMA Model Summary (using stats::arima()):")
print(summary(arima_model_manual))

# Forecast for the next 12 months using the manually fitted ARIMA model
arima_forecast_manual <- forecast(arima_model_manual, h = 12)

# Plot the ARIMA forecast (manually fitted)
plot(arima_forecast_manual, main = "ARIMA Forecast (using stats::arima())", xlab = "Year", ylab = "Value", col = "red")

### 3. Time Series Forecasting Using Exponential Smoothing

# Using `forecast::ets()` for Exponential Smoothing
ets_model <- ets(ts_data)
print("ETS Model Summary (using forecast::ets()):")
print(summary(ets_model))

# Forecast for the next 12 months using the ETS model
ets_forecast <- forecast(ets_model, h = 12)

# Plot the ETS forecast
plot(ets_forecast, main = "Exponential Smoothing Forecast (using forecast::ets())", xlab = "Year", ylab = "Value", col = "green")

### Conclusion

print("Time series forecasting using ARIMA and Exponential Smoothing complete.")
