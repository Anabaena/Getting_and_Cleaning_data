## Getting and Cleaning Data Programming Assignment
##
## This script takes the raw accelerometer data, merges and 
## cleans it and turns it into a tidy table that reports the 
## averages for each variable, for each subject doing a particular 
## activity.
##
## Author: Joelle Jansen
##
## Note: THis script requires dplyr, please make sure this is installed

## Import libraries
library(dplyr)

## Import column names
features <- read.table("UCI HAR Dataset/features.txt")

## Import training files and add their colnames
subject_train <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
colnames(subject_train) <- "subject_ID"
y_train <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt"))
colnames(y_train) <- "activity"
x_train <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt"))
colnames(x_train) <- features[,2]

## Import testing files and add their colnames
subject_test <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
colnames(subject_test) <- "subject_ID"
y_test <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt"))
colnames(y_test) <- "activity"
x_test <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt"))
colnames(x_test) <- features[,2]

## Select only the mean and std columns of the x datasets
selectedcols <- sort(c(grep("\\bmean()\\b", names(x_test)), 
                       grep("\\bstd()\\b", names(x_test))))
selected_x_train <- x_train[,selectedcols]
selected_x_test <- x_test[,selectedcols]

## Merge y_train and subject_train with x_train. Then merge
## y_test and subject_test with x_test.
train <- cbind(subject_train, y_train, selected_x_train)
test <- cbind(subject_test, y_test, selected_x_test)

## Merge the test and train dataset
merged <- rbind(train, test)

## Convert acitivity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
merged$activity[merged$activity == 1] <- as.character(activity_labels[1,2])
merged$activity[merged$activity == 2] <- as.character(activity_labels[2,2])
merged$activity[merged$activity == 3] <- as.character(activity_labels[3,2])
merged$activity[merged$activity == 4] <- as.character(activity_labels[4,2])
merged$activity[merged$activity == 5] <- as.character(activity_labels[5,2])
merged$activity[merged$activity == 6] <- as.character(activity_labels[6,2])

## Group merged dataset by subject_ID and activity
grouped <- group_by(merged, subject_ID, activity)

## Calculate the averages of every variable for every group
## And write the resulting table to a file called tidy_data.txt
write.table(summarise_each(grouped, funs(mean)), "tidy_data.txt", row.name = FALSE)