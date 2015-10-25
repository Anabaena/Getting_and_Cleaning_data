---
title: "GetClData_Prog"
author: "Joelle Jansen"
date: "25 October 2015"
output: html_document
---

## Project Description
This repo was created as my results for the Course Project of Getting and Cleaning Data on Coursera.
The project requires you to merge and clean the given accelerometer data and then create a summary table that gives you the average for every variable, for every subject doing a specific activity.

The raw data is based on data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Study design and data processing
### Collection of the raw data
The raw data was collected from the coursera project website on October 24th 2015.
Original link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

All files in this folder were used except for the files in the Inertial Signals folders.

## Creating the tidy datafile
### Guide to create the tidy data file
1. Download data to R working directory
2. Run run_analysis.R
3. Result is written to tidy_data.txt

Note that the R script requires the dplyr package.

### Processing of the data
1. First the script reads the appropriate files into their respective variables (features.txt, activity\_labels.txt, x\_train.txt, y\_train.txt, subject\_train.txt, x\_test.txt, y\_test.txt and subject\_test.txt).
In this step it also adds the header names. For x\_test and x\_train the column names are extract from the features.txt. The y\_test and y\_train columns are named "activity" and the subject\_test and subject\_train columns are names "subject\_ID".
2. From the x\_test and x\_train tables the columns with mean() or std() in the name (only exact matches) are extracted and written to selected\_x\_test and selected\_x\_train.
3. Using cbind() the test and train datasets(selected\_x, y and subject) are merged into test and train tables.Subsequently the merged dataset is created by using rbind() on the test and train tables. This possible because the test and train dataset deal with different individuals and thus have different subject\_IDs.
4. Then the activity labels are converted to descriptive activity names. This was done according to the names in the activity_labels file.
5. The merged dataset is grouped by subject\_ID and activity and then the mean is calculated for each variable for each group. The resulting means are written to tidy\_data.txt

## Description of the variables in the tidy_data.txt file
The tidy dataset represents 68 variables, with 180 observations. The table shows the mean of 66 variables for a specific indidual ("subject_ID") and a specific activity ("activity").

The first two variables represent subject\_ID and activity. There are 30 individuals in total, doing 6 separate activities (creating the 180 observations).
The rest of the variables are represented in the tidy_data.txt twice because one column writes the mean (denoted by 'mean()'), while another writes the standard deviation (denoted by 'std()'). '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

These variables are averaged from the raw data based on the subject_ID and the activity.