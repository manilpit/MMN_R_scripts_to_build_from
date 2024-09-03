NOTE! This Readme file has been automatically genrated.

### README for Survey Analysis Using Random Forest

#### Description
This script performs an analysis of survey data focused on "overordnet tilfredshet" (overall satisfaction). It includes data loading, preprocessing, and running a Random Forest model to identify the importance of different survey questions in determining overall satisfaction.

#### Features
- **Modular design**: Each step of the process is encapsulated in functions for easy maintenance and reusability.
- **Error handling**: The script includes checks to ensure that files exist and required columns are present in the data.
- **Automatic library loading and installation**: Ensures all required libraries are installed and loaded.

#### Requirements
- R programming environment
- R packages: `dplyr`, `randomForest`, `readxl`
  - These packages are automatically installed by the script if not present.

#### File Structure
```
/path/to/your/project_folder
│
├── survey_analysis_script.R  # Main R script for analysis
└── dataset.xlsx              # Dataset file in Excel format
```

#### Setup Instructions
1. **Install R**: Ensure that R is installed on your system. If not, download and install it from [CRAN](https://cran.r-project.org/mirrors.html).
2. **Download the script**: Place the `survey_analysis_script.R` in your working directory.
3. **Prepare your dataset**: Ensure your data is in an Excel format and includes the necessary columns for satisfaction measures. Place it in the same directory as the script or specify the path in the script.

#### Usage
1. **Open the script**: Open `survey_analysis_script.R` in your R environment (such as RStudio).
2. **Modify the dataset path**: Change the `filepath` in the `run_analysis` function call to the path of your dataset file.
3. **Run the script**: Execute the script in your R environment. The output will include the importance of each survey question and a plot indicating these importances.

#### Functions Overview
- `load_required_libraries()`: Checks for and installs required libraries.
- `load_dataset(filepath)`: Loads the dataset from the specified filepath.
- `check_required_columns(data, columns)`: Ensures all specified columns are present in the dataset.
- `recode_satisfaction(data, satisfaction_columns)`: Recodes satisfaction measures into categorical levels.
- `impute_missing_data(data)`: Imputes missing data in numeric columns using the median.
- `build_and_evaluate_rf(data, target_variable)`: Builds a Random Forest model and prints/plots the variable importance.
- `run_analysis(filepath)`: Orchestrates the full analysis using above functions.

#### Troubleshooting
- **Missing files**: Ensure the dataset file exists in the specified location.
- **Missing columns**: Check your dataset to ensure it contains all required columns, as specified in the `satisfaction_columns` array.

#### Support
For support, please ensure you have followed the setup instructions correctly. If you encounter specific issues related to the R environment or packages, consider searching for or posting your issue on platforms like Stack Overflow.

---
