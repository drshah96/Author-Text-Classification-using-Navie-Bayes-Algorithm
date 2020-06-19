###### AUTHOR TEXT CLASSIFICATION #######
##### Main File #####

#Loading Data Collection File
source("Data Collection.R")

#Loading Data Processing File
source("Data Processing.R")

#Generating Word Cloud
if(!require(wordcloud)) install.packages("wordcloud")
library(wordcloud)

wordcloud(Data_test_corpus_clean, min.freq = 40, random.order = FALSE)
wordcloud(Data_train_corpus_clean, min.freq = 40, random.order = FALSE)

#Loading Model Performance File
source("Model Performance.R")

#Evaluating performance
library(gmodels)
#Model 1
CrossTable(data_test_pred, Data_test$Author,
           prop.chisq = FALSE, prop.t = FALSE,
           dnn = c('predicted', 'actual'))

#Model 2
CrossTable(data_test_pred2, Data_test$Author,
           prop.chisq = FALSE, prop.t = FALSE,
           dnn = c('predicted', 'actual'))
