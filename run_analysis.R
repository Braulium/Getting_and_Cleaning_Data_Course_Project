##run_analysis.R script
##Inputing data from txt files and assigning names to columns
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("code", "feature")

activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activities_labels) = c("code", "activity_label")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- "subject"

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features$feature

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "code"

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) <- "subject"

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- features$feature

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "code"


##POINT 1. Merges the training and the test sets to create one data set.
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)

##merging all variables (columns) of all datasets
full_dataset <- cbind(x_all,y_all, subject_all)

##POINT 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#If we have a look to the full dataset (DO NOT EXECUTE)
#str(full_dataset)
#We see that variables containing averages are named "...-mean..." and for standard deviation are named "-std"
##Selecting columns for subject, activity code and all the variables for mean and std values
##Calling dplyr library
library(dplyr)
tydi_full_dataset <- Merged_Data %>% dplyr::select(subject, code, contains("-mean"), contains("-std"))

##POINT 3. Uses descriptive activity names to name the activities in the data set
#Changing code number for activity label, using numerical value from tydi_full_dataset$code and activities_label dataset
tydi_full_dataset_anotated <- tydi_full_dataset
tydi_full_dataset_anotated$code <- activities_labels[tydi_full_dataset_anotated$code, 2]

##POINT 4. Appropriately labels the data set with descriptive variable names. 
## changing the labels of the data set with descriptive variable names.
colnames(tydi_full_dataset_anotated) <- gsub("-X","_x_axis",
                                             gsub("-Z","_z_axis",
                                                  gsub("-Y","_y_axis",
                                                       gsub("^f", "Frequency",
                                                            gsub("^t", "Time",
                                                                 gsub("Acc","_accelerometer",
                                                                      gsub("Gyro", "_gyroscope",
                                                                           gsub("Mag", "_magnitude",
                                                                                colnames(tydi_full_dataset_anotated)     
                                                                           ))))))))

##POINT 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
tydi_full_dataset_anotated_averages <- tydi_full_dataset_anotated %>%
  group_by(subject, code) %>%
  summarise_all(list(mean = mean))

write.table(tydi_full_dataset_anotated_averages, file = "Train_and_test_datasets_means.txt", row.name = FALSE)
