---
title: "README.md"
author: "Nadiia P."
date: "Sunday, October 25, 2015"
output: html_document
---


File named run_analisys.R reads data from file "UCI HAR Dataset". Merges the training and the test sets 
"UCI HAR Dataset/test/X_test.txt"
"UCI HAR Dataset/train/X_train.txt"
"UCI HAR Dataset/test/Y_test.txt"
"UCI HAR Dataset/train/Y_train.txt"
"UCI HAR Dataset/test/subject_test.txt"
"UCI HAR Dataset/train/subject_train.txt"
to one dataset. 
Extracts the measurements on the mean and standard deviation for each measurement by names in "UCI HAR Dataset/features.txt". 
Uses descriptive activity names to name the activities in the data set and makes labels to them from "UCI HAR Dataset/activity_labels.txt".
Appropriately labels the data set with descriptive variable names. 
Creates tidy data set with the average of each variable for each activity and each subject.