
#1. Merges the training and the test sets to create one data set.
library(data.table)

Xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
Xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
X<-rbind(Xtest,Xtrain)

Ytest<-read.table("UCI HAR Dataset/test/Y_test.txt")
Ytrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
Y<-rbind(Ytest,Ytrain)

Subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
Subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
Subject<-rbind(Subject_test, Subject_train)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)
library(stringr)
mean<-str_detect(features[,2], "mean")
std<-str_detect(features[,2], "std")
dataX<-cbind(X[mean],X[std])

#3.Uses descriptive activity names to name the activities in the data set 
labels<-read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
Y<-lapply(Y, factor, levels=labels[[1]], labels=labels[[2]])
dataXY<-cbind(Y,dataX)

# 4. Appropriately labels the data set with descriptive variable names. 
names(dataXY)<-c("activity", features[,2][mean], features[,2][std])

# 5.From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
data<-cbind(Subject, dataXY)
names(data)[1]<-"Subject"
l<-aggregate(data[3:length(data)], by = list(data[[1]], data[[2]]), FUN = mean)
