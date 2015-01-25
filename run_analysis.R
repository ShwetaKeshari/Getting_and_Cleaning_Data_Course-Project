#Set Working directory
######################################
if(!file.exists("C:/Dataset")){dir.create("C:/Dataset")}
setwd("C:/Dataset")


# Downloading file and unziping it and getting list of files.
###########################################################
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip", exdir = "UCI HAR Dataset")

#List Files
#################

list.files("C:/Dataset/UCI HAR Dataset")

##Read data from the files into the Table variables
####################################################

###Read Activity files
#######################

y_test_data  <- read.table("C:/Dataset/UCI HAR Dataset/test/Y_test.txt" ,header = FALSE)
y_train_data <- read.table("C:/Dataset/UCI HAR Dataset/train/Y_train.txt",header = FALSE)

###Read Subject files
########################

Subject_Train_data <- read.table("C:/Dataset/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
Subject_Test_data  <- read.table("C:/Dataset/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

###Read Fearures files
###########################
x_test_features  <- read.table("C:/Dataset/UCI HAR Dataset/test/X_test.txt" ,header = FALSE)
x_train_features<- read.table("C:/Dataset/UCI HAR Dataset/train/X_train.txt",header = FALSE)


# Merging the Data set (by Row)
###################################
###
##Merging activity data
data_activity<-rbind(y_test_data,y_train_data)
head(data_activity,5)
##Merging Subject data
data_subject<-rbind(Subject_Train_data,Subject_Test_data)

##Merging feature data
data_feature<-rbind(x_test_features ,x_train_features)

###Set names to variables
###################################
names(data_subject)<-c("subject")
names(data_activity)<- c("activity")
dataFeaturesNames <- read.table("C:/Dataset/UCI HAR Dataset/features.txt",head=FALSE)
names(data_feature)<- dataFeaturesNames$V2

#Merges the training and the test sets to create one data set.
############################################################

Data<-cbind(data_activity,data_subject,data_feature)


#Extracts only the measurements on the mean and standard deviation for each measurement
############################################################################
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]###Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)


##.Read descriptive activity names 
###################################################

activityLabels <- read.table("C:/Dataset/UCI HAR Dataset/activity_labels.txt",header = FALSE)

Data$activity <- as.character(Data$activity)
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking Upstairs"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"
Data$activity <- as.factor(Data$activity)

##Appropriately labels the data set with descriptive variable names
#####################################################################

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

##Creates a second,independent tidy data set and ouput it
############################################################


library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

###############################################












