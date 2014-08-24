GettingCleaningDataCourseProject
================================

There is a single script 'run_analysis.R' which performs following tasks on the UCI HAR data:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

* load and merge training and test set into a single data frame
* lable the dataset according to the features labels of the original data
* extract only the mean and standard deviation for each feature
* compute the mean for each feature and subject/activity combination
* save the data to 'feature_average.txt'
