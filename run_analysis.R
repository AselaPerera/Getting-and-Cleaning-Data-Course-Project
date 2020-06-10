
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"data.zip",method = "curl")
unzip("data.zip",list = TRUE)

library(dplyr)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

###Creating data frame from data in test folder

test_Set <- read.table("UCI HAR Dataset/test/X_test.txt")
names(test_Set) <- features$V2
activitiy_Test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt")

test_Data <- cbind(subject_Test,activitiy_Test,test_Set)
names(test_Data)[1] <- "subject"
names(test_Data)[2] <- "activity"


###Creating data frame from data in train folder

train_Set <- read.table("UCI HAR Dataset/train/X_train.txt")
names(train_Set) <- features$V2
activitiy_Train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt")

train_Data <- cbind(subject_Train,activitiy_Train,train_Set)
names(train_Data)[1] <- "subject"
names(train_Data)[2] <- "activity"
unique(train_Data$subject)


##01)

Data <- rbind(train_Data,test_Data)
names(Data)

##02)
df1 <- Data[ , grepl( "mean()" , names(Data) )| grepl( "std" , names(Data))] 
df2 <- Data[ , grepl( "meanFreq()" , names(Data) ) ]
names(df2)
df <- select(df1,-names(df2))
df <- cbind(Data$subject,Data$activity,df)

names(df)[c(1,2)] <- c("subject","activity")

##03)
df$activity <- as.factor(df$activity)
levels(df$activity) <- activity_labels$V2

##04)

names(df)<-gsub("tBodyAcc-","Body acceleration signal in time domain (from the accelerometer)",names(df))
names(df)<-gsub("tBodyAccMag-","Body acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(df))
names(df)<-gsub("tBodyAccJerk-","Body acceleration jerk signal in time domain (from the accelerometer)",names(subActFeatures_both_descAct))
names(df)<-gsub("tBodyAccJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform (from the accelerometer)",names(df))
names(df)<-gsub("tGravityAcc-","Gravity acceleration signal in time domain (from the accelerometer)",names(df))
names(df)<-gsub("tGravityAccMag-","Gravity acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(df))
names(df)<-gsub("tBodyGyro-","Body acceleration signal in time domain (from the gyroscope)",names(df))
names(df)<-gsub("tBodyGyroMag-","Body acceleration signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(df))
names(df)<-gsub("tBodyGyroJerk-","Body acceleration jerk signal in time domain (from the gyroscope)",names(df))
names(df)<-gsub("tBodyGyroJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(df))
names(df)<-gsub("fBodyAcc-","Body acceleration signal in frequence domain (from the accelerometer)",names(df))
names(df)<-gsub("fBodyAccMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform(from the accelerometer)",names(df))
names(df)<-gsub("fBodyAccJerk-","Body acceleration jerk signal in frequence domain (from the accelerometer)",names(df))
names(df)<-gsub("fBodyGyro-","Body acceleration signal in frequence domain (from the gyroscope)",names(df))
names(df)<-gsub("fBodyAccJerkMag-","Body acceleration jerk signal in frequence domain applied to Fast Fourrier Transform (from the accelerometer)",names(df))
names(df)<-gsub("fBodyGyroMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform (from the gyroscope)",names(df))
names(df)<-gsub("mean()", " Mean", names(df))
names(df)<-gsub("std()", " std", names(df))

##05)
tidydata<-df%>%group_by(subject,activity)%>%summarise_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)