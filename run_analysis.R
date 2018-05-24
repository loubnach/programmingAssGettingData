##download and unzip the data source into file name dtset.zip
###########  
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile="dtset.zip")
unzip("dtset.zip")
##############

## in the main directory 'UCI HAR Dataset' there is two data files :
#### file activity_labels.txt for activities labels :  WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING
#### and file features.txt for the features labels or 'measurements labels'

## the code bellow create common dataset from this two files
###########
  features<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
  activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
########### 
## in the main directory 'UCI HAR Dataset' there is two directories test (for tests subjects) and train (for train subjects)
#### in each directory we have :
                                 #X_test/train of all measurements 
                                 #and y_test/train for code activities
                                 #subject_test/train for subjects
#### in each directory we have a directory Inertial Signals for measurement splited by measurement type
###########i choose to create data from the main files  X_test/train 

  
## the code bellow create test dataset for tests subjects      

##############   
#creating measurement and updating columns names with futures 
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(x_test)<-as.character(features$V2)

#creating subject and updating the column name with "subject" 
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)<-"subject"

#creating code activities dataset and join it with activities labels to create a dataset with labels columns
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
test_activite<-select(inner_join(y_test,activity_labels,by=c("V1"="V1" )),V2)
colnames(test_activite)<-"activity"

# merge subjects, activities and measurement
test<- cbind(subject_test,test_activite,x_test)
#############"

## the code bellow create test dataset for train subjects      

##############   
#creating measurement and updating columns names with features 
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(x_train)<-as.character(features$V2)

#creating subject and updating the column name with "subject" 
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)<-"subject"

#creating code activities dataset and join it with activities labels to create a dataset with labels columns
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
train_activite<-select(inner_join(y_train,activity_labels,by=c("V1"="V1" )),V2)
colnames(train_activite)<-"activity"  

# merge subjects, activities and measurement
train<- cbind(subject_train,train_activite,x_train)
##############################

# the code bellow merge test and train dataset   
  global_dt<-rbind(test,train)

# subset only column with mean or standard deviation measurements and also subjects and activities
new_dt<-global_dt[ , grepl( "mean$" , names( global_dt ) )|grepl( "std$" , names( global_dt ) )
                   |grepl( "subject" , names( global_dt ) )|grepl( "activity" , names( global_dt ) )
                   ] 
#calculate the average of all column for eanch activity for each subject
  agregate_dt<-aggregate(new_dt[3:81], by=c(new_dt["subject"],new_dt["activity"]),FUN=mean)
  
# Write the output in the file  aggregates_data.txt
write.table(agregate_dt,file="aggregates_data.txt",row.name=FALSE)
  
 