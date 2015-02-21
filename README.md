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


The files included here are:

      README.md:          a concise info of this project

      run_analysis.R:     R script to automate all analysis starting from the de-zipped files 

      averages_set.csv:   The final result of running run_analysis.R in an easy looking format.
      
      averages_set.txt    Same  info as in the csv file but it's in the format asked by the project instructions

      codebook.txt:       this file that describes the transformations and variables of this data. 


When choosing wich of the data columns to get into my sub-set, upon inspection of the original documentation, I decided that the mean and std variables asked for this exercise were exclusively referring to those that included  "mean()" and "std()". 
Other of variables described in the features.txt  containing "meanFrec"  as well as others containing gravityMean were discarded; although it can be easily included by changing  just a pice of the code.

To extract the columns of interest I used : 

     features <- tbl_df(tmp[ grepl("mean()",tmp$V2) | grepl("std()",tmp$V2),]) 
   
if we wanted to extract the missing columns this line of code shall be changed to:

     features <- tbl_df(tmp[ grepl("mean",tmp$V2) | grepl("std()",tmp$V2),]) 

The stages of transformation were:

1.- Download and unzip the files in a directory pendinf from our main working directory, 

running the run_analisys.R script:

2.- Define path and file variables 

3.- Read them using read.fwf (  since they are fixed width format compatible files. This is a bit slow, but works flawlesly)

4.- Transform all sets to tbl_df format

5.- Merge using bind.rows() ( on each x, y and subject sets) from  train and test sets.

6.- Change the name of the V1 variable from the subject set to "subject" using names()

7.- Read the features table and sub-set  the interested features using the code( as above):

            features <- tbl_df(tmp[ grepl("mean()",tmp$V2) | grepl("std()",tmp$V2),]) 
            
                that passes only those rows with  the presence of a sub-string of charecters in the V2 column.

8.- Create a subset( my_total_x) of the  merged x_set ( total_x) using:

            select(total_x, features$V1), where feature$V1 is the list of wanted columns

9 .-Change the column names to represent the chosen features using:

            setNames(my_total_x, features$V2) where features$V2 is the list of names to overwrite the standard V1, V2....Vn
    
10.- Read the activities.txt file and create my_total_y  using a mutate and transform formula to substitute the numeric code and insert a meaningful activity:

             my_total_y <- total_y %>% 
                mutate( activity = activities$V2[total_y$V1]) %>% # here we are adding a new column named "activity"
                select(activity) # here we get rid of the the old V1 col we inherited from the original total_y

11.- Blend the three sets ( my_total_x, my_total_y, total_subj) into a new set with subject and activity as the 1st and 2nd columns.
             my_dataset <- tbl_df(bind_cols(total_subj, my_total_y, my_total_x ))

This new set (my_dataset) holds 79  extracted variables + 2 new ones ("subject" and "activity") for a total of 81 variables, 
so this set has 10299 observations and 81 variables.

12.-Create a new averages set using group_by and summarise_each in cascade:

                averages_set <- my_dataset %>%  
                                    group_by(subject, activity) %>%
                                    summarise_each(funs(mean))

This new averages_set holds the average of every variable of our modified set, by activity and subject.
since there are 30 subjects and 6 activities there is a total of 180 rows, by 81 columns.


13.- Write the averages_set dataset into a csv file ( good viualization )

14.- Write the averages_set into a txt file (same as 13.- but as txt, as demanded by the course)
