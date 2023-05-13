# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load dataset
dataset_url <- "https://raw.githubusercontent.com/datasets/openml-datasets/master/data/airlines/airlines.csv"
dataset <- read.csv(dataset_url)

# Data cleaning
# Remove duplicate rows
dataset_clean <- distinct(dataset)

# Remove rows with missing values
dataset_clean <- drop_na(dataset_clean)

# Check for outliers
boxplot(dataset_clean$Length)s

# Convert Time column to hours
dataset_clean$Hour <- floor(dataset_clean$Time / 60)

# Two-way ANOVA
dataset_clean$DayOfWeek <- as.factor(dataset_clean$DayOfWeek)
dataset_clean$Delay <- as.factor(dataset_clean$Delay)
anova_model <- aov(as.numeric(Delay) ~ DayOfWeek * Hour + Length + Airline, data = dataset_clean)
summary(anova_model)

# Post-hoc tests
library(emmeans)
posthoc <- emmeans(anova_model, pairwise ~ DayOfWeek)
summary(posthoc, adjust = "tukey")

# F-test
dataset_clean <- dataset_clean %>%
  mutate(FlightType = ifelse(Length <= 150, "Short-Haul", "Long-Haul"))

short_haul_delays <- as.numeric(dataset_clean[dataset_clean$FlightType == "Short-Haul", "Delay"])
long_haul_delays <- as.numeric(dataset_clean[dataset_clean$FlightType == "Long-Haul", "Delay"])

short_haul_variance <- var(short_haul_delays)
long_haul_variance <- var(long_haul_delays)

f_value <- short_haul_variance / long_haul_variance
df1 <- length(short_haul_delays) - 1
df2 <- length(long_haul_delays) - 1
p_value <- pf(f_value, df1, df2, lower.tail = FALSE)

cat("F-value:", f_value, "\n")
cat("Degrees of freedom 1:", df1, "\n")
cat("Degrees of freedom 2:", df2, "\n")
cat("P-value:", p_value, "\n")


# Bar chart of delays by day of the week
bar_plot <- ggplot(dataset_clean, aes(x = DayOfWeek, fill = Delay)) +
  geom_bar(position = "fill") +
  labs(y = "Proportion of Flights Delayed",
       title = "Proportion of Flights Delayed by Day of the Week") +
  theme_minimal()
bar_plot

# Line graph of delays by hour of the day
line_plot <- ggplot(dataset_clean, aes(x = Hour, y = as.numeric(Delay), group = 1)) +
  geom_line() +
  labs(y = "Proportion of Flights Delayed",
       title = "Proportion of Flights Delayed by Hour of the Day") +
  theme_minimal()
line_plot
