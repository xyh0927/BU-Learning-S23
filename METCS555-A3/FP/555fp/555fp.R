# Load required libraries
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(caret)

# Read data
url <- "https://raw.githubusercontent.com/datasets/openml-datasets/master/data/airlines/airlines.csv"
data <- read_csv(url)

# Sample 1000 lines
set.seed(123)
sample_data <- data %>% sample_n(1000)

# Check for missing values
summary(sample_data)

# Check for duplicate rows
sample_data <- sample_data %>% distinct()

# Check for outliers in Length
boxplot(sample_data$Length)

# Descriptive statistics
summary(sample_data)


# Chi-square test for DayOfWeek and Delay
chisq_test <- chisq.test(sample_data$DayOfWeek, sample_data$Delay)
chisq_test


# Logistic regression
log_model <- glm(Delay ~ Length + DayOfWeek + Airline + AirportFrom + AirportTo, data = sample_data, family = binomial())
summary(log_model)


# Bar chart of DayOfWeek and proportion of flights delayed
delay_by_day <- sample_data %>% group_by(DayOfWeek) %>% summarize(Delay_Proportion = mean(Delay))
ggplot(delay_by_day, aes(x = DayOfWeek, y = Delay_Proportion)) + geom_bar(stat = "identity") + theme_minimal()

#Bar chart for Airline and proportion of flights delayed
delay_by_airline <- sample_data %>% group_by(Airline) %>% summarize(Delay_Proportion = mean(Delay))
ggplot(delay_by_airline, aes(x = reorder(Airline, -Delay_Proportion), y = Delay_Proportion)) + 
  geom_bar(stat = "identity") + 
  theme_minimal() + 
  labs(x = "Airline", y = "Proportion of Flights Delayed") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Bar chart for AirportFrom and proportion of flights delayed
delay_by_airport_from <- sample_data %>% group_by(AirportFrom) %>% summarize(Delay_Proportion = mean(Delay))
ggplot(delay_by_airport_from, aes(x = reorder(AirportFrom, -Delay_Proportion), y = Delay_Proportion)) + 
  geom_bar(stat = "identity") + 
  theme_minimal() + 
  labs(x = "Departure Airport", y = "Proportion of Flights Delayed") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Bar chart for AirportTo and proportion of flights delayed
delay_by_airport_to <- sample_data %>% group_by(AirportTo) %>% summarize(Delay_Proportion = mean(Delay))
ggplot(delay_by_airport_to, aes(x = reorder(AirportTo, -Delay_Proportion), y = Delay_Proportion)) + 
  geom_bar(stat = "identity") + 
  theme_minimal() + 
  labs(x = "Arrival Airport", y = "Proportion of Flights Delayed") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))




###conclusion and limitation
##Based on the results of the logistic regression and chi-square test, draw conclusions about the factors significantly associated with flight delays. Discuss any limitations of the analysis, such as potential violations of statistical test assumptions or limited generalizability due to the small sample size. Provide recommendations for further research or strategies to reduce flight delays.
