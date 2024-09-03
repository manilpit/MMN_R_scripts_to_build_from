# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### Batch Processing Using `source()` (Sequential Execution)

# List of R scripts to run in sequence
scripts_to_run <- c("script1.R", "script2.R", "script3.R")

# Run each script in sequence using source()
for (script in scripts_to_run) {
  print(paste("Running:", script))
  source(script)
  print(paste("Completed:", script))
}

print("All scripts have been executed sequentially.")
#--------------------------------------------------------------------------------
#v2 using paralell::mclappy()
# Load necessary library
install.packages("parallel")
library(parallel)

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### Batch Processing Using `parallel::mclapply()` (Parallel Execution)

# List of R scripts to run in parallel
scripts_to_run <- c("script1.R", "script2.R", "script3.R")

# Define a function to run each script using `source()`
run_script <- function(script) {
  print(paste("Running:", script))
  source(script)
  print(paste("Completed:", script))
}

# Run scripts in parallel using `mclapply()`
num_cores <- detectCores() - 1  # Use all available cores minus one
mclapply(scripts_to_run, run_script, mc.cores = num_cores)

print("All scripts have been executed in parallel.")
