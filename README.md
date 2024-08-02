# Cardiovascular Health: A Study of Factors Influencing Heart Disease Risk

## Overview
This project analyzes a cardiovascular dataset, offering a wide range of health measurements and lifestyle markers. The goal is to identify patterns, associations, and risk factors contributing to cardiovascular health and to build a predictive model for cardiovascular disease.

## Introduction
We analyzed the cardiovascular dataset that includes various health measurements and lifestyle markers. By scrutinizing this dataset, we aim to unearth patterns, associations, and risk factors contributing to cardiovascular health and build a predictive model for cardiovascular disease.

## Dataset
The dataset contains demographic, health-related, and lifestyle factors. The target variable is 'cardio', indicating the presence or absence of cardiovascular disease.

**Variables:**
- Age, Gender, Height, Weight
- Systolic and Diastolic Blood Pressure
- Cholesterol and Glucose Levels
- Smoking, Alcohol Consumption, Physical Activity
- Cardiovascular Disease Presence

## Research Questions
1. Is there any gender-based difference in the distribution of cardiovascular disease?
2. What is the relationship between systolic blood pressure and cardiovascular disease?
3. How does diastolic blood pressure relate to cardiovascular disease?
4. Which attributes significantly impact predicting cardiovascular disease?
5. How do different health attributes contribute to cardiovascular disease likelihood?

## Data Cleaning and Transformation
We used the Pandas library in Python for data cleaning. Steps included:
- Removing rows with missing values.
- Eliminating duplicate rows.
- Converting 'age' to an integer.
- Filtering out extreme values in 'ap_hi' and 'ap_lo'.

## Methodology
### Visualizations
- **Gender-based Distribution**: Grouped bar chart of cardiovascular disease by age group and gender.
- **Systolic Blood Pressure**: Box plot of systolic blood pressure for cardiovascular disease.
- **Diastolic Blood Pressure**: Box plot of diastolic blood pressure for cardiovascular disease.

### Predictive Modeling
- **Logistic Regression Model**: To predict cardiovascular disease using health metrics and lifestyle indicators.
- **ROC Curve**: Evaluates the performance of the predictive model.

### Shiny Web App
Developed a Web Application to predict cardiovascular disease risk based on personal health inputs.

## Conclusion
This analysis provides critical insights into cardiovascular disease, identifying influential factors and aiding in preventive healthcare interventions. The predictive model helps in proactive identification of high-risk individuals, promoting early detection and preventive measures.

## References
Cardiovascular Disease dataset. (2019, January 20). Kaggle. https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset
