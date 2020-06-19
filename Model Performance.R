###### AUTHOR TEXT CLASSIFICATION #######
##### Model Performance #####

#Naive Bayes
if(!require(e1071)) install.packages("e1071")
library(e1071)
data_classifier <- naiveBayes(data_train, Data_train$Author)

#### Evaluating Model Performance
data_test_pred <- predict(data_classifier, data_test)


##### Improving Model Performance 
data_classifier2 <- naiveBayes(data_train, Data_train$Author,laplace = 1)
data_test_pred2 <- predict(data_classifier2, data_test)