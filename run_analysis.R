## As data is loaded, an attempt is made to name the columns as appropriate.
## As manipulations occur, and data frames are referenced, the named columns are 
## used versus the column index in an attempt to make the code more readable, 
## even if the data frame in question only contains one column.

## Download data
setwd("~/Coursera/GettingandCleaningData")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip")

# Unzip data.
unzip(zipfile="Dataset.zip")

## Get the list of the features in the feature.txt file.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset")
features <- read.csv("features.txt", sep = " ", header = FALSE, col.names = c("FeatureColumnPosition", "FeatureName"))

## Load the X test file.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/test")
## The file format is fixed at 16 characters.  However, the initial value appears to be
## also prepended with a space.  Hence, the first column is actually 17 characters with
## the remaining being 16.  There are 561 values, therefore the widths vector contains
## a 17 followed by 560 16s for a total of 561 columns.
testRawData <- read.fwf("X_test.txt", sep = "", header = FALSE, widths = c(17, rep(16, 560)))
                  
## Load the X train file.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/train")
## The file format is fixed at 16 characters.  However, the initial value appears to be
## also prepended with a space.  Hence, the first column is actually 17 characters with
## the remaining being 16.  There are 561 values, therefore the widths vector contains
## a 17 followed by 560 16s for a total of 561 columns.
trainRawData <- read.fwf("X_train.txt", sep = "", header = FALSE, widths = c(17, rep(16, 560)))

## Get the activity codes and their labels.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset")
activityLabels <- read.csv("activity_labels.txt", sep = " ", header = FALSE, col.names = c("ActivityIndex", "ActivityLabel"))

## Read the test and train activity data.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/test")
testActivities<- read.csv("y_test.txt", sep = " ", header = FALSE, col.names = c("Activity"))
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/train")
trainActivities<- read.csv("y_train.txt", sep = " ", header = FALSE, col.names = c("Activity"))

## As per project requirements:
## 3. Uses descriptive activity names to name the activities in the data set.
##
## Now, map the test and train activity data to their more friendly label versions.
testActivityFriendly <- activityLabels[testActivities[,"Activity"], "ActivityLabel"]
trainActivityFriendly <- activityLabels[trainActivities[,"Activity"] ,"ActivityLabel"]

## Read the test and train volunteer data.
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/test")
testVolunteers <- read.csv("subject_test.txt", sep = " ", header = FALSE, col.names = c("Volunteer"))
setwd("~/Coursera/GettingandCleaningData/UCI HAR Dataset/train")
trainVolunteers <- read.csv("subject_train.txt", sep = " ", header = FALSE, col.names = c("Volunteer"))


## We now have all of the data pieces to connect together for test and train data sets.
##
## Volunteers
## Activities - the "friendly english label" version
## Data
##
## Lets combine the test pieces together and the train pieces together.
## data.frame column adds by default.

testCombined <- data.frame(testVolunteers, testActivityFriendly, testRawData)
trainCombined <- data.frame(trainVolunteers, trainActivityFriendly, trainRawData)

## As per project requirements:
## 4. Appropriately labels the data set with descriptive variable names.
##
## The column labelling is done on the whole set; however, this frames things up
## when only certain columns are retrieved later.  The approprioate column names
## will move too.
## Label the columns for test and train data sets.
names(testCombined) <- c(names(testVolunteers), "Activity", as.character(features$FeatureName))
names(trainCombined) <- c(names(trainVolunteers), "Activity", as.character(features$FeatureName))

## As per project requirements:
## 1. Merges the training and the test sets to create one data set.
##
## Merge the test and train data sets on top of each other.
## Project requirement listed training first, so its data set is placed on top.
mergedTrainTest <- rbind(trainCombined, testCombined)

## As per project requirements:
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## Extract the "mean()" and "std()" values with thier positions.
## This will constitute the required columns and their positions to extract from further files.
meanStdColumns <- names(mergedTrainTest)[grep("(mean|std)\\(\\)", names(mergedTrainTest))]

## Extract the mean and standard deviation columns along with Volunteer and Activity.
extractDataOnly <- mergedTrainTest[,c("Volunteer", "Activity", meanStdColumns)]

## As per project requirements:
## 5. From the data set in step 4, creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

## Get the mean of all the data (the dot) and group over Volunteer and Activity
meanData <- aggregate(. ~Volunteer + Activity, extractDataOnly, mean)

## Order the aggregated data by Volunteer and Activity just to make it more intuitive.
meanDataOrdered <- meanData[order(meanData$Volunteer, meanData$Activity),]

## Output the final data set.
setwd("~/Coursera/GettingandCleaningData/Getting and Cleaning Data Project")
write.table(meanDataOrdered, "ProjectData.txt", row.names = FALSE)