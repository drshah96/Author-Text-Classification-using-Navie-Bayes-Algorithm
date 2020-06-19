###### AUTHOR TEXT CLASSIFICATION #######
##### Word Cloud #####

if(!require(wordcloud)) install.packages("wordcloud")
library(wordcloud)

wordcloud(Data_test_corpus_clean, min.freq = 40, random.order = FALSE)
wordcloud(Data_train_corpus_clean, min.freq = 40, random.order = FALSE)
