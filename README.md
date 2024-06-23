# Diabetes Prediction Project

## Overview
This project aims to predict the likelihood of diabetes using machine learning techniques in R. It includes data preprocessing, exploratory data analysis (EDA), feature selection, model training, and evaluation.

## Files and Directories
- **data_preprocessing_and_modeling/**: Directory containing R scripts and output files related to data preprocessing and modeling.

## Contents
- **data_preprocessing.R**: R script for preprocessing the dataset, handling missing values and outliers.
- **modeling.R**: R script for building and evaluating predictive models using Random Forest and feature selection techniques.
- **correlation.png**: Visualization showing correlation between variables.
- **feature_selection.png**: Visualization depicting feature selection results.
- **cleaned_data_V2.xlsx**: Excel file containing cleaned data after preprocessing.

## Dependencies
Ensure the following R packages are installed:
- `base`
- `dplyr`
- `ggplot2`
- `reshape2`
- `caret`
- `randomForest`
- `openxlsx`
- `readxl`
- `e1071`

You can install packages using `install.packages("package_name")` in R.

## Setup
1. **Clone the repository:**

2. **Install required packages:**
```R
install.packages(c("dplyr", "ggplot2", "reshape2", "caret", "randomForest", "openxlsx", "readxl", "e1071"))


Results
correlation.png: Heatmap showing the correlation between variables.
feature_selection.png: Visualization of feature selection results.
RFE Results: Printout of Recursive Feature Elimination (RFE) results, including selected features and performance metrics.
**Contributors**
List contributors or authors involved in the project.
License
This project is based on a dataset sourced from Kaggle. Please refer to the licensing terms on the Kaggle competition page or dataset source for more information.
