# programmingAssGettingData

 in the main directory 'UCI HAR Dataset' there is two data files :
     *file activity_labels.txt for activities labels :  WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING
     *and file features.txt for the features labels or 'measurements labels'
==================================
 		dataset
====================================
in the main directory 'UCI HAR Dataset' there is two directories test (for tests subjects) and train (for train subjects)
in each directory we have :
                    *X_test/train of all measurements 
                    *and y_test/train for code activities
                    *subject_test/train for subjects

the global dataset (train/test) is the merge of subjects, activities and measerement

in each directory we have a directory Inertial Signals for measurement splited by measurement type, I choose to create data from the main files  X_test/train.

In train and test dataset we have 561 variables for the assignement i extracted variables with mean and std for the mean and the standard deviation.


in the final data set or the output there is 81 variable (for mean and std) and 180 rows (30 subjects*6 activities)

==================================
 		script
====================================

to execute  the script, put run_analysis.R and the data repository UCI HAR Dataset . 
you have to install packages
install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)
and execute the script : run_analysis.R 