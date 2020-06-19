###### AUTHOR TEXT CLASSIFICATION #######
##### Data Collection #####

if(!file.exists("Data/C50.zip")){
        #Downloading File
        download.file(url = "http://archive.ics.uci.edu/ml//machine-learning-databases/00217/C50.zip",
                      destfile = "Data/C50.zip")
        
        #Unzipping the File
        unzip("Data/C50.zip", exdir = "Data/C50")
}

#Data Extraction
if(!require(readtext)) install.packages("readtext")
library(readtext)

data_train_dir <- system.file("Data/C50/C50train/")
#data_dir <- system.file("Data/C50/C50train/")
#readtext(paste0(data_dir, "Data/C50/C50train/*"))
Data_train <- readtext(paste0(data_train_dir, "Data/C50/C50train/*"),
                       dvsep = "\n")
head(Data_train$text, n = 1)

#Data <- readtext(paste0(data_train_dir, "Data/C50/C50train/AaronPressman/*"),
#                       dvsep = "\n")
#head(Data_train$text, n = 1)

data_test_dir <- system.file("Data/C50/C50test/")
#data_dir <- system.file("Data/C50/C50train/")
#readtext(paste0(data_dir, "Data/C50/C50train/*"))
Data_test <- readtext(paste0(data_test_dir, "Data/C50/C50test/*"),
                      dvsep = "\n")


Authornames <- as.data.frame(rep(basename(list.dirs("Data/C50/C50train")), each = 50))
Authornames <- Authornames[-(1:50),]

Data_test$Author <- Authornames
Data_train$Author <- Authornames

#Dropping ID Column
Data_test <- Data_test[-1]
Data_train <- Data_train[-1]

#Converting Author Column to Factor
Data_test$Author <- as.factor(Data_test$Author)
Data_train$Author <- as.factor(Data_train$Author)

#Dimension
dim(Data_test)
dim(Data_train)

#Structure
str(Data_test)
str(Data_train)

#data <- subset(Data_train, Author == c("AaronPressman", "JaneMacartney", "SarahDavison"))

#Filtering Data by 4 Authors
library(dplyr)
library(data.table)
AaronTrain <- Data_train %>% filter(Author == "AaronPressman", text == text)
JaneTrain <- Data_train %>% filter(Author == "JaneMacartney", text == text)
SarahTrain <- Data_train %>% filter(Author == "SarahDavison", text == text)
WilliamTrain <- Data_train %>% filter(Author == "WilliamKazer", text == text)
Data_train <- rbind(AaronTrain, JaneTrain, SarahTrain, WilliamTrain)


AaronTest <- Data_test %>% filter(Author == "AaronPressman", text == text)
JaneTest <- Data_test %>% filter(Author == "JaneMacartney", text == text)
SarahTest <- Data_test %>% filter(Author == "SarahDavison", text == text)
WilliamTest <- Data_test %>% filter(Author == "WilliamKazer", text == text)
Data_test <- rbind(AaronTest, JaneTest, SarahTest, WilliamTest)

#New Data
dim(Data_test)
dim(Data_train)

table(Data_train$Author)
