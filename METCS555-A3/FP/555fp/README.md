# Airlines Dataset Analysis

This project aims to analyze the `airlines` dataset, which contains information about delays, airlines, and flights.

## Dataset Information

The dataset used in this script is sourced from the following URL: https://raw.githubusercontent.com/datasets/openml-datasets/master/data/airlines/airlines.csv

The dataset contains 5,063 observations and 9 variables, including:

- `Airline`: the name of the airline company;
- `Flight`: the flight number;
- `Time`: the scheduled departure time;
- `Length`: the length of the flight (in miles);
- `Delay`: the delay time (in minutes);
- `DayOfWeek`: the day of the week of the flight;
- `Hour`: the scheduled departure hour (in 24-hour format).

## Libraries

The following libraries are used:

* dplyr
* ggplot2
* tidyr

## Data Cleaning

To start the analysis, we cleaned the dataset by removing duplicate rows and missing values. We also checked for outliers using a boxplot and found no significant outliers.

## Analysis

### Two-way ANOVA

We performed a two-way ANOVA to investigate the effect of the `DayOfWeek` and `Hour` variables on the `Delay` variable. The `Length` and `Airline` variables were included as control variables. The results of the ANOVA showed that both `DayOfWeek` and `Hour` have a significant effect on `Delay`.

### Post-hoc Tests

To further investigate the effect of `DayOfWeek` on `Delay`, we conducted post-hoc tests using the Tukey method. The results showed that there were significant differences in delays between different days of the week.

### F-test

We also performed an F-test to investigate whether there were significant differences in delays between short-haul and long-haul flights. The results showed that there was a significant difference between the two types of flights.

## Visualizations

We created two visualizations to better understand the relationship between `Delay` and `DayOfWeek` and `Hour`.

The first visualization is a bar chart that shows the proportion of flights delayed by day of the week. The chart shows that flights on Friday and Monday are more likely to be delayed than flights on other days of the week.

The second visualization is a line graph that shows the proportion of flights delayed by hour of the day. The graph shows that flights scheduled during the morning hours and late evening hours are more likely to be delayed than flights scheduled during other times of the day.

## Conclusion

Overall, our analysis shows that both `DayOfWeek` and `Hour` have a significant effect on flight delays. We also found that flights on Friday and Monday are more likely to be delayed, and flights scheduled during the morning and late evening hours are more likely to be delayed than flights scheduled during other times of the day.

## Usage

To run the script, make sure you have R and the required libraries installed. Open the script in your preferred R environment, such as RStudio, and run the entire script. The script will download the dataset, perform the analysis, and display the results as printed output and visualizations.