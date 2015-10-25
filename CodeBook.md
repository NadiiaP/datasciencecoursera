---
title: "CodeBook.md"
author: "Nadiia P."
date: "Sunday, October 25, 2015"
output: html_document
---

Describing of the variables and data.
-------------------------------------

<p>Subject - subjects who performed the activity</p>
<p>Subject_test - subjects in test set</p>
<p>Subject_train - subjects in train set</p>
<p>X - measuring signals and variables that were estimated from these signals</p>
<p>Xtest -  measuring signals and variables that were estimated from these signals from test set</p>
<p>Xtrain - measuring signals and variables that were estimated from these signals from train set</p>
<p>Y - features labels</p>
<p>Ytest - features labels from test set</p>
<p>Ytrain - features labels fron train set</p>
<p>data - mean and standart deviation of variables with features labels and subjects</p>
<p>dataX - logical vector identifies mean and standart deviation variables in features</p>
<p>dataXY - mean and standart deviation of variables with features labels</p>
<p>features - list of all features</p>
<p>l - average of each variable (mean and standart deviation) for each activity and each subject</p>
<p>labels - activity labels</p>
<p>mean - logical vector identifies mean  variables in features</p>
<p>std - logical vector identifies standart deviation variables in features</p>

Describing of cleaning the data.
--------------------------------

To merge the training and the test sets using library data.table. And read data with read.table(). Assign it to relevant variables then binding them by rows.

```{r}
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
```

For extract the measurements on the mean and standard deviation for each measurement read document with features by data.table() using stringsAsFactors = F. 

```{r}
features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)
```

Then loading library stringr and find mean and standart deviation  in features by str_detect() which detects patterns "mean" and "std" in given strings. Got logical vectors mean and std and bind them by columns.

```{r}
library(stringr)
mean<-str_detect(features[,2], "mean")
std<-str_detect(features[,2], "std")
dataX<-cbind(X[mean],X[std])
```

Read and attach the descriptive activity names as factor variable using lapply() and factor() to name the activities in the data set by cbind().

```{r}
labels<-read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
Y<-lapply(Y, factor, levels=labels[[1]], labels=labels[[2]])
dataXY<-cbind(Y,dataX)
```

Label the data set with descriptive variable names contained in features.

``` {r}
names(dataXY)<-c("activity", features[,2][mean], features[,2][std])
```

Bind  by column subject to dataset. And create data set with the average of each variable for each activity and each subject by aggregate() with FUN = mean.

```{r}
data<-cbind(Subject, dataXY)
names(data)[1]<-"Subject"
l<-aggregate(data[3:length(data)], by = list(data[[1]], data[[2]]), FUN = mean)
```
