###### AUTHOR TEXT CLASSIFICATION #######
##### Exploratory Data Analysis #####

source("Data Collection.R")

#Data Preparation
if(!require(tm)) install.packages("tm")
library(tm)

#Creating Corpus
Data_test_corpus <- Corpus(VectorSource(Data_test$text))
Data_train_corpus <- Corpus(VectorSource(Data_train$text))

print(Data_test_corpus)
inspect(Data_test_corpus[1])

#Corpus Cleaning
Data_test_corpus_clean <- tm_map(Data_test_corpus, tolower)
Data_train_corpus_clean <- tm_map(Data_train_corpus, tolower)

Data_test_corpus_clean <- tm_map(Data_test_corpus_clean, removeNumbers)
Data_train_corpus_clean <- tm_map(Data_train_corpus_clean, removeNumbers)

Data_test_corpus_clean <- tm_map(Data_test_corpus_clean, removeWords, stopwords())
Data_train_corpus_clean <- tm_map(Data_train_corpus_clean, removeWords, stopwords())

Data_test_corpus_clean <- tm_map(Data_test_corpus_clean, removePunctuation)
Data_train_corpus_clean <- tm_map(Data_train_corpus_clean, removePunctuation)

Data_test_corpus_clean <- tm_map(Data_test_corpus_clean, stripWhitespace)
Data_train_corpus_clean <- tm_map(Data_train_corpus_clean, stripWhitespace)

inspect(Data_train_corpus_clean[1])

test_dtm <- DocumentTermMatrix(Data_test_corpus_clean)
train_dtm <- DocumentTermMatrix(Data_train_corpus_clean)

inspect(train_dtm)


