The run_analysis.R scripts, sharing working directory with the UCI HAR Dataset folder, will:

1. Read all pertinent .txt files with the measurement data from test and training subjects, properly naming variable names.

2. Merge test and train subjects dataframes

3. Extracts only the measurements on the mean and standard deviation for each measurement
    Assumption: All columns containing means contain the string "-mean" in their name
    Assumption: All columns containing standard deviation contain the string "-std" in the name
  
4. Uses descriptive activity names to name the activities in the data set
    Variable "code" contains the activity being measured, in the original dataset is coded with numbers, this information is crossed with the information in activity_labels.txt to change numbers for descriptive names.


5. Appropriately labels the data set with descriptive variable names. 
    Variables have obscured names, explained in features_info.txt in the original UCI HAR Dataset.
    With that information, run_analysis.R uses gsub function in the base R to create descriptive names.
      -X gets changed to _x_axis
      -Z gets changed to _z_axis
      -Y gets changed to _y_axis
      f, at the beginning of the name, gets changed to Frequency
      t, at the beginning of the name, gets changed to Time
      Acc gets changed to _accelerometer
      Gyro gets changed to _gyroscope
      Mag gets changed to _magnitude
Those changes were made to make variables inmediately readable and understandable.

6. From the generated tydi dataset, run_analysis.R creates a second, independent tidy data set with the average of each variable for each activity and each subject.
