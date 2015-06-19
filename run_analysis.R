library(plyr)

# Load in the training features and test features data
train_561 <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
test_561 <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")

# Load in the training and test activity ids
train_activity <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
test_activity <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

# Load in the training and test subject ids 
train_subject <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
test_subject <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

# Load in the activity names and features names datasets
names_activity <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
names_features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"", comment.char="")

# Merged the training and test feature datasets and name the features from the feature names dataset 
merged_561 = rbind(train_561,test_561)
names(merged_561) = names_features$V2

# Merge the training and test subject ids 
merged_subject = rbind(train_subject,test_subject)
names(merged_subject) = "subject.id"

# Merge the training and test activity ids 
merged_activity = rbind(train_activity,test_activity)

# Give column name to the column in the merged dataset as activity id
names(merged_activity) = "activity.id"

# Add a column to the id table with the names
merged_activity$activity.name = names_activity[merged_activity[,1],2]

# The final dataset will be a cbind of the subjectid, activity id, activity names and the 561 features 
final.full.dataset = cbind(merged_subject,merged_activity,merged_561)

# Get the indexes of the columns that have mean or std in the column name 
mean_names = grep("mean",names_features$V2,ignore.case = TRUE)
std_names = grep("std",names_features$V2,ignore.case = TRUE)

# Bind along these with cols 1 to 3 containing the subject and activity info
initials_mean_std_names = sort(c(1:3,mean_names+3,std_names+3))

# Extract only those columns. Tidy dataset required in step 2
only.mean.std.dataset = final.full.dataset[,initials_mean_std_names]


# Tidy dataset required in step 5. For each grouping of subject and activity, the column means are taken out
averages_dataset = ddply(only.mean.std.dataset,.(subject.id,activity.id,activity.name),function(x){colMeans(only.mean.std.dataset[,4:89])})

#Write the dataset into a comma separated text file
write.table(averages_dataset,"./averages_dataset.txt",sep=",",col.names = TRUE,row.names = FALSE)
