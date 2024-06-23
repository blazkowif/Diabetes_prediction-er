colnames(data) <- c(
  "Pregnant",
  "Glucose",
  "BloodP",
  "SkinT",
  "Insulin",
  "BMI",
  "DPF",
  "Age",
  "Result"
)

data[, 1:(ncol(data)-1)] <- lapply(data[, 1:(ncol(data)-1)], function(x) ifelse(is.na(x), 0, x))

# Replace 0 values with the calculated means
for (i in 1:(ncol(data)-1)) {
  data[[i]] <- ifelse(data[[i]] == 0, means[i], data[[i]])
}

# Load dplyr package
library(dplyr)

# Assuming your dataset is named 'data'
cleaned_data <- cleaned_data %>%
  mutate(across(-c(tail(names(data), 2)), ~ round(.x, 0)))

# Function to detect outliers using the IQR method
detect_outliers <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  outliers <- x < lower_bound | x > upper_bound
  return(outliers)
}

# Apply the outlier detection function to all columns except the last one
outliers <- sapply(data(ncol(data)), detect_outliers)

# Display the outliers for each column
outliers_list <- lapply(ncol(data),function(i) {
  col_name <- colnames(data)[i]
  outliers_in_col <- data[outliers[, i], i, drop = FALSE]
  outliers_in_col <- data[outliers[, i], , drop = FALSE]
  list(column = col_name, outliers = outliers_in_col)
})

# Display all results
outliers_list

#filter for outlier
rows_to_remove <- apply(outliers, 1, any)

# Remove the outliers
cleaned_data <- data[!rows_to_remove, ]

# Round the values in the 'Pregnancies' column to whole numbers
cleaned_data$Pregnant <- round(cleaned_data$Pregnant, 0)

# Display the first few rows to verify the changes
head(cleaned_data)

# Load the openxlsx library
library(openxlsx)

# Save the cleaned_data dataframe to an Excel file
write.xlsx(cleaned_data, file = "cleaned_data_V2.xlsx", rowNames = FALSE)

library(readxl)
library(ggplot2)
library(reshape2)
# Calculate the correlation matrix
cor_matrix <- cor(data, use = "complete.obs")

# Melt the correlation matrix into a long format
cor_melt <- melt(cor_matrix)

# Create the heatmap
ggplot(data = cor_melt, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 3) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), space = "Lab", name="Correlation") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1)) +
  coord_fixed() +
  labs(title = "Correlation Heatmap", x = "Features", y = "Features")

# Load necessary libraries
install.packages("caret")
install.packages("randomForest")
install.packages("e1071") # dependency for caret
library(randomForest)
library(caret)

# Convert the outcome variable to a factor
cleaned_data$Result <- as.factor(cleaned_data$Result)

# Define the control using a Random Forest
control <- rfeControl(functions = rfFuncs, method = "cv", number = 10)

# Perform RFE
set.seed(123)
results <- rfe(cleaned_data[, 1:(ncol(cleaned_data)-1)], cleaned_data$Result, sizes = c(1:(ncol(cleaned_data)-1)), rfeControl = control)

# Print the results
print(results)

# List the chosen features
chosen_features <- predictors(results)
print(chosen_features)

# Plot the results
plot(results, type = c("g", "o"))