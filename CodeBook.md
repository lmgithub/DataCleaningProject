# Data

## dt data table
dt data table contains mean and standard deviation measurements for activities.
### dt variables
**Activity information**

 1 ActivityLabel              
 2 ActivityName  
**measurement variables**

 3 tBodyAcc-mean()-X          
 4 tBodyAcc-mean()-Y          
 5 tBodyAcc-mean()-Z          
 6 tBodyAcc-std()-X           
 7 tBodyAcc-std()-Y           
 8 tBodyAcc-std()-Z           
 9 tGravityAcc-mean()-X       
10 tGravityAcc-mean()-Y       
11 tGravityAcc-mean()-Z       
12 tGravityAcc-std()-X        
13 tGravityAcc-std()-Y        
14 tGravityAcc-std()-Z        
15 tBodyAccJerk-mean()-X      
16 tBodyAccJerk-mean()-Y      
17 tBodyAccJerk-mean()-Z      
18 tBodyAccJerk-std()-X       
19 tBodyAccJerk-std()-Y       
20 tBodyAccJerk-std()-Z       
21 tBodyGyro-mean()-X         
22 tBodyGyro-mean()-Y         
23 tBodyGyro-mean()-Z         
24 tBodyGyro-std()-X          
25 tBodyGyro-std()-Y          
26 tBodyGyro-std()-Z          
27 tBodyGyroJerk-mean()-X     
28 tBodyGyroJerk-mean()-Y     
29 tBodyGyroJerk-mean()-Z     
30 tBodyGyroJerk-std()-X      
31 tBodyGyroJerk-std()-Y      
32 tBodyGyroJerk-std()-Z      
33 tBodyAccMag-mean()         
34 tBodyAccMag-std()          
35 tGravityAccMag-mean()      
36 tGravityAccMag-std()       
37 tBodyAccJerkMag-mean()     
38 tBodyAccJerkMag-std()      
39 tBodyGyroMag-mean()        
40 tBodyGyroMag-std()         
41 tBodyGyroJerkMag-mean()    
42 tBodyGyroJerkMag-std()     
43 fBodyAcc-mean()-X          
44 fBodyAcc-mean()-Y          
45 fBodyAcc-mean()-Z          
46 fBodyAcc-std()-X           
47 fBodyAcc-std()-Y           
48 fBodyAcc-std()-Z           
49 fBodyAccJerk-mean()-X      
50 fBodyAccJerk-mean()-Y      
51 fBodyAccJerk-mean()-Z      
52 fBodyAccJerk-std()-X       
53 fBodyAccJerk-std()-Y       
54 fBodyAccJerk-std()-Z       
55 fBodyGyro-mean()-X         
56 fBodyGyro-mean()-Y         
57 fBodyGyro-mean()-Z         
58 fBodyGyro-std()-X          
59 fBodyGyro-std()-Y          
60 fBodyGyro-std()-Z          
61 fBodyAccMag-mean()         
62 fBodyAccMag-std()          
63 fBodyBodyAccJerkMag-mean()
64 fBodyBodyAccJerkMag-std()  
65 fBodyBodyGyroMag-mean()    
66 fBodyBodyGyroMag-std()     
67 fBodyBodyGyroJerkMag-mean()
68 fBodyBodyGyroJerkMag-std() 

### Measurement variables description
Measurement variables described in features_info.txt in project data.

## dtMeans data table
dtMeans data table contains mean values of each variable for each activity and each subject.
### dtMeans variables
dtMeans has the same set of variables as ds dataset plus variable Sublect.
Measurement variables contain mean values for corresponding activity and subject

# Data manipulation description

**Step 1. Merges the training and the test sets to create one data set**

1. Load the training and the test sets
 * 'train/X_train.txt': Training set,
 * 'test/X_test.txt': Test set.
2. Merge them to one data set using rows binding.

**Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.** 

1. Load full features list from features.txt
2. Select only mean and standard deviation features names and feature numbers
3. Extracts only the mean and standard deviation measurements using selected feature numbers.
4. Set variable names using selected feature names

**Step 3. Uses descriptive activity names to name the activities in the data set**

1. Load activity names and labels from activity_labels.txt and name loaded variables.
2. Load activity labels for training and test measurements: 
 * 'train/y_train.txt': Training labels,
 * 'test/y_test.txt': Test labels.
3. Merge measurement activity labels to one dataset using rows binding and name variable.
4. Add measurement activity labels to measurement dataset (from Step 2) using column binding
5. Merge measurement dataset with activity names by activity labels column.  

**Step 4. Appropriately labels the data set with descriptive variable names.**

All variables in dataset are named already.
* Measurement variables are named in Step 2, point 4.
* Activity variables are named in Step 3, point 1.

Dataset is in data table format.

**Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

1. Load subjects for training and test measurements: 
 * 'train/subject_train.txt': Training subjects,
 * 'test/subject_test.txt': Test subjects.
2. Merge subjects to one dataset using rows binding and name variable.
3. Add subjects to measurement dataset (from Step 4) using column binding and transform dataset to data frame.
4. Reshape dataset using melt function with Subject+Activity key.
5. compute average values for variables (measurements) with Subject+Activity key and transform dataset to data table.
