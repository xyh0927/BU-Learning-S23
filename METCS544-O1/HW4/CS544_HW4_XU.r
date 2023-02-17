#part 1
p1 <- 0.4
n1 <- 5

#a
success <- 0:n1
cdf_1 <- pbinom(success, size=n1, prob=p1)
print(cdf_1)
pmf_1 <- dbinom(success, size=n1, prob=p1)
print(pmf_1)
plot(success, cdf_1 ,type='h',xlab="Sucesses",ylab="Probabilities",col="red",lwd=3,main="CDF")
plot(success, pmf_1,type='h',xlab="Sucesses",ylab="Probabilities",col="red",lwd=3,main="PMF")

#b
p_b <- dbinom(2,n1,p1)
print(p_b)

#c
p_c <- 1-pbinom(1,n1,p1)
print(p_c)

#d
set.seed(123)
num_perfect_scores <- rbinom(1000, size = n1, prob = p1)
barplot(table(num_perfect_scores), main = "Frequency of the number of perfect scores over 5 attempts", 
        xlab = "Number of perfect scores", ylab = "Frequency")


#########################################################################################################################################
#########################################################################################################################################

#part 2
p2 <- 0.6 
r <- 3 
n2 <- 10
#a
x <- 0:(n2 - r)
pmf2 <- dnbinom(x, size = r, prob = p2)
print(pmf2)
plot(x, pmf2, type = "h", xlab = "Number of failures", ylab = "Probability", 
     main = "PMF")
cdf2 <- pnbinom(x, size = r, prob = p2)
print(cdf2)
plot(x, cdf2, type = "s", xlab = "Number of failures", ylab = "Probability", 
     main = "CDF")

#b
prob_4 <- dnbinom(4, size = r, prob = p2)
print(prob_4)

#c
prob_atmost_4 <- pnbinom(4, size = r, prob = p2)
print(prob_atmost_4)

#d
set.seed(123)
num_failures <- rnbinom(1000, size = r, prob = p2)

barplot(table(num_failures), main = "Frequency of the number of failures to achieve three perfect scores", 
        xlab = "Number of failures", ylab = "Frequency")


#########################################################################################################################################
#########################################################################################################################################

#part 3
n3 <- 20
p3 <- 0.6

#a
x <- 0:20
pmf3a <- dhyper(x, m = p3*100, n = 40, k = n3)
plot(x, pmf3a, type = "h", xlab = "Number of Multiple Choice Questions", ylab = "Probability")

#b
p_exact10 <- dhyper(10, m = p3*100, n = 40, k = n3)
print(p_exact10)


#c
p_least10 <- 1 - phyper(9, m = p3*100, n = 40, k = n3)
print(p_least10)

#d
set.seed(123)
sim_data <- rhyper(1000, m = p3*100, n = 40, k = n3)
barplot(table(sim_data), xlab = "Number of Multiple Choice Questions", ylab = "Frequency")

#########################################################################################################################################
#########################################################################################################################################

#part 4
numQ <- 10

#a
print(dpois(8, numQ))

#b
print(ppois(8, numQ))

#c
print(ppois(12, numQ) - ppois(5, numQ))

#d
x <- 0:20
prob <- dpois(x, numQ)
plot(x, prob, type = "h", xlab = "Number of Questions", ylab = "Probability", main = "PMF")

#e
set.seed(123)
sim_data <- rpois(50, numQ)
barplot(table(sim_data), xlab = "Number of Questions", ylab = "Frequency")
boxplot(sim_data, xlab = "Number of Questions")

#########################################################################################################################################
#########################################################################################################################################

#part 5
Avg <- 100
stand_d <- 10

#a
x <- seq(Avg - 3*stand_d, Avg + 3*stand_d, length.out = 100)
y <- dnorm(x, mean = Avg, sd = stand_d)
plot(x, y, type = "l", main = "PDF",
     xlab = "Money Spent ($)", ylab = "Density")

#b
print(1 - pnorm(120, mean = Avg, sd = stand_d))

#c
print(pnorm(90, mean = Avg, sd = stand_d) - pnorm(80, mean = Avg, sd = stand_d))

#d
print(pnorm(Avg + stand_d, mean = Avg, sd = stand_d) + pnorm(Avg - stand_d, mean = Avg, sd = stand_d))
print(pnorm(Avg + 2*stand_d, mean = Avg, sd = stand_d) + pnorm(Avg - 2*stand_d, mean = Avg, sd = stand_d))
print(pnorm(Avg + 3*stand_d, mean = Avg, sd = stand_d) + pnorm(Avg - 3*stand_d, mean = Avg, sd = stand_d))

#e
print(qnorm(0.1, mean = Avg, sd = stand_d))
print(qnorm(0.9, mean = Avg, sd = stand_d))

#f
print(qnorm(0.98, mean = Avg, sd = stand_d))


#g
set.seed(123)
visitors <- rnorm(10000, mean = Avg, sd = stand_d)
hist(visitors, main = "Money Spent by Visitors",
     xlab = "Money Spent ($)", col = "red", breaks = 20)