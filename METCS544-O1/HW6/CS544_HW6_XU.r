library(stringr)#for part 1

#part1
file <- "https://people.bu.edu/kalathur/datasets/mlk.txt"
#a
words <- scan(file, what=character())
punct_words <- words[str_detect(words, "[[:punct:]]")]
punct_words
#b
new_words <- str_replace_all(words, "[[:punct:]]", "") %>% tolower()
new_words
#c
stopfile <- "https://people.bu.edu/kalathur/datasets/stopwords.txt"
stopwords <- scan(stopfile, what=character())
new_words_clean <- new_words[!(new_words %in% stopwords)]
freq_words_clean <- table(new_words_clean)
top_words_clean <- sort(freq_words_clean, decreasing = TRUE)[1:5]
top_words_clean
#d
word_lengths_clean <- str_length(new_words_clean)
freq_lengths_clean <- table(word_lengths_clean)
barplot(freq_lengths_clean, main = "Frequency of word lengths in new_words_clean", xlab = "Word length", ylab = "Frequency")
#e
longest_words <- new_words[which.max(nchar(new_words))]
longest_words
#f
c_words <- str_subset(new_words, "^c")
c_words
#g
r_words <- str_subset(new_words, "r$")
r_words
#h
cr_words <- str_subset(new_words, "^c.*r$")
cr_words

#part2
library(tidyverse)


df <- read.csv("http://people.bu.edu/kalathur/usa_daily_avg_temps.csv")
#a
usaDailyTemps <-as_tibble(df)
usaDailyTemps
#b
max_temp_yr <- usaDailyTemps %>% group_by(year) %>% summarise(max = max(avgtemp))
max_temp_yr
ggplot(data = max_temp_yr, aes(x=year, y=max, group=1))+
  geom_line()+
  geom_point()+ggtitle("plot of maximum temperatures recorded for each year")+
  scale_x_continuous(breaks = (seq(min(max_temp_yr$year), max(max_temp_yr$year), by = 1)))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#c
max_temp_state <- usaDailyTemps %>% group_by(state) %>% summarise(max = max(avgtemp))
max_temp_state
ggplot(data = max_temp_state, aes(x=state, y=max, group=1))+ 
  geom_bar(stat = 'identity')+  
  ggtitle("plot of maximum temperatures recorded for each state")+ 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#d
bostonDailyTemps <- filter(usaDailyTemps, city == 'Boston')
bostonDailyTemps
#e
avg_temp_mon <- bostonDailyTemps %>% group_by(month) %>% summarise(average_temp = mean(avgtemp))
avg_temp_mon
ggplot(data = avg_temp_mon, aes(x=month, y=average_temp, group=1))+
  geom_line()+
  ggtitle("plot of average monthly temperatures for Boston")+
  scale_x_continuous(breaks = (seq(min(avg_temp_mon$month), max(avg_temp_mon$month), by = 1)))