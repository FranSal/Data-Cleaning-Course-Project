
# Data-Cleaning-Course-Project

 This exercise  takes the raw data from the "Human Activity Recognition Using Smartphones Dataset"
 
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
 You are referred to the features_info.txt of the original set for the description of the original signals.
 
 The read.me file of the original set  says:
 "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist."
 
 We take the original set and perform the tasks demanded by the course project exercise:
 
 1.- Merges the training and the test sets to create one data set.
 
 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
 
 3.- Uses descriptive activity names to name the activities in the data set
 
 4.- Appropriately labels the data set with descriptive variable names. 
 
 5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
   for each activity and each subject.


Files included:

      README.md:          a concise info of this project

      run_analysis.R:     R script to automate all analysis starting from the de-zipped files 

      averages_set.csv:   The final result of running run_analysis.R
      
      averages_set.txt    same as the csv file but it's the in the format asked by the project instructions

      codebook.txt:       this file that describes the transformations and variables of this data. 


When choosing wich of the data columns to get into my sub-set, upon inspection of the original documentation, I decided that the mean and std variables asked for this exercise were exclusively referring to those that included  "mean()" and "std()". 
Other of variables described in the features.txt  containing "meanFrec"  as well as others containing gravityMean were discarded; although it can be easily included by changing  just a pice of the code.

To extract the columns of interest I used : 

     features <- tbl_df(tmp[ grepl("mean()",tmp$V2) | grepl("std()",tmp$V2),]) 
   
if we wanted to extract the missing columns this line of code shall be changed to:

     features <- tbl_df(tmp[ grepl("mean",tmp$V2) | grepl("std()",tmp$V2),]) 


---------------------------------------------------------------------------------------------------------------------------

VARIABLES present in the final averages_set table.

This new averages_set holds the average of every variable of our modified set, by activity and subject.
since there are 30 subjects and 6 activities there is a total of 180 rows, by 81 columns.
The units:

All the original observations in the x observsation set, as stated in their book notes, were normalized and bounded within [-1,1] the averaged values in the averages_set share the bounded condition.

The numeric value of the activity on the original set has been substitued by a descriptive string.
The "subject" variable range from 1 to 30.

Please refer to the README.md file for an in-depth description of the steps taken from the original data set to the final averages_set.txt ( averages-csv)
 

subject: 1-30 - The subjects of the experiment.

activity  
      The six original activities are:
      WALKING
      WALKING_UPSTAIRS
      WALKING_DOWNSTAIRS
      SITTING
      STANDING
      LAYING

The  following are averaged variables are presented as  a real number in a fixed width format.
Its value represent the average value on ech activity for each subjet.

tBodyAcc-mean()-X

tBodyAcc-mean()-Y

tBodyAcc-mean()-Z

tBodyAcc-std()-X

tBodyAcc-std()-Y

tBodyAcc-std()-Z

tGravityAcc-mean()-X

tGravityAcc-mean()-Y

tGravityAcc-mean()-Z

tGravityAcc-std()-X

tGravityAcc-std()-Y

tGravityAcc-std()-Z

tBodyAccJerk-mean()-X

tBodyAccJerk-mean()-Y

tBodyAccJerk-mean()-Z

tBodyAccJerk-std()-X

tBodyAccJerk-std()-Y

tBodyAccJerk-std()-Z

tBodyGyro-mean()-X

tBodyGyro-mean()-Y

tBodyGyro-mean()-Z

tBodyGyro-std()-X

tBodyGyro-std()-Y

tBodyGyro-std()-Z

tBodyGyroJerk-mean()-X

tBodyGyroJerk-mean()-Y

tBodyGyroJerk-mean()-Z

tBodyGyroJerk-std()-X

tBodyGyroJerk-std()-Y

tBodyGyroJerk-std()-Z

tBodyAccMag-mean()

tBodyAccMag-std()

tGravityAccMag-mean()

tGravityAccMag-std()

tBodyAccJerkMag-mean()

tBodyAccJerkMag-std()

tBodyGyroMag-mean()

tBodyGyroMag-std()

tBodyGyroJerkMag-mean()

tBodyGyroJerkMag-std()

fBodyAcc-mean()-X

fBodyAcc-mean()-Y

fBodyAcc-mean()-Z

fBodyAcc-std()-X

fBodyAcc-std()-Y

fBodyAcc-std()-Z

fBodyAcc-meanFreq()-X

fBodyAcc-meanFreq()-Y

fBodyAcc-meanFreq()-Z

fBodyAccJerk-mean()-X

fBodyAccJerk-mean()-Y

fBodyAccJerk-mean()-Z

fBodyAccJerk-std()-X

fBodyAccJerk-std()-Y

fBodyAccJerk-std()-Z

fBodyAccJerk-meanFreq()-X

fBodyAccJerk-meanFreq()-Y

fBodyAccJerk-meanFreq()-Z

fBodyGyro-mean()-X

fBodyGyro-mean()-Y

fBodyGyro-mean()-Z

fBodyGyro-std()-X

fBodyGyro-std()-Y

fBodyGyro-std()-Z

fBodyGyro-meanFreq()-X

fBodyGyro-meanFreq()-Y

fBodyGyro-meanFreq()-Z

fBodyAccMag-mean()

fBodyAccMag-std()

fBodyAccMag-meanFreq()

fBodyBodyAccJerkMag-mean()

fBodyBodyAccJerkMag-std()

fBodyBodyAccJerkMag-meanFreq()

fBodyBodyGyroMag-mean()

fBodyBodyGyroMag-std()

fBodyBodyGyroMag-meanFreq()

fBodyBodyGyroJerkMag-mean()

fBodyBodyGyroJerkMag-std()

fBodyBodyGyroJerkMag-meanFreq()

