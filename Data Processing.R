###### AUTHOR TEXT CLASSIFICATION #######
##### Exploratory Data Analysis #####

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

### Creating Indicator features for frequent words ###
FreqWords <- findFreqTerms(train_dtm, 5)

#Saving List using Dictionary() Function
Dictionary <- function(x) {
        if( is.character(x) ) {
                return (x)
        }
        stop('x is not a character vector')
}

data_dict <- Dictionary(findFreqTerms(train_dtm, 5))

#Appending Document Term Matrix to Train and Test Dataset 
data_train <- DocumentTermMatrix(Data_train_corpus_clean, list(data_dict))
data_test <- DocumentTermMatrix(Data_test_corpus_clean, list(data_dict))

#Converting the frequency of word to count
convert_counts <- function(x) {
        x <- ifelse(x > 0, 1, 0)
        x <- factor(x, levels = c(0, 1), labels = c("No", "Yes")) 
        return(x)
}

#Appending count function to Train and Test Dataset
data_train <- apply(data_train, MARGIN = 2, convert_counts)
data_test <- apply(data_test, MARGIN = 2, convert_counts)
