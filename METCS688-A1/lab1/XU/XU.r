getwd()
setwd('/home/xuyuhan/Desktop/BU-learn-S2023/METCS688A1/lab1/XU/Data')
# Read the data from the geoMap.csv file
geo_data <- read.csv("geoMap.csv", header = TRUE,skip = 2)
geo_data 

#Q1: Which are the states where GG is smaller than 1? Find those and replace them with zero.
geo_data$Region[geo_data$gift.for.girlfriend...2.14.13...2.14.18. < 1]
geo_data$gift.for.girlfriend...2.14.13...2.14.18.[geo_data$gift.for.girlfriend...2.14.13...2.14.18. < 1] <- 0
geo_data$gift.for.girlfriend...2.14.13...2.14.18.

# Q2: For How Many States GB > GG?
num_states_GB_GT_GG <- sum(geo_data$gift.for.boyfriend...2.14.13...2.14.18. > geo_data$gift.for.girlfriend...2.14.13...2.14.18.)
cat("Number of states where GB > GG:", num_states_GB_GT_GG, "\n")

# Q3: Find any states where GG+10 > GB
states_GG10_GT_GB <- geo_data$Region[as.numeric(geo_data$gift.for.girlfriend...2.14.13...2.14.18. )+ 10 > as.numeric(geo_data$gift.for.boyfriend...2.14.13...2.14.18.)]
if (length(states_GG10_GT_GB) > 0) {
  cat("States where GG+10 > GB:", paste(states_GG10_GT_GB, collapse = ", "), "\n")
} else {
  cat("No states where GG+10 > GB\n")
}

# Q4: What is the % of states for which GG+10 > GB?
percent_states_GG10_GT_GB <- 100 * length(states_GG10_GT_GB) / nrow(geo_data)
cat("Percentage of states where GG+10 > GB:", percent_states_GG10_GT_GB, "%\n")

# Q5: What is the ratio GG/GB for the state of New Hampshire? 
ratio_NH_GG_GB <- as.numeric(geo_data$gift.for.girlfriend[geo_data$Region == "New Hampshire"]) / as.numeric(geo_data$gift.for.boyfriend[geo_data$Region == "New Hampshire"])
cat("Ratio GG/GB for New Hampshire:", ratio_NH_GG_GB, "\n")

# Q6: Create a Bar Plot of GG & GB values for each state.
barplot(as.numeric(as.matrix(geo_data[, 2:3])), beside = TRUE, col = c("red", "blue"), 
        main = "Interest in Gift for Boyfriend vs Girlfriend by State", 
        xlab = "State", ylab = "Interest", ylim = c(0, 110))
legend("topright", c("Gift for Girlfriend", "Gift for Boyfriend"), fill = c("red", "blue"), 
       cex = 0.8, inset = 0.05)
