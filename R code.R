# Load the necessary libraries
library(tidyverse)

# Load the datasets for 2014-2018
df_2014 <- read_csv("C:/Users/123/Desktop/2014_Financial_Data.csv")
df_2015 <- read_csv("C:/Users/123/Desktop/2015_Financial_Data.csv")
df_2016 <- read_csv("C:/Users/123/Desktop/2016_Financial_Data.csv")
df_2017 <- read_csv("C:/Users/123/Desktop/2017_Financial_Data.csv")
df_2018 <- read_csv("C:/Users/123/Desktop/2018_Financial_Data.csv")



# Handle missing data by replacing NA values with 0
df_2014_clean <- df_2014
df_2014_clean[is.na(df_2014_clean)] <- 0
df_2015_clean <- df_2015
df_2015_clean[is.na(df_2015_clean)] <- 0
df_2016_clean <- df_2016
df_2016_clean[is.na(df_2016_clean)] <- 0
df_2017_clean <- df_2017
df_2017_clean[is.na(df_2017_clean)] <- 0
df_2018_clean <- df_2018
df_2018_clean[is.na(df_2018_clean)] <- 0

# For example, we can set all data frames to have the same column names as the 2014 data frame.
colnames(df_2015_clean) <- colnames(df_2014_clean)
colnames(df_2016_clean) <- colnames(df_2014_clean)
colnames(df_2017_clean) <- colnames(df_2014_clean)
colnames(df_2018_clean) <- colnames(df_2014_clean)

# Rename the first column in each dataset to "StockCode"
colnames(df_2014_clean)[1] <- "StockCode"
colnames(df_2015_clean)[1] <- "StockCode"
colnames(df_2016_clean)[1] <- "StockCode"
colnames(df_2017_clean)[1] <- "StockCode"
colnames(df_2018_clean)[1] <- "StockCode"

# Add a "Year" column to each dataset
df_2014_clean$Year <- 2014
df_2015_clean$Year <- 2015
df_2016_clean$Year <- 2016
df_2017_clean$Year <- 2017
df_2018_clean$Year <- 2018

# Combine all companies' data 
df_all <- rbind(df_2014_clean, df_2015_clean, df_2016_clean, df_2017_clean, df_2018_clean)

# Show number of rows of  dataset
nrow(df_all)


# Set random seeds to ensure repeatability
set.seed(42)

# shuffle the rows of the dataframe in random order
df_all <- df_all[sample(1:nrow(df_all)), ]   

# using 70% of data for training
train_size = 0.7
df_all_train <- df_all[1:(train_size * nrow(df_all)), ]
df_all_test <- df_all[(nrow(df_all_train) + 1):nrow(df_all), ]

# Calculate the average Quick Ratio and Debt to Equity Ratio on the training data
df_avg_train <- df_all_train %>%
  group_by(Year) %>%
  summarize(
    avg_quickRatio = mean(quickRatio, na.rm = TRUE),
    avg_debtEquityRatio = mean(debtEquityRatio, na.rm = TRUE)
  )

# Visualizing financial indicators: Average Quick Ratio over years
ggplot(df_avg_train, aes(x = factor(Year), y = avg_quickRatio)) + 
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(
    title = "Average Quick Ratio Analysis (All Companies, 2014-2018)", 
    x = "Year", 
    y = "Average Quick Ratio"
  )
print(df_avg_train$avg_quickRatio)

# Visualizing financial indicators: Average Debt to Equity Ratio over years
ggplot(df_avg_train, aes(x = factor(Year), y = avg_debtEquityRatio)) + 
  geom_bar(stat = "identity", fill = "red") +
  labs(
    title = "Average Debt to Equity Ratio (All Companies, 2014-2018)", 
    x = "Year", 
    y = "Average Debt to Equity Ratio"
  )
print(df_avg_train$avg_debtEquityRatio)

# Renamed for subsequent use
colnames(df_all_train)[15] <- "Net.Income"
colnames(df_all_train)[44] <- "Total.assets"
colnames(df_all_train)[54] <- "Total.liabilities"
view(df_all_train)

# Perform Linear Regression on the  dataset
lm_model <- lm(Net.Income ~ Revenue + Total.assets + EBITDA + Total.liabilities, data = df_all_train)
summary(lm_model)

# Visualization: Correlation Matrix
library(corrplot)
correlation_matrix <- cor(df_all_train %>% select(Revenue, Total.assets, EBITDA, Total.liabilities, Net.Income))
corrplot(correlation_matrix, method = "circle", type = "upper", tl.col = "black", tl.srt = 45)
print(correlation_matrix) 

# Visualization: View residuals
plot(
  lm_model,
  which=1
)

# Renamed for subsequent use
colnames(df_all_test)[15] <- "Net.Income"
colnames(df_all_test)[44] <- "Total.assets"
colnames(df_all_test)[54] <- "Total.liabilities"
view(df_all_test)

# Prediction
predictions <- predict(lm_model, newdata = df_all_test)

# True value vs. predicted value
ggplot(data = data.frame(Actual = df_all_test$Net.Income, Predicted = predictions), aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Actual vs Predicted Net Income", x = "Actual Net Income", y = "Predicted Net Income") +
  theme_minimal()


# Evaluate the model
mse <- mean((predictions - df_all_test$Net.Income)^2) # Mean Squared Error
rmse <- sqrt(mse)  # Root Mean Squared Error
print(paste("RMSE: ", rmse))

