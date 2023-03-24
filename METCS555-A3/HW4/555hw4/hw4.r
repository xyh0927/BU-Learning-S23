# Load required libraries
library(dplyr)
library(ggplot2)
library(tidyr)
library(car)


###############################################question1###########################################################
# Read data into R
data <- read.csv("hw4.csv")

# (1) How many students are in each group?
count_by_group <- data %>%
  group_by(group) %>%
  summarize(n = n())
print(count_by_group)

# Summarize the data relating to both test score and age by the student group
summary_by_group <- data %>%
  group_by(group) %>%
  summarize(mean_iq = mean(iq), sd_iq = sd(iq), mean_age = mean(age), sd_age = sd(age))
print(summary_by_group)

# Graphical summaries
ggplot(data, aes(x = group, y = iq, fill = group)) + geom_boxplot() + theme_minimal()
ggplot(data, aes(x = group, y = age, fill = group)) + geom_boxplot() + theme_minimal()

# (2) Do the test scores vary by student group?
# Step 1: State the null hypothesis (H0) and the alternative hypothesis (Ha)
# H0: The means of test scores are equal for all student groups (µ_physics = µ_math = µ_chemistry)
# Ha: The means of test scores are not equal for at least one pair of student groups

# Step 2: Choose the significance level (α)
# α = 0.05

# Step 3: Calculate the test statistic and p-value
anova_result <- aov(iq ~ group, data = data)
anova_summary <- summary(anova_result)
print(anova_summary)

# Step 4: Make a decision to accept or reject the null hypothesis based on the p-value
# Compare the p-value from the ANOVA output with the significance level (α)
p_value <- anova_summary[[1]]["group", "Pr(>F)"]
cat("p-value =", p_value, "\n")
if (p_value < 0.05) {
  cat("Reject the null hypothesis: There is a significant difference in test scores between at least one pair of student groups.\n")
} else {
  cat("Fail to reject the null hypothesis: There is no significant difference in test scores between the student groups.\n")
}

# Step 5: Interpret the results
# Based on the decision in step 4, either conclude that there is no significant difference between the means of test scores for the three student groups,
# or that there is a significant difference for at least one pair of student groups. If the latter, proceed with Tukey's pairwise comparisons.
if (p_value < 0.05) {
  tukey_result <- TukeyHSD(anova_result)
  print(tukey_result)
}

# (3) Create dummy variables for student group
data_dummy <- data %>%
  mutate(group_physics = as.integer(group == "Physics student"),
         group_math = as.integer(group == "Math student"))

# Re-run the one-way ANOVA using the lm function with the newly created dummy variables
lm_result <- lm(iq ~ group_physics + group_math, data = data_dummy)
summary(lm_result)

# Confirm the results are the same
Anova(lm_result, type = "III") # car package is needed for type III SS

###############################################question2###########################################################
# Read the data from the CSV file
data <- read.csv("hw4-2.csv", row.names = 1)

# Display the data
print(data)

# Perform the chi-square test of independence
chi_square_test <- chisq.test(data)

# Print the result
print(chi_square_test)


###############################################ec###########################################################
library(tidyverse)
library(ez)

# Read the data from the CSV file
data <- read.csv("hw4-ec.csv", row.names = 1)

# Display the data
print(data)

# Convert the data into a long format
data_long <- data %>% 
  rownames_to_column("Subject") %>%
  pivot_longer(cols = c("X7", "X5", "X3", "X1"), names_to = "Days", values_to = "PainThreshold")

# Perform the repeated-measures ANOVA
anova_results <- ezANOVA(
  data = data_long,
  dv = PainThreshold,
  wid = Subject,
  within = Days,
  type = 3
)

# Print the results
print(anova_results)

# Check the p-value
if (anova_results$ANOVA[1, "p"] < 0.01) {
  cat("The data indicate a significant change in pain threshold (p-value <", anova_results$ANOVA[1, "p"], ").\n")
} else {
  cat("The data do not indicate a significant change in pain threshold (p-value =", anova_results$ANOVA[1, "p"], ").\n")
}
