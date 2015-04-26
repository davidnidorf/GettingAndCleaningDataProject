# For more information on this function, please read the provided README file.
run_Analysis <- function() {
    # First, get the metadata mappings to help us name and understand the raw data
    activityLabels<-read.table("UCIHARDataset/activity_labels.txt", col.names=c("ActivityLabel","Activity"))
    featureLabels<-read.table("UCIHARDataset/features.txt", col.names=c("FeatureLabel","Feature"))
    
    # Note - we could do the below in a loop if there were more than two data sets, 
    # but for the sake of simplicity this script just handles each data set explicitly for now.
    
    # Also note that the dplyr could be used here, but to reduce dependencies this solution
    # only references the base package.
    
    # Get the Test data set
    testData<-read.table("UCIHARDataset/test/X_test.txt")
    testDataActivityLabels<-read.table("UCIHARDataset/test/y_test.txt")
    names(testDataActivityLabels)<-c("ActivityLabel")
    testDataSubjects<-read.table("UCIHARDataset/test/subject_test.txt")
    names(testDataSubjects)<-c("Subject")
    
    # Get the Training data set
    trainingData<-read.table("UCIHARDataset/train/X_train.txt")
    trainingDataActivityLabels<-read.table("UCIHARDataset/train/y_train.txt")
    names(trainingDataActivityLabels)<-c("ActivityLabel")
    trainingDataSubjects<-read.table("UCIHARDataset/train/subject_train.txt")
    names(trainingDataSubjects)<-c("Subject")
    
    # Apply descriptive measurement labels to the data columns
    names(testData)<-featureLabels$Feature
    names(trainingData)<-featureLabels$Feature
    
    # Filter down to the columns which contain mean or standard deviation information
    # Based on the data descriptions this should be any measurement with the sequence "mean()" or "std()" in it.
    meanAndStdColIndicies<-grep("mean[(][])]|std[(][])]", featureLabels[,2])
    testData<-testData[,meanAndStdColIndicies]
    trainingData<-trainingData[,meanAndStdColIndicies]
    
    # Merge the subject names to the data rows
    labelledTestData<-cbind(testDataSubjects, testDataActivityLabels, testData)
    labelledTrainingData<-cbind(trainingDataSubjects, trainingDataActivityLabels, trainingData)
    
    # Merge the two data sets together, by subject (subject values should be unique to each data set)
    mergedData<-merge(labelledTestData, labelledTrainingData, all=TRUE)
    
    # Apply descriptive activity labels to the data rows
    labelledData<-merge(mergedData, activityLabels, by.x="ActivityLabel", by.y="ActivityLabel", sort=FALSE)
    
    # Then drop the Activity raw value in favor of the descriptive name
    tidyData<-labelledData[c(2,ncol(labelledData),4:ncol(labelledData)-1)]
    
    # And do some final modifications on the feature names to make them more human-readable
    names(tidyData)<-gsub("^t", "Time", names(tidyData))
    names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
    names(tidyData)<-gsub("-mean[(][])]", "Mean", names(tidyData))
    names(tidyData)<-gsub("-std[(][])]", "StandardDeviation", names(tidyData))
    names(tidyData)<-gsub("Acc", "Acceleration", names(tidyData))
    names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
    
    # Write out the full tidy data set
    write.table(tidyData,"tidyData_full.txt",row.names=FALSE)
    
    # Create another tidy data set of the averages of each measurement grouped by Subject and Activity
    aggregatedTidyData<-aggregate(tidyData[3:ncol(tidyData)], list(Subject=tidyData$Subject,Activity=tidyData$Activity), mean)
    
    # Write out (and return) the aggregated tidy data set
    write.table(aggregatedTidyData,"tidyData.txt",row.names=FALSE)
    aggregatedTidyData
}