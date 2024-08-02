# Load the necessary library for reading the data
library(readr)
library(caret)

# Load the dataset
data <- read_csv("C:\Users\gowni\Downloads\cleaned_cardio_train (3).csv") 

# Explicitly convert to factors with levels
data$gender <- factor(data$gender, levels = c(1, 2))
data$cholesterol <- factor(data$cholesterol, levels = c(1, 2, 3))
data$gluc <- factor(data$gluc, levels = c(1, 2, 3))

# Split the data into training and testing sets
set.seed(123) # for reproducibility
training_indices <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[training_indices, ]
test_data <- data[-training_indices, ]

# Build the logistic regression model using the training set
model <- glm(cardio ~ ., data = train_data, family = binomial())

# Summarize the model to see the results
summary(model)

# Predicting the probabilities on the test set
test_data$predicted_prob <- predict(model, newdata = test_data, type = "response")

# Optionally, you can create a confusion matrix to evaluate the model
confusionMatrix(as.factor(ifelse(test_data$predicted_prob > 0.5, 1, 0)), as.factor(test_data$cardio))

# Save the model for later use (for Shiny app)
saveRDS(model, "/Users/saicharan/Downloads/cardio_model.rds")

library(shiny)
library(readr)
library(caret)

# Define the UI for the application
ui <- fluidPage(
  titlePanel("Cardiovascular Disease Prediction"),
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age", value = 50),
      selectInput("gender", "Gender", choices = c("Female" = 1, "Male" = 2)),
      numericInput("height", "Height (cm)", value = 170),
      numericInput("weight", "Weight (kg)", value = 70),
      numericInput("ap_hi", "Systolic blood pressure", value = 120),
      numericInput("ap_lo", "Diastolic blood pressure", value = 80),
      selectInput("cholesterol", "Cholesterol", choices = c("Normal" = 1, "Slightly Higher than Normal Range" = 2, "Very Higher than Normal Range" = 3)),
      selectInput("gluc", "Glucose", choices = c("Normal" = 1, "Slightly Higher than Normal Range" = 2, "Very Higher than Normal Range" = 3)),
      checkboxInput("smoke", "Smoker", value = FALSE),
      checkboxInput("alco", "Alcohol intake", value = FALSE),
      checkboxInput("active", "Physical activity", value = TRUE),
      actionButton("predict", "Predict")
    ),
    mainPanel(
      verbatimTextOutput("prediction")
    )
  )
)

# Define the server logic required to predict the Risk of cardiovascular disease
server <- function(input, output) {
  
# Load the logistic regression model
  model <- readRDS("C:\Users\gowni\Downloads\model.rds") # Adjust the path as needed
  
  observeEvent(input$predict, {
    # Create a new data frame for prediction based on the input
    newdata <- data.frame(
      age = as.numeric(input$age),
      gender = factor(as.numeric(input$gender), levels = c(1, 2)),
      height = as.numeric(input$height),
      weight = as.numeric(input$weight),
      ap_hi = as.numeric(input$ap_hi),
      ap_lo = as.numeric(input$ap_lo),
      cholesterol = factor(input$cholesterol, levels = c("1", "2", "3")),
      gluc = factor(input$gluc, levels = c("1", "2", "3")),
      smoke = as.numeric(input$smoke),
      alco = as.numeric(input$alco),
      active = as.numeric(input$active)
    )
    
    # Predict the risk of cardiovascular disease
    probability <- predict(model, newdata, type = "response")
    
    output$prediction <- renderText({
      paste("Risk Estimation of Cardiovascular Disease :", round(probability * 100, 2), "%")
    })
  })
}

shinyApp(ui = ui, server = server)

