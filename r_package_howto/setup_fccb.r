# Function to check if a package is installed, and install it if it's not
check_and_install <- function(package) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }
}

# Check and install 'devtools' and 'roxygen2'
check_and_install("devtools")
check_and_install("roxygen2")
