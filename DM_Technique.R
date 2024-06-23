# Install packages if they are not already installed
install.packages("caret")
install.packages("ggplot2")
library(randomForest)
library(caret)


cleaned_data$Result <- as.factor(cleaned_data$Result)

#splitting data for training and testing
set.seed(123)  # for reproducibility
train_indices <- createDataPartition(cleaned_data$Result, p = 0.8, list = FALSE)
train_data <- cleaned_data[train_indices, ]
test_data <- cleaned_data[-train_indices, ]

#parameter tuning for random forrest
param_grid <- expand.grid(
  mtry = c(2, 4, 6)  # adjust these values based on the number of predictors
)


#training and tunign random forest
# Define the control function for caret
control <- trainControl(method = "cv", number = 5)

# Train Random Forest model with parameter tuning
rf_model <- train(
  Result ~ .,
  data = train_data,
  method = "rf",
  trControl = control,
  tuneGrid = param_grid
)
#Logistic regression
glm_model <- glm(Result ~ ., data = train_data, family = binomial)


# Print the best model parameters
print(rf_model$bestTune)

# Print the tuned Random Forest model
print(rf_model$finalModel)

#result
# Predict using the tuned Random Forest model
rf_pred <- predict(rf_model, newdata = test_data)

# Evaluate accuracy
rf_accuracy <- mean(rf_pred == test_data$Result)
print(paste("Random Forest Accuracy:", rf_accuracy))
# Predict using the Logistic Regression model
glm_probs <- predict(glm_model, newdata = test_data, type = "response")
glm_pred <- ifelse(glm_probs > 0.5, 1, 0)  # threshold at 0.5

# Calculate accuracy
glm_accuracy <- mean(glm_pred == test_data$Result)

#summary
# Print summary results
cat("\nTuned Random Forest Model Summary:\n")
print(rf_model$finalModel)

cat("\nModel Evaluation on Test Data:\n")
cat(paste("Random Forest Accuracy:", rf_accuracy, "\n"))



#Plotting the accuracy in png------------------------------
install.packages("ggplot2")  # for plotting
# Predict using the tuned Random Forest model
rf_pred <- predict(rf_model, newdata = test_data)

# Evaluate accuracy
rf_accuracy <- mean(rf_pred == test_data$Result)
library(ggplot2)

# Create a data frame for plotting
accuracy_data <- data.frame(Model = "Random Forest",
                            Accuracy = rf_accuracy)

# Plot accuracy
accuracy_plot <- ggplot(accuracy_data, aes(x = Model, y = Accuracy)) +
  geom_bar(stat = "identity", fill = "blue") +
  ylim(0, 1) +
  labs(title = "Model Accuracy", y = "Accuracy", x = "Model") +
  geom_text(aes(label = paste0(round(Accuracy * 100, 2), "%")), vjust = -0.3, size = 4) +
  theme_minimal()

# Save plot as PNG
png(file = "model_accuracy.png", width = 800, height = 600)
print(accuracy_plot)
dev.off()

# Create a data frame for plotting
accuracy_data <- data.frame(Model = "Logistic Regression",
                            Accuracy = glm_accuracy)

# Plot accuracy
accuracy_plot <- ggplot(accuracy_data, aes(x = Model, y = Accuracy)) +
  geom_bar(stat = "identity", fill = "green") +
  ylim(0, 1) +
  labs(title = "Model Accuracy", y = "Accuracy", x = "Model") +
  geom_text(aes(label = paste0(round(Accuracy * 100, 2), "%")), vjust = -0.3, size = 4) +
  theme_minimal()

# Save plot as PNG
png(file = "logistic_regression_accuracy.png", width = 800, height = 600)
print(accuracy_plot)
dev.off()
