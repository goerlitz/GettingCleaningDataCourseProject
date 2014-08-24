# features   - names of 561 features
#              (561 obs. of  2 variables: V1 = index, V2 = feature label)
# activities - names of 6 activities
#              (6 obs. of  2 variables: V1 = index, V2 = activity label)
#
# train and test dataset with 7352 and 2947 entries respectively
#
# *_data     - datasets with all 561 features
#              (7352/2947 obs. of  561 variables)
# *_labl     - activity label for each dataset (6 activities)
#              (7352/2947 obs. of  1 variable)
# *_subj     - subject label for each dataset (30 subjects)
#              (7352/2947 obs. of  1 variable)

# load all data
features   <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labl <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_data  <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labl  <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subj  <- read.table("UCI HAR Dataset/test/subject_test.txt")

# combine training and test data
data <- rbind(train_data, test_data)
labl <- rbind(train_labl, test_labl)
subj <- rbind(train_subj, test_subj)

# use descriptive variable names
names(data) <- features$V2
names(subj) <- c("subject")
names(activities) <- c("V1", "activity")

# restrict to mean and deviation features
meanOrStd_logical <- sapply(c("mean", "std"), grepl, features[,2], ignore.case=TRUE)
selected_features <- features[meanOrStd_logical[,1] | meanOrStd_logical[,2], 1]
data <- data[selected_features]

# combine all data in one data frame
data <- cbind(subj, labl, data)

# replace activity index with labels
data <- merge(activities, data)
last <- length(names(data))
data <- data[,c(3,2,4:last)] # reorder subject and activity

# compute means on features for each subject/activity combination
library(plyr)
means = ddply(data, c("subject","activity"), function(x) colMeans(x[3:88]))

write.table(means, "feature_average.txt", row.names = FALSE)
