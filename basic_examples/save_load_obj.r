# save_load_objects.R

# Sample data frame
data <- data.frame(
  id = 1:10,
  value = rnorm(10)
)

# Save the data frame to an RData file
save(data, file = "data.RData")

# Load the data frame from the RData file
load("data.RData")

# Display the loaded data
print(data)
