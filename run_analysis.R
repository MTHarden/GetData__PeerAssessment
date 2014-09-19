##Acquire and Unzip data
temp <- tempfile()
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = temp, mode = "wb")
unzip(temp)
unlink(temp)
## Set Data Directory
DataDir <- "./UCI HAR Dataset/"

## load Libraries
library(dplyr)

## get the fnames
FNames <- read.table(paste0(DataDir,"features.txt"), col.names = c("featurenr","featurename"))
ALabels <- read.table(paste0(DataDir,"activity_labels.txt"), col.names = c("activitynr", "label"))

## combine test data into one data frame
test_subject <-  read.table(paste0(DataDir,"test/subject_test.txt"), col.names = "subject")
test_activity <- read.table(paste0(DataDir,"test/y_test.txt"), col.names = "activity")
testdata <- read.table(paste0(DataDir,"test/X_test.txt"), col.names = FNames$featurename)
TestFile <- cbind(test_subject, test_activity, testdata)

## combine train data into one data frame
train_subject <-  read.table(paste0(DataDir,"train/subject_train.txt"), col.names = "subject")
train_activity <- read.table(paste0(DataDir,"train/y_train.txt"), col.names = "activity")
traindata <- read.table(paste0(DataDir,"train/X_train.txt"), col.names = FNames$featurename)
TrainFile <- cbind(train_subject, train_activity, traindata)

## combine test and train dataframes
tData <- rbind(TestFile, TrainFile)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
meanStdNames <- grep("Mean|mean|Std|std", names(tData))
data <- tData[,c(1,2,meanStdNames)]

## Uses descriptive activity names to name the activities in the data set
activities <- sapply(data$activity, function(x) ALabels[x,"label"])

## clean up labels, i.e., lowercase, no dots or parenthesis.
names(data) <- gsub("[.]|[(]|[)]", "", names(data)) %>% 
        tolower

## Group by subject, group by activity, take mean for each var in these groups
tidydata <- group_by(data, subject, activity) %>%
        summarise_each(funs(mean))
## The tidy data as textfile
write.table(tidydata, file = "tidytext.txt", row.names = FALSE)