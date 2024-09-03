# Sample Data Frame
data <- data.frame(
  ID = 1:4,
  Name = c("Jørgen", "Ægir", "Åse", "Björn"),
  City = c("Århus", "Ørebro", "Malmø", "København"),
  stringsAsFactors = FALSE
)

# Function to Replace Æ, Ø, Å with AE, O, A
replace_danish_characters <- function(df) {
  df[] <- lapply(df, function(x) {
    if(is.character(x)) {
      x <- gsub("Æ", "AE", x)
      x <- gsub("æ", "ae", x)
      x <- gsub("Ø", "O", x)
      x <- gsub("ø", "o", x)
      x <- gsub("Å", "A", x)
      x <- gsub("å", "a", x)
    }
    return(x)
  })
  return(df)
}

# Apply the function to your dataset
cleaned_data <- replace_danish_characters(data)

# View the cleaned data
print(cleaned_data)
