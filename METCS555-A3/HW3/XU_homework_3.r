getwd()
setwd('/home/xuyuhan/Desktop/BU-learn-S2023/METCS555A3/HW3')
mercury = read.csv('cs555_hw3.csv', header = TRUE)

#homework main
#1
plot(mercury$Number.of.meals.with.fish, mercury$Total.Mercury.in.mg.g,xlab= 'Number of meals with fish', ylab= 'Merucury level in mg/g', col= 'blue', main='Relation between fish and mercury level inmg/g')

#2
cor(mercury$Number.of.meals.with.fish, mercury$Total.Mercury.in.mg.g)

#3
model <- lm(Total.Mercury.in.mg.g ~ Number.of.meals.with.fish, data = mercury)
a <- coef(model)[1] # intercept
b <- coef(model)[2] # slope
cat("Regression equation: Total Mercury = ", round(a, 3), "+", round(b, 3), "x Number of meals with fish")
plot(mercury$Number.of.meals.with.fish, mercury$Total.Mercury.in.mg.g,
     xlab = "Number of meals with fish", ylab = "Total Mercury in mg/g",
     main = "Scatterplot of number of meals with fish and total mercury levels")
abline(model, col = "red")

#4
beta1_hat <- coef(model)[2]
cat("The estimate for 𝛽1 is", beta1_hat, ". This means that for every additional meal with fish, the average total mercury in head hair is estimated to increase by", beta1_hat, "mg/g.\n")
beta0_hat <- coef(model)[1]
cat("The estimate for 𝛽0 is", beta0_hat, ". This means that when the number of meals with fish is 0, the average total mercury in head hair is estimated to be", beta0_hat, "mg/g.\n")

#5
anova(model)
summary(model)$coefficients[2, 2]

# Hypothesis test
# Step 1: State the null and alternative hypotheses
# H0: β1 = 0
# Ha: β1 ≠ 0

# Step 2: Set the significance level
alpha <- 0.05

# Step 3: Calculate the test statistic
t_stat <- summary(model)$coefficients[2, 3]

# Step 4: Calculate the p-value
p_value <- 2 * pt(abs(t_stat), df = nrow(mercury) - 2, lower.tail = FALSE)

# Step 5: Make a decision and interpret the results
if (p_value < alpha) {
  cat("Reject H0: β1 ≠ 0\n")
} else {
  cat("Fail to reject H0: β1 = 0\n")
}


summary(model)$r.squared
confint(model, level = 0.90)


#ec
