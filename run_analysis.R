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
## Result of Step 3
dt <- merge(dtActivities, dt, by="ActivityLabel", all.x=TRUE)

## 4. Appropriately labels the data set with descriptive variable names. 
## Done on previous steps
## Result of Step 4: dt

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Data sources (info from README.txt): 
## Descriptions for Training and Test subjects are equivalent. 
## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## read subject data for measurements and merge them with main dataset
dtTrainingSubj <- readFile("train", "subject_train.txt") ## read Training subjects. 
dtTestSubj <- readFile("test", "subject_test.txt") ## read Test subjects. 
dtSubj <- rbind(dtTrainingSubj, dtTestSubj) ## Merge subjects 
setnames(dtSubj, "Subject") ## set column name
df <- data.frame(cbind(dtSubj, dt)) ## Add subjects column and convert to data frame

## reshape dataset and compute average values
library(plyr)
library(reshape)
dfMelted <- melt(df, id=c("Subject", "ActivityLabel", "ActivityName")) ## melt data with Subject+Activity key
## Result of Step 5
dtMeans <- data.table(cast(dfMelted, Subject + ActivityLabel + ActivityName ~ variable, mean)) ## compute average values for variables (measurements) with Subject+Activity key


