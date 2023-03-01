#part1
boston <- read.csv("https://people.bu.edu/kalathur/datasets/bostonCityEarnings.csv", colClasses = c("character", "character", "character", "integer", "character"))

#a
breaks <- seq(0, 400000, by = 50000)
hist(boston$Earnings, breaks = breaks, xlab = "Earnings", main = "Histogram of Boston City Earnings")
mean_earnings <- mean(boston$Earnings)
sd_earnings <- sd(boston$Earnings)
cat("Mean of earnings: ", mean_earnings, "\n")
cat("Standard deviation of earnings: ", sd_earnings, "\n")

#b
set.seed(9286)
sample_means <- replicate(1000, mean(sample(boston$Earnings, size = 10, replace = FALSE)))
hist(sample_means, xlab = "Sample Means", main = "Histogram of Sample Means (n = 10)")
mean_sample_means <- mean(sample_means)
sd_sample_means <- sd(sample_means)
cat("Mean of sample means: ", mean_sample_means, "\n")
cat("Standard deviation of sample means: ", sd_sample_means, "\n")


#c
set.seed(9286)
sample_means <- replicate(1000, mean(sample(boston$Earnings, size = 40, replace = FALSE)))
hist(sample_means, xlab = "Sample Means", main = "Histogram of Sample Means (n = 40)")
mean_sample_means <- mean(sample_means)
sd_sample_means <- sd(sample_means)
cat("Mean of sample means: ", mean_sample_means, "\n")
cat("Standard deviation of sample means: ", sd_sample_means, "\n")

#part2
#a
set.seed(9286)
nbinom_data <- rnbinom(1000, size = 3, prob = 0.5)
prop_table <- table(nbinom_data)/length(nbinom_data)
barplot(prop_table, main = "Proportions of Distinct Values",
        xlab = "Values", ylab = "Proportions")
#b
set.seed(9286)
sample_size <- c(10, 20, 30, 40)
n_samples <- 5000
samples <- lapply(sample_size, function(x) replicate(n_samples, sample(nbinom_data, size = x, replace = FALSE)))
par(mfrow = c(2, 2))
for (i in seq_along(sample_size)) {
  means <- apply(samples[[i]], 2, mean)
  hist(means, main = paste0("Sample Size = ", sample_size[i]), xlab = "Sample Mean", prob = TRUE)
  lines(density(means))
}

#c
data_summary <- data.frame(Dataset = c("Original Data", "Sample Size = 10", "Sample Size = 20", "Sample Size = 30", "Sample Size = 40"),
                           Mean = c(mean(nbinom_data), sapply(samples, function(x) mean(x))),
                           SD = c(sd(nbinom_data), sapply(samples, function(x) sd(x))))
print(data_summary)


#part3
top5_depts <- head(sort(table(boston$Department), decreasing = TRUE), n = 5)
boston_top5 <- boston[boston$Department %in% names(top5_depts), ]
set.seed(9286) 
#a
srs <- sample(boston_top5$Department, size = 50, replace = TRUE)
table_srs <- table(srs)
prop_srs <- prop.table(table_srs)
print(table_srs)
print(prop_srs)
#b
earnings_prop <- boston_top5$Earnings / sum(boston_top5$Earnings)
sys_prob <- rep(earnings_prop, each = 1)
sys <- boston_top5$Department[seq(1, nrow(boston_top5), length.out = 50, along.with = sys_prob)]
table_sys <- table(sys)
prop_sys <- prop.table(table_sys)
print(table_sys)
print(prop_sys)
#c
boston_top5_ord <- boston_top5[order(boston_top5$Department), ]
dept_list <- split(boston_top5_ord, f = boston_top5_ord$Department)
strat <- unlist(lapply(dept_list, function(x) {
  size <- round(nrow(x) / nrow(boston_top5_ord) * 50)
  sample(x$Department, size = size, replace = TRUE)
}))
table_strat <- table(strat)
prop_strat <- prop.table(table_strat)
print(table_strat)
print(prop_strat)
#d
mean_data <- mean(boston_top5$Earnings)
mean_srs <- mean(boston_top5$Earnings[boston_top5$Department %in% names(table_srs)])
mean_sys <- mean(boston_top5$Earnings[boston_top5$Department %in% names(table_sys)])
mean_strat <- mean(boston_top5$Earnings[boston_top5$Department %in% names(table_strat)])
print(mean_data)
print(mean_srs)
print(mean_sys)
print(mean_strat)