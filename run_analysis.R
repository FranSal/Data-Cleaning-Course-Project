## opening libraries dplyr and tidyr needed to clean and orgnize the data
library(dplyr)
library(tidyr)

##  This lines must be modified to customize your system: 
## changing to the base dir. where we have stored out raw data.
setwd("Data-Cleaning-Course-Project/raw_data")

## defining  raw data  directories and files  ( subdirectories branching from the base dir )
## Plase note that this has been done on a Mac. For windows you have to substitute the slash(/) with the back-slash(\)
testdir <- "./test"
traindir <- "./train"

## Test file names from the original zip package
testxfile <- "X_test.txt"
trainxfile <- "X_train.txt"
testyfile <- "y_test.txt"
trainyfile <- "y_train.txt"
subjTr <- "subject_train.txt"
subjTs <- "subject_test.txt"

## reading train set . First we paste the fie dir wirh the name of the file
path1 <- paste(traindir,"/",trainxfile, sep="")
raw_train <- read.fwf(path1, widths =rep(16,561), header = FALSE,   numerals = "no.loss", n = -1) # reads fixed width X_train.txt file

# now it reads Y_train.txt after setting its path to path12 using read.fwf() seting its widths to 1 and header =FALSE
# same idea for reading subject_train.txt but setting the width = 2 because we have up to 30 subject id's, (from 1 to 30).
path12 <- paste(traindir,"/",trainyfile, sep="") 
y_train <- read.fwf(path12, widths =1, header = FALSE) 
path13 <- paste(traindir,"/",subjTr, sep="")
subj_train <- read.fwf(path13, widths =2, header = FALSE)

## reading test set
path2 <- paste(testdir,"/", testxfile, sep="")
raw_test <- read.fwf(path2, widths =rep(16,561), header = FALSE,   numerals = "no.loss", n = -1) # reads fixed width  X_test.txt file
# reads Y_test.txt
path22 <- paste(testdir,"/",testyfile, sep="")
y_test <- read.fwf(path22, widths =1, header = FALSE)
# reading subject_test.txt
path23 <- paste(testdir,"/",subjTs, sep="")
subj_test <- read.fwf(path23, widths =2, header = FALSE)

## transforming all  to tbl_df format
xtrain <- tbl_df(raw_train)
xtest <- tbl_df(raw_test)
ytrain <- tbl_df(y_train)
ytest <- tbl_df(y_test)
subjtrain <- tbl_df(subj_train)
subjtest <- tbl_df(subj_test)


## merging all X, y and subject data  in a single dataframe of the same kind
total_x <-bind_rows(xtrain,xtest)
total_y <-bind_rows(ytrain,ytest)
total_subj <- bind_rows(subjtrain,subjtest)
names(total_subj) <- "subject"  ## changing the label of total_subj to a useful one.

# reading thee features.txt file to extract the indexes we are interested in 
tmp <- read.table("features.txt",header= FALSE, sep=" ", nrows=561)
features <- tbl_df(tmp[ grepl("mean()",tmp$V2) | grepl("std()",tmp$V2),])
 ## Now wr extract to a custom table the columns we are interested in from the merged total_x data set.
my_total_x <- select(total_x, features$V1)

## now we can name the columns with the names of the features taken from features$V2 
my_total_x <- setNames(my_total_x, features$V2) 

## Reading the activity_labels.txt to extract the names of the activites. 
## This file it's assumed to be present in the main Data-Cleaning-Course-Project folder
activities <- read.table("activity_labels.txt",header= FALSE, sep=" ", nrows=6)

## mutating total_y by changing its numeric code to an activity name
my_total_y <- total_y %>% 
                mutate( activity = activities$V2[total_y$V1]) %>%
                select(activity)

# finally merging together the three data sets, putting "subject" and activity in the fists two columns.
my_dataset <- tbl_df(bind_cols(total_subj, my_total_y, my_total_x ))
    
    
## Now we'll create a separate data set with the average of each variable by subject and activity
averages_set <- my_dataset %>%  
            group_by(subject, activity) %>%
            summarise_each(funs(mean))

# now the final step is to write the final table into a cvs format. I choose to write it om the base dir ("Data-Cleaning-Course-Project/raw_data")
write.csv(averages_set, "averages_set.csv")

