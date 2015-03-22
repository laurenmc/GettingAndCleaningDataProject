library(tidyr)
library(dplyr)

# This function assumes Dataset containing all Samsung instrumentation data is 
# located in the sub-directory UCI HAR and all sub-directories are the same as those which
# exists within the source file. Download from: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis <- function() {
        
        # Load the raw dataset from test and train and combine
        data_x_test <- read.table('UCI HAR Dataset/test/X_test.txt')
        data_x_train <- read.table('UCI HAR Dataset/train/X_train.txt')
        data_x <- rbind(data_x_test, data_x_train)
        
        # the Y dataset from test and train and combine
        data_y_test <- read.table('UCI HAR Dataset/test/Y_test.txt')
        data_y_train <- read.table('UCI HAR Dataset/train/Y_train.txt')
        data_y <- rbind(data_y_test, data_y_train)
        
        # Load the test and training subjects and combine
        subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
        subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
        subject <- rbind(subject_test, subject_train)
        
        # Combine the X and Y datasets with the Subjects
        data <- cbind(cbind(data_x,subject), data_y)
        
        # Read in the features and combine with the Activities
        
        features <- read.table('UCI HAR Dataset/features.txt', colClasses = c('character'),
                               col.names = c('FeatureId', 'Feature'))
        features <- rbind(rbind(features, c(562,'Subject')), c(563,'ActivityId'))
        
        # Rename dataset with the features
        names(data)<-features$Feature
        
        # Read in the Activities list
        activities <- read.table('UCI HAR Dataset/activity_labels.txt', 
                                 col.names = c('ActivityId', 'Activity'))
        
        # Join the Activities to the dataset
        data <- inner_join(data, activities, by='ActivityId')
        
        # 2. Extract only the relavent columns (mean and standard deviation)
        data <- data[,grepl('(mean)|(std)|(Subject)|(Activity)',names(data))]        
        
        #Rename the columns with more descriptive names
        names(data) <- gsub('\\(|\\)', '', names(data))
        names(data) <- gsub('^t', 'Time', names(data))
        names(data) <- gsub('^f', 'Frequency', names(data))
        names(data) <- gsub('Acc', 'Acceleration', names(data))
        names(data) <- gsub('GyroJerk', 'AngularAcceleration', names(data))
        names(data) <- gsub('Gyro', 'AngularSpeed', names(data))
        names(data) <- gsub('Mag', 'Magnitude', names(data))
        names(data) <- gsub('-mean', 'Mean', names(data))
        names(data) <- gsub('Freq-', 'Frequency-', names(data))
        names(data) <- gsub('Freq$', 'Frequency', names(data))
        
        # calculate the average of each variable for each activity and each subject
        data <- summarise_each(group_by(data, Activity, Subject), funs(mean))
        
        # Return the tidied dataset
        data

}