##setwd("/home/lm/Projects/Data Clearning/Project")
##rm(list=ls())

## 1. Merges the training and the test sets to create one data set.
## Data sources (info from README.txt): 
## - 'train/X_train.txt': Training set.
## - 'test/X_test.txt': Test set.

## load library
library("data.table")

## Requirement: The code can be run as long a the Samsung data is in your working directory.
dirDataset <- file.path(getwd(), "UCI HAR Dataset") ## Samsung data directory name
## fread function crash my RStudio, so I use read.table to read data
## this function reads the file fileName from subdirectory dirName in Samsung data directory
readFile <- function(dirName, fileName) {
  filePath <- file.path(dirDataset, dirName, fileName) 
  data.table(read.table(filePath)) 
}

dtTraining <- readFile("train", "X_train.txt") ## read Training set 
dtTest <- readFile("test", "X_test.txt") ## read Test set 

## Result of Step 1
dt <- rbind(dtTraining, dtTest) ## Merge sets

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## measurement names source (info from README.txt):
## - 'features.txt': List of all features.

## read all features data (first column V1 - feature number, second column V2 - feature name)
dtFeatures <- fread(file.path(dirDataset, "features.txt")) 
## get vector of feature numbers for mean and std features names
##vFeatures <- dtFeatures$V1[grepl("mean\\(\\)|std\\(\\)", dtFeatures$V2)] 
## get mean and std features names
dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", dtFeatures$V2)] 

## Result of Step 2
dt <- dt[, dtFeatures$V1, with=FALSE] ## Get data for selected features names
setnames(dt, dtFeatures$V2) ## set column names. Needed for Step 4.

## 3. Uses descriptive activity names to name the activities in the data set
## Data sources (info from README.txt): 
## - 'activity_labels.txt': Links the class labels with their activity name.
## - 'train/y_train.txt': Training labels.
## - 'test/y_test.txt': Test labels.

## read activities names
dtActivities <- fread(file.path(dirDataset, "activity_labels.txt"))  ## read names of activities.
setnames(dtActivities, c("ActivityLabel", "ActivityName")) ## set column names

## read activity labels data for measurements and merge them with main dataset
dtTrainingAct <- readFile("train", "y_train.txt") ## read Training activity labels. 
dtTestAct <- readFile("test", "y_test.txt") ## read Test activity labels. 
dtAct <- rbind(dtTrainingAct, dtTestAct) ## Merge activity labels 
setnames(dtAct, "ActivityLabel") ## set column name
dt <- cbind(dtAct, dt) ## Add activity labels column 

## Add names to main dataset
dt <- merge(dtActivities, dt, by="ActivityLabel", all.x=TRUE)

## 4. Appropriately labels the data set with descriptive variable names. 
## Done on previous steps

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
