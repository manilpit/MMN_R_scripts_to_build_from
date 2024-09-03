### Custom Utility Functions

# 1. Clean Column Names
clean_column_names <- function(df) {
  # Converts column names to lowercase and replaces spaces with underscores
  colnames(df) <- tolower(gsub(" ", "_", colnames(df)))
  return(df)
}

# Example usage
# df <- data.frame("Column 1" = c(1, 2, 3), "Column 2" = c(4, 5, 6))
# df <- clean_column_names(df)
# print(df)

# 2. Calculate Summary Statistics
calculate_summary <- function(df) {
  # Calculate summary statistics for numeric columns
  numeric_cols <- sapply(df, is.numeric)
  summary_stats <- data.frame()
  if (any(numeric_cols)) {
    summary_stats <- summary(df[, numeric_cols])
  } else {
    print("No numeric columns found.")
  }
  return(summary_stats)
}

# Example usage
# df <- data.frame(a = c(1, 2, 3, 4, 5), b = c(5, 4, 3, 2, 1))
# print(calculate_summary(df))

# 3. Save Plot to File
save_plot <- function(plot, filename, width = 6, height = 4, format = "png") {
  # Saves a ggplot object to a file
  ggsave(filename = paste0(filename, ".", format), plot = plot, width = width, height = height)
}

# Example usage
# library(ggplot2)
# p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
# save_plot(p, "scatter_plot", format = "png")

# 4. Move Files to Directory
move_files_to_directory <- function(files, destination_dir) {
  # Moves specified files to a target directory
  if (!dir.exists(destination_dir)) {
    dir.create(destination_dir)
  }
  sapply(files, function(file) {
    if (file.exists(file)) {
      file.rename(file, file.path(destination_dir, basename(file)))
      print(paste("Moved file:", file))
    } else {
      print(paste("File does not exist:", file))
    }
  })
}

# Example usage
# move_files_to_directory(c("file1.txt", "file2.txt"), "archive")

# 5. Batch Rename Files
batch_rename_files <- function(directory, pattern, replacement) {
  # Renames files in the specified directory using a pattern and replacement
  files <- list.files(directory, pattern = pattern, full.names = TRUE)
  sapply(files, function(file) {
    new_name <- gsub(pattern, replacement, basename(file))
    file.rename(file, file.path(directory, new_name))
    print(paste("Renamed file:", file, "to", new_name))
  })
}

# Example usage
# batch_rename_files("data", pattern = "old", replacement = "new")
