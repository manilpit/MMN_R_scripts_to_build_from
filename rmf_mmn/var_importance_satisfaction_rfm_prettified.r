# Function to load necessary libraries
#load_required_libraries <- function() {
#  libraries <- c("dplyr", "randomForest", "readxl")
#  for (lib in libraries) {
#    if (!require(lib, character.only = TRUE)) {
#      install.packages(lib)
#      library(lib, character.only = TRUE)
#    }
#  }
#}

# Function to load the dataset
load_dataset <- function(filepath) {
  if (!file.exists(filepath)) {
    stop("Dataset file does not exist: ", filepath)
  }
  return(read_excel(filepath))
}

# Function to check for the existence of required columns
check_required_columns <- function(data, columns) {
  missing_columns <- setdiff(columns, names(data))
  if (length(missing_columns) > 0) {
    stop("Missing columns: ", paste(missing_columns, collapse=", "))
  }
}

# Function to recode satisfaction levels
recode_satisfaction <- function(data, satisfaction_columns) {
  data %>%
    mutate(across(all_of(satisfaction_columns), ~ case_when(
      . %in% c(1, 2) ~ 1,  # Negative
      . == 3 ~ 2,          # Neutral
      . %in% c(4, 5) ~ 3   # Positive
    )))
}

# Function to impute missing data
impute_missing_data <- function(data) {
  data[sapply(data, is.numeric)] <- lapply(data[sapply(data, is.numeric)], function(x) {
    x[is.na(x)] <- median(x, na.rm = TRUE)
    return(x)
  })
  return(data)
}

# Function to build and evaluate the Random Forest model
build_and_evaluate_rf <- function(data, target_variable) {
  if (!target_variable %in% names(data)) {
    stop("Target variable does not exist in the dataset.")
  }
  predictors <- setdiff(names(data), target_variable)
  model <- randomForest(as.factor(data[[target_variable]]) ~ ., data = data[, predictors], importance = TRUE)
  
  # Print importance values and plot them
  importance_values <- importance(model)
  print(importance_values)
  varImpPlot(model)
}

# Main function to run analysis
run_analysis <- function(filepath) {
  load_required_libraries()
  satisfaction_columns <- c('medvirk_innspill_18', 'medvirk_oppfolg_18', 'medvirk_tillitsv_18', 
                            'miljo_fag_18', 'miljo_sosial_18', 'miljo_studlaer_18', 'overord_altialt_18', 
                            'praksis_forb_18', 'praksis_komm_18', 'praksis_laeroppf_18', 'praksis_relevans_18', 
                            'praksis_teori_18', 'praksis_undervis_18', 'praksis_utford_18', 'praksis_veiloppf_18')
  
  masterfile <- load_dataset(filepath)
  check_required_columns(masterfile, satisfaction_columns)
  masterfile <- recode_satisfaction(masterfile, satisfaction_columns)
  masterfile <- impute_missing_data(masterfile)
  build_and_evaluate_rf(masterfile, 'overord_altialt_18')
}

# Call the main function with a generic filepath
run_analysis("path/to/your/dataset.xlsx")
