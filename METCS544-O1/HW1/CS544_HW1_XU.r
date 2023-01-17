#Q1
scores <- c(40, 88, 60, 23, 76, 51, 59, 99, 96, 34)
n <- length(scores)
print(n)

first_and_second <- scores[1:2]
print(first_and_second)

first_and_last <- scores[c(1, n)]
print(first_and_last)

middle_two <- scores[c(n/2, n/2+1)]
print(middle_two)


#Q2
avg_score <- mean(scores)
print(avg_score)

below_avg <- scores <= avg_score
print(below_avg)

above_avg <- scores > avg_score
print(above_avg)

count_below_avg <- sum(below_avg)
print(count_below_avg)

count_above_avg <- sum(above_avg)
print(count_above_avg)


#Q3
scores_below_avg <- scores[scores <= avg_score]
print(scores_below_avg)

scores_above_avg <- scores[scores > avg_score]
print(scores_above_avg)


#Q4
odd_index_values <- scores[seq(1, n, by=2)]
print(odd_index_values)

even_index_values <- scores[seq(2, n, by=2)]
print(even_index_values)


#Q5a
format_scores_version1 <- paste(LETTERS[1:10], scores, sep = "=")
print(format_scores_version1)

#Q5b
format_scores_version2 <- paste(LETTERS[10:1], scores, sep = "=")
print(format_scores_version2)


#Q6a
scores_matrix <- matrix(scores, nrow = 2, ncol = n/2, byrow = TRUE)
print(scores_matrix)

#Q6b
first_and_last_version1 <- matrix(c(scores_matrix[,1], scores_matrix[,ncol(scores_matrix)]), nrow = nrow(scores_matrix))
print(first_and_last_version1)


#Q7a
named_matrix <- scores_matrix
colnames(named_matrix) <- paste("Student_", 1: ncol(named_matrix), sep = "")
rownames(named_matrix) <- paste("Quiz_", 1: nrow(named_matrix), sep = "")
print(named_matrix)

#Q7b
first_and_last_version2 <- named_matrix[, c(1, ncol(named_matrix))]
print(first_and_last_version2)