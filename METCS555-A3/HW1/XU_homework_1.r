#q1
data <- read.csv("/home/xuyuhan/Desktop/BU-learn-S2023/METCS555A3/HW1/555-a3-hw1.csv", header = FALSE)
print(data)
data <- unlist(data, use.names = FALSE)
print(data)

#q2-3
hist(data,xlim = c(0,17), breaks = seq(0, 15, 1), ylim = c(0, 25))
summary_q2 <- summary(data)
print(summary_q2)
IQR <- 7.00 - 4.00
print(IQR)
MIN_Outliers <- 4 - 1.5 * IQR
MAX_Outliers <- 7 + 1.5 * IQR
print(MIN_Outliers)
print(MAX_Outliers)

#q4
Percent_Patient_less_10 <- pnorm(10, 6, 3)
p_greater_6 <- 1 - pnorm(6, 5, 3/sqrt(35))
print(Percent_Patient_less_10)
print(p_greater_6)