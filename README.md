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
`R
install.packages(c("dplyr", "ggplot2", "reshape2", "caret", "randomForest", "openxlsx", "readxl", "e1071"))
3.Use the [raw_data.xlsx] to run the data preprocessing R source code.
4.Use the [cleaned_data.xlsx] to run the data mining technique R source code.`


**## Results**
`
1.raw_data: is the actual data gathered from kaggle website, https://www.kaggle.com/datasets/iammustafatz/diabetes-prediction-dataset
2.cleaned_data: byproduct of raw data that has undergone cleaning process, handling missing value with mean, 
3.correlation.png: Heatmap showing the correlation between variables.
4.feature_selection.png: Visualization of feature selection results.
5.RFE Results: Printout of Recursive Feature Elimination (RFE) results, including selected.`


##features and performance metrics.
`
1.random_forest_accuracy
2.logistic_regression_accuracy`

**Contributors**
List contributors or authors involved in the project.

**License**
This project is based on a dataset sourced from Kaggle. Please refer to the licensing terms on the Kaggle competition page or dataset source for more information.https://www.kaggle.com/terms
