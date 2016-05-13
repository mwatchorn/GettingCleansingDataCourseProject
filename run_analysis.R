setwd("G:\\gc_project")
library(plyr)

observations_ref <- read.csv("features.txt", header = FALSE, sep = "")
activity_labels_ref <- read.csv("activity_labels.txt", header = FALSE, sep = "", col.names = c('Activity_key', 'Activity'))

# Prep test data

testdata <- read.csv("test/X_test.txt", header = FALSE, sep = "")
colnames (testdata) <- observations_ref[,2]
testmean <- subset(testdata, select = grepl("mean\\(\\)", names(testdata)))
teststd <- subset(testdata, select = grepl("std\\(\\)", names(testdata)))
targettestdata <- cbind (testmean, teststd)

activity_index <- read.csv ("test/y_test.txt", header = FALSE, sep = "", col.names = c('Activity_key'))
activity_key <- join(activity_index, activity_labels_ref)
targettestdata <- cbind (activity_key, targettestdata)

subject_key <- read.csv("test/subject_test.txt", header = FALSE, sep = "", col.names = c('Subject'))
testdata_withkey <- cbind (subject_key, targettestdata)

# Prep train data

traindata <- read.csv("train/X_train.txt", header = FALSE, sep = "")
colnames (traindata) <- observations_ref[,2]
trainmean <- subset(traindata, select = grepl("mean\\(\\)", names(traindata)))
trainstd <- subset(traindata, select = grepl("std\\(\\)", names(traindata)))
targettraindata <- cbind(trainmean, trainstd)

activity_index <- read.csv ("train/y_train.txt", header = FALSE, sep = "", col.names = c('Activity_key'))
activity_key <- join(activity_index, activity_labels_ref)
targettraindata <- cbind (activity_key, targettraindata)

subject_key <- read.csv("train/subject_train.txt", header = FALSE, sep = "", col.names = c('Subject'))
traindata_withkey <- cbind (subject_key, targettraindata)

# Merge test and train dataframes

compdata <- rbind (testdata_withkey, traindata_withkey)
compdata_s <- compdata[order(compdata$Subject, compdata$Activity_key, na.last=TRUE),]

# Capture the mean for each feature column, grouping by Subject, Activity_key, and Activity

compdata_summary <- aggregate(compdata_s[, 4:ncol(compdata_s)], list(compdata_s$Subject, compdata_s$Activity_key, compdata_s$Activity), mean)
colnames (compdata_summary)[1:3] <- colnames (compdata_s)[1:3]
compdata_summary <- compdata_summary[order(compdata_summary$Subject, compdata_summary$Activity_key, na.last=TRUE),]
row.names(compdata_summary) <- 1:nrow(compdata_summary)

write.table(format (compdata_summary, digits=7), file = "tidydata.txt", sep = "\t", quote = FALSE, row.names=FALSE)