calories <- read.csv("/home/xuyuhan/Desktop/BU-learn-S2023/METCS555A3/HW2/Calorie.csv", header = T)
participant <- calories$participants
nonparticipant <- na.omit(calories$nonparticipants)
nonparticipant
#1
par(mfrow=c(1,1))
hist(calories$participants,xlab = "Calories", main = "Participants",breaks = 5)
par(mfrow=c(1,1),mar = c(1, 1, 1, 1))
hist(calories$nonparticipants,xlab = "Calories", main = "Non-Participants",breaks = 5)

#2
#step1: H0:mu=0,h1:mu!=0,alpha=0.05
#step2: t=(mean-mu)/(s/sqrt(n))
#step3: reject h0 if abs(t)>=1.711, or do not reject
#step4:
avg <- mean(participant)
s <- sd(participant)
n <- length(participant)
t <- (avg - 425)/ (s/sqrt(n))
abs_t <- abs(t)
abs_t #do not reject H0
#step5
t.test(participant, mu = avg,alternative = "two.sided")#can not reject because participant is not differ from 425

#3
t.test(participant, mu = avg, alternative = "two.sided", conf.level = 0.9)

#4
#step1: h0:mu1=mu2,h1:mu1>mu2,alpha=0.05
#step2: t=((mean1-mean2)-(mu1-mu2))/(sqrt((s1^2/n1)+(s2^2/n2)))
#step3: reject h0 if abs(t)>=1.721, or do not reject
#step4: 
avg1 <- mean(participant)
avg1
avg2 <- mean(nonparticipant)
avg2
s1 <- sd(participant)
s1
s2 <- sd(nonparticipant)
s2
n1 <- length(participant)
n1
n2 <- length(nonparticipant)
n2
t <- (avg1-avg2)/(sqrt((s1^2/n1)+(s2^2/n2)))
t #do not reject h0
#step5: 
t.test(participant,nonparticipant,alternative = "greater", conf.level = 0.95)
#participants consumed more than nonparticipant

#5
#assumption in 4 is true

#extra credit
before <- c(158, 185, 176, 172, 164, 234, 258, 200, 228, 246, 198, 221, 236, 255, 231)
after <- c(163, 182, 188, 150, 161, 220, 235, 191, 228, 237, 209, 220, 222, 268, 234)
difference <- after - before
t.test(difference, mu = 0, alternative = "two.sided")
