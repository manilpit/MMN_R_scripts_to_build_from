# Set the working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Display the current working directory
print(paste("Current Working Directory:", getwd()))

### File Management Operations

### 1. List Files in a Directory

# List all files in the current directory
all_files <- list.files()
print("All Files in the Current Directory:")
print(all_files)

# List only CSV files in the current directory
csv_files <- list.files(pattern = "*.csv")
print("CSV Files in the Current Directory:")
print(csv_files)

### 2. Rename Files in a Directory

# Example: Renaming a file from "old_name.csv" to "new_name.csv"
old_name <- "old_name.csv"  # Replace with the actual file name
new_name <- "new_name.csv"  # Replace with the desired new file name

if (file.exists(old_name)) {
  file.rename(from = old_name, to = new_name)
  print(paste("File renamed from", old_name, "to", new_name))
} else {
  print(paste("File", old_name, "does not exist."))
}

### 3. Move Files to a Different Directory

# Example: Moving a file from the current directory to a subdirectory called "archive"
file_to_move <- "file_to_move.csv"  # Replace with the actual file name
destination_dir <- "archive"  # Replace with the destination directory

# Create the destination directory if it doesn't exist
if (!dir.exists(destination_dir)) {
  dir.create(destination_dir)
  print(paste("Created directory:", destination_dir))
}

# Move the file to the destination directory
if (file.exists(file_to_move)) {
  file.rename(from = file_to_move, to = file.path(destination_dir, file_to_move))
  print(paste("File moved to:", file.path(destination_dir, file_to_move)))
} else {
  print(paste("File", file_to_move, "does not exist."))
}

### 4. Delete Files

# Example: Deleting a file named "file_to_delete.csv"
file_to_delete <- "file_to_delete.csv"  # Replace with the actual file name

if (file.exists(file_to_delete)) {
  file.remove(file_to_delete)
  print(paste("File", file_to_delete, "has been deleted."))
} else {
  print(paste("File", file_to_delete, "does not exist."))
}

### 5. Create, Remove, and List Directories

# Create a new directory named "new_directory"
new_directory <- "new_directory"
if (!dir.exists(new_directory)) {
  dir.create(new_directory)
  print(paste("Directory created:", new_directory))
} else {
  print(paste("Directory", new_directory, "already exists."))
}

# Remove an existing directory named "old_directory"
old_directory <- "old_directory"
if (dir.exists(old_directory)) {
  unlink(old_directory, recursive = TRUE)
  print(paste("Directory removed:", old_directory))
} else {
  print(paste("Directory", old_directory, "does not exist."))
}

# List all directories in the current working directory
directories <- list.dirs(recursive = FALSE)
print("Directories in the Current Working Directory:")
print(directories)
