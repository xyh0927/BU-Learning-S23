library(ggplot2)

#part1
forbes <- read.csv("https://people.bu.edu/kalathur/datasets/forbes.csv")
print(forbes)
#a
ggplot(forbes,aes(x = country))+geom_bar(fill = "blue") + xlab("Country") + 
  ylab("Number of Rich People") + ggtitle("Frequencies of the Number of Rich People by Country")

#b
ggplot(forbes, aes(x = gender, fill = gender)) + geom_bar() + xlab("Gender") + 
  ylab("Number of People") + ggtitle("Distribution of Females and Meewaales in the Forbes Billionaires List")

#c
top5 <- as.data.frame(table(forbes$category))[1:5, ]
ggplot(forbes, aes(x=category, fill=gender)) +
  geom_bar(position="dodge") +
  labs(title="Distribution of Females and Males across Top 5 Categories in Forbes Billionaires List",
       x="Category", y="Count") +
  scale_x_discrete(limits=top5$Var1)


############################################################################################################################
############################################################################################################################

#part2
#a
us_quarters <- read.csv("https://people.bu.edu/kalathur/datasets/us_quarters.csv")
us_quarters$State[which.max(us_quarters$DenverMint)]
us_quarters$State[which.max(us_quarters$PhillyMint)]
us_quarters$State[which.min(us_quarters$DenverMint)]
us_quarters$State[which.min(us_quarters$PhillyMint)]

#b
par(mfrow=c(1,2),mar = c(1, 1, 1, 1))
barplot(cbind(DenverMint, PhillyMint) ~ State, col = c('blue','grey'),data = us_quarters, beside = T, legend = T)
plot(us_quarters$DenverMint, us_quarters$PhillyMint)
 
#c
par(mfrow=c(1,2),mar = c(1, 1, 1, 1))
boxplot(us_quarters$DenverMint, main="Denver Mint", ylab="Quarters (in thousands)")
boxplot(us_quarters$PhillyMint, main="Philly Mint", ylab="Quarters (in thousands)")

#d
f_den = fivenum(us_quarters$DenverMint)
us_quarters$State[c(which(us_quarters$DenverMint > (f_den[4]+1.5*(f_den[4]-f_den[2]))),
                    which(us_quarters$DenverMint < (f_den[2]-1.5*(f_den[4]-f_den[2]))))]


f_ph = fivenum(us_quarters$PhillyMint)
us_quarters$State[c(which(us_quarters$PhillyMint > (f_ph[4]+1.5*(f_ph[4]-f_ph[2]))),
                    which(us_quarters$PhillyMint < (f_ph[2]-1.5*(f_ph[4]-f_ph[2]))))]


############################################################################################################################
############################################################################################################################

#part3
stocks <- read.csv("https://people.bu.edu/kalathur/datasets/stocks.csv")

#a
pairs(~ MSFT + AAPL + GOOG + FB + AMZN + TSLA, data = stocks)

#b
stocks1 <- subset(stocks, select = -c(Date))
cm <- cor(stocks1)
round(res, 2)

#c
summary(stocks)

#d
n <- ncol(stocks)
for (i in 1:n) {
  stock <- colnames(stocks)[i+1]
  corr <- cm[i, ]
  top3 <- names(sort(corr, decreasing = TRUE))[2:(2 + 3)]
  cat(sprintf("Top 3 for Stock %s\n%s\t%s\t%s\n%0.2f\t%0.2f\t%0.2f\n\n",
              stock, top3[1], top3[2], top3[3], corr[top3[1]], corr[top3[2]], corr[top3[3]]))
}





############################################################################################################################
############################################################################################################################

#part4
scores <- read.csv("https://people.bu.edu/kalathur/datasets/scores.csv")

#a
h <- hist(scores$Score,breaks=8)
text(h$breaks+2.5,h$counts,labels=h$counts)

#b
g <- hist(scores$Score,breaks=c(30,50,70,90))
shc <- unlist(g[2])
shb <- unlist(g[1])
shg <- c("C","B","A")
numIter = length(shc)
for (i in 1:numIter) {
  st <- sprintf("%d students in %s grade range (%d,%d]",shc[i],shg[i],shb[i],shb[i+1])
  print(st)
}
