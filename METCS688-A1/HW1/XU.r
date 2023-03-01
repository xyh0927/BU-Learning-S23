library(tm)
library(class)
library(dplyr) 

# set the paths to the data
data_path <- system.file("text", package = "tm")
data_path <- file.path("tm","text")
train_dir <- file.path(data_path, "20news-bydate-train")
test_dir <- file.path(data_path, "20news-bydate-test")

# define the subjects to analyze
subjects <- c("sci.space", "rec.autos")

# get 100 documents from each subject for training and testing
train_docs <- lapply(subjects, function(subj){
  train_subj_dir <- file.path(train_dir, subj)
  train_subj_files <- sample(list.files(train_subj_dir, full.names = TRUE), 100)
  train_subj_docs <- lapply(train_subj_files, function(file){
    readLines(file) %>% paste(collapse = " ")
  })
  return(train_subj_docs)
})

test_docs <- lapply(subjects, function(subj){
  test_subj_dir <- file.path(test_dir, subj)
  test_subj_files <- sample(list.files(test_subj_dir, full.names = TRUE), 100)
  test_subj_docs <- lapply(test_subj_files, function(file){
    readLines(file) %>% paste(collapse = " ")
  })
  return(test_subj_docs)
})

# combine the train and test docs for each subject into a single corpus
corpus <- Corpus(VectorSource(c(train_docs[[1]], test_docs[[1]], train_docs[[2]], test_docs[[2]])))
tags <- c(rep("Negative", 100), rep("Positive", 100), rep("Positive", 100), rep("Negative", 100))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stemDocument)

# create the document-term matrix
dtm <- DocumentTermMatrix(corpus, control=list(wordLengths=c(2,Inf), bounds=list(global=c(5,Inf))))
dtm_train <- dtm[c(1:100, 201:300),]
dtm_test <- dtm[c(101:200, 301:400),]

# split the tags into train and test sets
tags_train <- tags[c(1:100, 201:300)]
tags_test <- tags[c(101:200, 301:400)]

# classify using kNN
k <- 7
pred <- knn(dtm_train, dtm_test, cl = tags_train, k = k)

# calculate the percentage of correct classifications
correct <- pred == tags_test
correct_pct <- sum(correct) / length(correct)

# create the results data frame
results <- data.frame(Doc = 1:200, Predict = pred, Prob = NA, Correct = correct)

# calculate precision, recall, and F-score
TP <- sum(pred == "Positive" & tags_test == "Positive")
TN <- sum(pred == "Negative" & tags_test == "Negative")
FP <- sum(pred == "Positive" & tags_test == "Negative")
FN <- sum(pred == "Negative" & tags_test == "Positive")

precision <- TP / (TP + FP)
recall <- TP / (TP + FN)
f_score <- 2 * precision * recall / (precision + recall)

cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F-score:", f_score)
    