
## download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip")

## Extract the information which will be used; data for tboth sets, features, activity labels and subject identifiers

featureList <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/features.txt"),header=FALSE,sep="")
activityList <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/activity_labels.txt"),header=FALSE,sep="")
trainLabels <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/train/y_train.txt"),header=FALSE,sep="")
trainData <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/train/X_train.txt"),header=FALSE,sep="")
testLabels <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/test/y_test.txt"),header=FALSE,sep="")
testData <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/test/X_test.txt"),header=FALSE,sep="")
subjectTrain <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/train/subject_train.txt"),header=FALSE,sep="")
subjectTest <- read.csv(unzip("Dataset.zip","UCI HAR Dataset/test/subject_test.txt"),header=FALSE,sep="")

## to both the test and train data frames, add the names to the columns, coming from the feature list

featureVec <- as.vector(featureList[,2])

names(testData) <- featureVec
names(trainData) <- featureVec
 
## combine the two data frames into one

allData <- rbind(trainData,testData)

## find which variables correspond to means and standard deviations

meanMeas <- which(grepl("mean",featureVec))
stdMeas <- which(grepl("std",featureVec))

## provide cleaner names for the variables

meanLabels <- c("tBodyAcc-mean-X"          ,     "tBodyAcc-mean-Y"     ,          "tBodyAcc-mean-Z"     ,          "tGravityAcc-mean-X"   ,        
 "tGravityAcc-mean-Y"       ,     "tGravityAcc-mean-Z"  ,          "tBodyAccJerk-mean-X" ,          "tBodyAccJerk-mean-Y"  ,        
 "tBodyAccJerk-mean-Z"       ,    "tBodyGyro-mean-X"     ,         "tBodyGyro-mean-Y"     ,         "tBodyGyro-mean-Z"      ,       
 "tBodyGyroJerk-mean-X"       ,   "tBodyGyroJerk-mean-Y"  ,        "tBodyGyroJerk-mean-Z"  ,        "tBodyAccMag-mean"       ,      
 "tGravityAccMag-mean"  ,         "tBodyAccJerkMag-mean"   ,       "tBodyGyroMag-mean"      ,       "tBodyGyroJerkMag-mean"   ,     
 "fBodyAcc-mean-X"       ,        "fBodyAcc-mean-Y"         ,      "fBodyAcc-mean-Z"         ,      "fBodyAcc-meanFreq-X"      ,    
 "fBodyAcc-meanFreq-Y"    ,       "fBodyAcc-meanFreq-Z"      ,     "fBodyAccJerk-mean-X"      ,     "fBodyAccJerk-mean-Y"       ,   
 "fBodyAccJerk-mean-Z"     ,      "fBodyAccJerk-meanFreq-X"   ,    "fBodyAccJerk-meanFreq-Y"   ,    "fBodyAccJerk-meanFreq-Z"    ,  
 "fBodyGyro-mean-X"         ,     "fBodyGyro-mean-Y"           ,   "fBodyGyro-mean-Z"           ,   "fBodyGyro-meanFreq-X"  ,       
 "fBodyGyro-meanFreq-Y"      ,    "fBodyGyro-meanFreq-Z"        ,  "fBodyAccMag-mean"            ,  "fBodyAccMag-meanFreq"   , "fBodyAccJerkMag-mean"  ,    "fBodyAccJerkMag-meanFreq" , "fBodyGyroMag-mean"     ,    "fBodyGyroMag-meanFreq"   , "fBodyGyroJerkMag-mean"   ,  "fBodyGyroJerkMag-meanFreq")


stdLabels <- c("tBodyAcc-std-X"      ,     "tBodyAcc-std-Y"     ,      "tBodyAcc-std-Z"     ,      "tGravityAcc-std-X" ,       "tGravityAcc-std-Y" ,       "tGravityAcc-std-Z" ,      
 "tBodyAccJerk-std-X"  ,     "tBodyAccJerk-std-Y" ,      "tBodyAccJerk-std-Z" ,      "tBodyGyro-std-X"   ,       "tBodyGyro-std-Y"   ,       "tBodyGyro-std-Z"    ,     
 "tBodyGyroJerk-std-X"  ,    "tBodyGyroJerk-std-Y" ,     "tBodyGyroJerk-std-Z" ,     "tBodyAccMag-std"    ,      "tGravityAccMag-std" ,      "tBodyAccJerkMag-std" ,    
 "tBodyGyroMag-std"      ,   "tBodyGyroJerkMag-std" ,    "fBodyAcc-std-X"       ,    "fBodyAcc-std-Y"      ,     "fBodyAcc-std-Z"      ,     "fBodyAccJerk-std-X"   ,   
 "fBodyAccJerk-std-Y"     ,  "fBodyAccJerk-std-Z"    ,   "fBodyGyro-std-X"       ,   "fBodyGyro-std-Y"      ,    "fBodyGyro-std-Z"      ,    "fBodyAccMag-std"       ,  
 "fBodyBodyAccJerkMag-std" , "fBodyBodyGyroMag-std"   ,  "fBodyBodyGyroJerkMag-std")


names(allData)[meanMeas] <- meanLabels
names(allData)[stdMeas] <- stdLabels

## select which measurements are to be kept in our smaller data set, and then set 'distData' to be this subset

tokeep <- union(stdMeas,meanMeas)[order(union(stdMeas,meanMeas))]

distData <- allData[tokeep]

## add a column containing the subject number for each observation

distData <- cbind(distData,rbind(subjectTrain,subjectTest))
names(distData)[80] <- "Subject"

## add a column containing the activity label for each observation, then replace the activity label with activity name, as obtained from 'activity_labels.txt'

distData <- cbind(distData,rbind(trainLabels,testLabels))
names(distData)[81] <- "Activity"

distData$Activity <- replace(distData$Activity,distData$Activity==1,"Walking")
distData$Activity <- replace(distData$Activity,distData$Activity==2,"Walking Upstairs")
distData$Activity <- replace(distData$Activity,distData$Activity==3,"Walking Downstairs")
distData$Activity <- replace(distData$Activity,distData$Activity==4,"Sitting")
distData$Activity <- replace(distData$Activity,distData$Activity==5,"Standing")
distData$Activity <- replace(distData$Activity,distData$Activity==6,"Laying")

## make activity a factor variable

distData$Activity <- as.factor(distData$Activity)

library(plyr)

## for each subject and activity, find the mean of each variable

AvgData <- ddply(distData,.(Subject,Activity),numcolwise(mean))

## save this tidy dataset

write.table(AvgData,file="tidy_data.txt",row.names=FALSE)

