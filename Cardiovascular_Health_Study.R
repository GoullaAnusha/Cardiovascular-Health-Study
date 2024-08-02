library(ggplot2)
# Read the dataset into a data frame
data <- read.csv("C:\\Users\\gowni\\Downloads\\cleaned_cardio_train (3).csv")
data
# Display basic information about the dataset
str(data)

# View the first few rows of the dataset
head(data)

# Summary statistics of the dataset
summary(data)


#################### Cardiovascular disease by age group and gender
cardio_data <- data[data$cardio == 1, ]

# Create age groups with a 5-year gap
cardio_data$age_group <- cut(cardio_data$age, breaks = seq(40, 65, by = 5), labels = FALSE)

# Convert gender to factor with labels
cardio_data$gender <- factor(cardio_data$gender, labels = c("Female", "Male"))

# Create a grouped bar chart
ggplot(cardio_data, aes(x = as.factor(age_group), fill = gender)) +
  geom_bar(position = "dodge") +
  labs(title = "Cardiovascular Disease by Age Group and Gender",
       x = "Age Group", y = "Frequency") +
  scale_fill_manual(values = c("Female" = "pink", "Male" = "lightblue")) +
  theme_minimal() +
  scale_x_discrete(labels = function(x) seq(40,65,by=5))


######################### Systolic Blood Pressure for Cardiovascular disease
# Subset the data where cardio = 1
data_cardio_1 <- data[data$cardio == 1, ]

# Box plot for ap_hi with cardio = 1
ggplot(data_cardio_1, aes(x = "Cardiovascular Disease", y = ap_hi)) +
  geom_boxplot() +
  labs(title = "Box Plot of Systolic Blood Pressure for Cardiovascular Disease (cardio = 1)",
       x = "",
       y = "Systolic Blood Pressure(ap_hi)")


##################### Removing outliers
# Subset the data where cardio = 1
data_cardio_1 <- data[data$cardio == 1, ]

# Calculate the lower and upper bounds for ap_hi
q1 <- quantile(data_cardio_1$ap_hi, 0.01) # 1st percentile
q99 <- quantile(data_cardio_1$ap_hi, 0.99) # 99th percentile

# Filter the data to remove outliers
data_filtered <- data_cardio_1[data_cardio_1$ap_hi >= q1 & data_cardio_1$ap_hi <= q99, ]

# Box plot for ap_hi with cardio = 1, removing outliers
ggplot(data_filtered, aes(x = "Cardiovascular Disease", y = ap_hi)) +
  geom_boxplot() +
  labs(title = "Box Plot of Systolic Blood Pressure for Cardiovascular Disease (cardio = 1) without Outliers",
       x = "",
       y = "Systolic Blood Pressure (ap_hi)")


###################### Diastolic blood pressure for CVD
library(ggplot2)

# Subset the data where cardio = 1
data_cardio_1 <- data[data$cardio == 1, ]

# Box plot for ap_lo with cardio = 1
ggplot(data_cardio_1, aes(x = "Cardiovascular Disease", y = ap_lo)) +
  geom_boxplot() +
  labs(title = "Box Plot of Diastolic blood pressure for Cardiovascular Disease (cardio = 1)",
       x = "",
       y = "Diastolic blood pressure(ap_lo)")



######################## Logistic regression
# Fit logistic regression to analyze the relationship between glucose levels and cardiovascular disease


# Splitting the data into 70% training and 30% testing
train_indices <- sample(1:nrow(data), 0.7 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Training a logistic regression model on the training data
model <- glm(cardio ~ age+gender+ height + weight + ap_hi + ap_lo + cholesterol + gluc + smoke + alco + active, family = binomial(link = "logit"), data = train_data)

# Summary of the model
summary(model)

# Making predictions on the test data
predictions <- predict(model, newdata = test_data, type = "response")


library(pROC)
roc_values <- roc(test_data$cardio, predictions)

# Plot the ROC curve
plot(roc_values, col = "blue", main = "ROC Curve")

