library(prob)

#part2
sampleSpace <- rolldie(3)
sampleSpace$probs <- 1/nrow(sampleSpace)

#a
sumRow <- rowSums(sampleSpace[c('X1', 'X2', 'X3')]) 
ThreeToEight <- sampleSpace[sumRow >3 & sumRow <8,]
print(ThreeToEight)
print(sum(ThreeToEight$probs))

#b
all3identRow <- (sampleSpace['X1'] == sampleSpace['X2']) &(sampleSpace['X2'] == sampleSpace['X3'])
all3ident <- sampleSpace[all3identRow,]
print(all3ident)
print(sum(all3ident$probs))

#c
twoRowM <- (sampleSpace['X1'] == sampleSpace['X2']) | (sampleSpace['X1'] == sampleSpace['X3']) |(sampleSpace['X2'] == sampleSpace['X3'])
TwoidentRow <- twoRowM &(!all3identRow)
Twoident <- sampleSpace[TwoidentRow,]
print(Twoident)
print(sum(Twoident$probs))

#d
NoneIdentRow <- (sampleSpace['X1'] != sampleSpace['X2']) & (sampleSpace['X1'] != sampleSpace['X3']) & (sampleSpace['X2'] != sampleSpace['X3'])
NoneIdent <- sampleSpace[NoneIdentRow,]
print(NoneIdent)
print(sum(NoneIdent$probs))

#e
TwoidentRow3To8 <- twoRowM &(!all3identRow) & sampleSpace[sumRow >3 & sumRow <8,]
Twoident3To8 <- sampleSpace[TwoidentRow3To8,]
print(Twoident3To8)
print(sum(Twoident3To8$probs))


#part3
sum_of_first_N_even_squares <- function(n){
    sum <- 0
    tmp <- 0
    for(i in 1:n){
        tmp <- (i * 2)^2
        sum <- sum + tmp
    }
    print(sum)
}
sum_of_first_N_even_squares(2)
sum_of_first_N_even_squares(5)
sum_of_first_N_even_squares(10)

#part4
tsla <- read.csv("https://people.bu.edu/kalathur/datasets/TSLA.csv")

#a
sm <- summary(tsla$Close)
names(sm) <- c("Min","Q1","Q2","Mean","Q3","Max")
print(sm)

#b
minPrice <- which.min(tsla$Close)
print(sprintf("The minimum Tesla value of %d is at row %d on %s", tsla$Close[minPrice], minPrice, tsla$Date[minPrice]))

#c
maxPrice <- which.max(tsla$Close)
print(sprintf("The maximum Tesla value of %d is at row %d on %s", tsla$Close[maxPrice], maxPrice, tsla$Date[maxPrice]))


#d-g
totalRow <- nrow(tsla)
#d
sumProfit <- sum((tsla$Close - tsla$Open) > 0, na.rm = TRUE)
Prob_profit <- sumProfit / totalRow
print(Prob_profit)

#e
sumGreater100m <- sum(tsla$Volume > 100000000, na.rm = TRUE)
prob_greater100m <- sumGreater100m / totalRow
print(prob_greater100m)

#f
sumProfitandGreater100m  <- sum((tsla$Close - tsla$Open) > 0 & tsla$Volume > 100000000, na.rm = TRUE)
prob_profitandgreater100m <- sumProfitandGreater100m / totalRow
print(prob_profitandgreater100m)

#g
lastDayClosePrice <- tail(tsla$Close,1)
buyinPrice <- which.min(tsla$Close)
profit <- lastDayClosePrice - buyinPrice
print(sprintf("If I bought in 1 share of Tesla stock on the day of the lowest price %d, and sold out on the last day, which price is equal to %d, I can gain for %d", buyinPrice, lastDayClosePrice, profit))