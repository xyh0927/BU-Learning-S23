# Load the required library
library(tm)

#for my own test
#load("C:/Users/33351/Desktop/github/688hw3/NewsGroup_Dtm.RData")

# Load the NewsGroup_Dtm.RData file
load("Data/NewsGroup_Dtm.RData")

# Convert the Document Term Matrix to a data frame
word_freqs <- as.data.frame(as.matrix(dtm))

# Calculate word frequencies
word_freqs$total <- rowSums(word_freqs)
word_freqs$total

# Sort words by frequency
word_freqs_sorted <- word_freqs[order(-word_freqs$total),]
word_freqs_sorted

# Add a rank column
word_freqs_sorted$rank <- 1:nrow(word_freqs_sorted)
word_freqs_sorted$rank

# Calculate the natural logarithm of the frequency and rank
word_freqs_sorted$log_freq <- log(word_freqs_sorted$total)
word_freqs_sorted$log_freq
word_freqs_sorted$log_rank <- log(word_freqs_sorted$rank)
word_freqs_sorted$log_rank

# Create the linear model
model <- lm(log_freq ~ log_rank, data = word_freqs_sorted)
model

# 1. Plot Percentage of all words vs unique words
word_freqs_sorted$percentage <- word_freqs_sorted$total / sum(word_freqs_sorted$total) * 100
word_freqs_sorted$cumulative_percentage <- cumsum(word_freqs_sorted$percentage)

plot(word_freqs_sorted$rank, word_freqs_sorted$percentage, xlab = "Rank", ylab = "Percentage", main = "Percentage of all words vs unique words")

# Calculate the percentage of single words
single_word_percentage <- sum(word_freqs_sorted$total == 1) / nrow(word_freqs_sorted) * 100
cat("Percentage of single words (Percent of Words appearing only once):", single_word_percentage, "\n")

# 2. Check if half of any text is 50 to 100 same words
plot(word_freqs_sorted$rank[1:100], word_freqs_sorted$cumulative_percentage[1:100], xlab = "Top 100 Words Rank", ylab = "Cumulative Percentage", main = "Cumulative Percent vs the 100 most frequent words")

# 3. Predictive Task
military_rank <- word_freqs_sorted$rank[word_freqs_sorted$military]
military_actual_frequency <- word_freqs_sorted$total[word_freqs_sorted$military]
military_actual_frequency
military_predicted_frequency <- exp(predict(model, newdata = data.frame(log_rank = log(military_rank))))
military_predicted_frequency
difference <- round(abs(military_actual_frequency - military_predicted_frequency), 2)
difference

cat("Actual frequency of 'military':", military_actual_frequency, "\n")
cat("Predicted frequency of 'military':", military_predicted_frequency, "\n")
cat("Difference between actual and predicted frequency of 'military':", difference, "\n")
