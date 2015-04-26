# "Getting And Cleaning Data" Project
The run_analysis.R script creates a tidy data set from the Samsung wearable study data which can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script generates the tidy data set via the following steps:
1. Extracts the raw data from the Samsung data files into a set of data frames,
2. Merges the data frames together,
3. Filters out all of the measurement data except for the mean and standard deviation of each measurement,
4. Assigns descriptive names to each column,
5. Creates a second, independent tidy data set with the average of the mean and standard deviations as grouped by activity and subject.

More information about the data set can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


License:
========
Note that use of the generated dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
