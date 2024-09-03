# Load necessary libraries
#library(dplyr)
#library(randomForest)
#library(readxl)

# Define the dataset path
#While working on this script i used the masterfile in R:\Studiebarometeret\Fagskoleundersøkelsen\Datasett\2024
dataset_path <- "Path/to/file"

# Load the dataset
masterfile <- read_excel(dataset_path)

# Identify columns related to "overordnet tilfredshet"
satisfaction_columns <- c(
  'medvirk_innspill_18', 'medvirk_oppfolg_18', 'medvirk_tillitsv_18',
  'miljo_fag_18', 'miljo_sosial_18', 'miljo_studlaer_18', 'overord_altialt_18',
  'praksis_forb_18', 'praksis_komm_18', 'praksis_laeroppf_18', 'praksis_relevans_18',
  'praksis_teori_18', 'praksis_undervis_18', 'praksis_utford_18', 'praksis_veiloppf_18'
)

# Recode the ordinal variables
masterfile <- masterfile %>%
  mutate(across(all_of(satisfaction_columns), ~ case_when(
    . %in% c(1, 2) ~ 1,  # Negative
    . == 3 ~ 2,          # Neutral
    . %in% c(4, 5) ~ 3   # Positive
  )))

# Define dependent and independent variables
target_variable <- 'overord_altialt_18'
predictors <- setdiff(names(masterfile), target_variable)

# Impute missing data in numeric columns
masterfile[sapply(masterfile, is.numeric)] <- lapply(masterfile[sapply(masterfile, is.numeric)], function(x) {
  if (any(is.na(x))) median(x, na.rm = TRUE) else x
})

# Build the Random Forest Model
model <- randomForest(as.factor(masterfile[[target_variable]]) ~ ., data = masterfile[, predictors], importance = TRUE)

# View and print the importance of each variable
importance_values <- importance(model)
print(importance_values)

# Visualize the importance with a plot
varImpPlot(model)
