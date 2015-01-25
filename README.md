# Getting and Cleaning Data Course Project

## All the Files in this Repo
 
 . Readme.md- Readme file giving an overview of the Data
 . CodeBook.md-Its a code book describing details of the variable and the data, 
     and any transformations or work that was performed to clean up the data.

 . run_analysis.R- R code to write the Program.

## Goal of the Project.

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

### Steps included
1)Merges the training and the test sets to create one data set.

2)Extracts only the measurements on the mean and standard deviation for each measurement.
 
3)Uses descriptive activity names to name the activities in the data set.

4)Appropriately labels the data set with descriptive variable names. 

5)From the data set in step 4, creates a second, independent tidy data set
 with the average of each variable for each activity and each subject. 


## Data source.

The data linked to from the course website represent data collected 
from the accelerometers from the Samsung Galaxy S smartphone.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Process Involved

1) Downloading file and unziping it and getting list of files.



2) Read data from the files into the Table variables.

Read the Y_test.txt and Y_train.txt (activity files) data, 
 X_test.txt, X_train.txt(featurs files) and subject_train.txt, subject_test.txt ( subject files) from 
the files into the Table variables by using "read.table".

3) Loading and Merging the test sets

Using the "rbind" function, 'train' and 'test' data set were 
merged for activity, features and subject data set.

These data set are:
data_activity
data_subject
data_feature

Once the data set was merged to form a data frame, it was required to 
combine all the three 'data_activity', 'data_subject', 'data_feature'
to one data set but before that names were set to the variables.

4)Set names to variables


Using function"names" names were provided to all the three data set.

Also features were read using "read.table" function to read 'feature.txt'.

5) Data sets were combind to one data set named 'Data' by using "cbind" function.

6)The activity labels are declared by reading activity_labels.txt 
and using "as.factor" function.

7) Data set was appropriately labels the data set with descriptive
 variable names using "gsub" function
 
Names replaced were as follows: 

"^t" by "time"

"^f"by "frequency" 

"Acc" by "Accelerometer"

"Gyro" by "Gyroscope"

"Mag" by "Magnitude"

"BodyBody" by "Body"


8)Independent tidy data set was created using write.table.

