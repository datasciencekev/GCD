#Course project for Getting and Cleaning Data
#2014-10-22

#read in the column Names
features <- read.table("UCI HAR Dataset\\features.txt")

#Read in the Training data - features, labels, and subjects
#Note the samsung data is in my working directory, in its original file structure
training <- read.table("UCI HAR Dataset\\train\\X_train.txt")
trainingLabels <- read.table("UCI HAR Dataset\\train\\y_train.txt")
trainingSubject <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
colnames(trainingLabels) <- "Activity"
colnames(trainingSubject) <- "Subject"

#Read in the Test data - features, labels, and subjects

test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
testLabels <- read.table("UCI HAR Dataset\\test\\y_test.txt")
testSubject <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
colnames(testLabels) <- "Activity"
colnames(testSubject) <- "Subject"

#give the both sets some decent names
colnames(training) <- features[,2]
colnames(test) <- features[,2]

#combine features, labels and subjects
test <- cbind(test, testLabels, testSubject)
training <- cbind (training, trainingLabels, trainingSubject)

#combine Training and Test data
totalData <- rbind (training, test)

#name the labels better.  I'm sure there's a better way to do this with factor() but this worked well enough.
totalData[totalData$Activity == 1,562] <- "Walking"
totalData[totalData$Activity == 2,562] <- "Walking Upstairs"
totalData[totalData$Activity == 3,562] <- "Walking Downstairs"
totalData[totalData$Activity == 4,562] <- "Sitting"
totalData[totalData$Activity == 5,562] <- "Standing"
totalData[totalData$Activity == 6,562] <- "Lying"

#get lists of the mean and std dev columns
means <- grep("mean", features[,2], perl=T)
stds <- grep("std", features[,2], perl=T)

#extract means, std dev, activiy and subject
summaryData <- cbind(totalData[,means], totalData[,stds], Activity = totalData[,"Activity"], Subject = totalData[,"Subject"])

#calculate means by activity and subject
finalData <- aggregate(x = summaryData[, 1:(ncol(summaryData)-2)], by = list(Activity = summaryData$Activity, Subject = summaryData$Subject), FUN = "mean")

write.table(finalData, "output.txt", row.names = FALSE)