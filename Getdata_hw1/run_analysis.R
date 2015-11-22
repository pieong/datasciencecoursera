library(dplyr)
setwd("~/Desktop/UCI\ HAR\ Dataset/")

test <- read.table("test/X_test.txt")
train <- read.table("train/X_train.txt")

colname <- read.table("features.txt")[,2]
colname <- as.character(colname)
names(train) <- colname
names(test) <- colname

test_action <- read.table("test/y_test.txt")
test$action <- test_action[,1]
train_action <- read.table("train/y_train.txt")
train$action <- train_action[,1]

test_subject <- read.table("test/subject_test.txt")
test$Subjects <- test_subject[,1]
train_subject <- read.table("train/subject_train.txt")
train$Subjects <- train_subject[,1]

combined_data <- rbind(train, test)

mean <- combined_data[grep("mean()", names(combined_data))]
mean <- mean[-grep("meanFreq()", names(mean))]
std <- combined_data[grep("std", names(combined_data))]
mean_std <- cbind(mean,std, combined_data$Subjects, combined_data$action)
mean_std <- mean_std[, sort(colnames(mean_std))]
names(mean_std)[1] <- "Actions"
names(mean_std)[2] <- "Subjects"
write.table(mean_std, file = "tidy_data_mean_std.txt")

means <- cbind(mean_std$Actions, mean_std$Subjects, mean_std[grep("mean()", names(mean_std))])
names(means) <- c("Actions", "Subjects", "fbodyacc.x", "fbodyacc.y", "fbodyacc.z", "fbodyaccjerk.x", 
                  "fbodyaccjerk.y", "fbodyaccjerk.z", "fbodyaccmag", "fbodyaccjerkmag", "fbodygyrojerkmag", 
                  "fbodygyromag", "fbodygyro.x", "fbodygyro.y", "fbodygyro.z", "tbodyacc.x", "tbodyacc.y", 
                  "tbodyacc.z", "tbodyAccjerk.x", "tbodyAccjerk.y", "tbodyAccjerk.z", "tbodyaccjerkmag", 
                  "tbodyaccmag", "tbodygyro.x", "tbodygyro.y", "tbodygyro.z", "tbodygyrojerk.x", 
                  "tbodygyrojerk.y", "tbodygyrojerk.z", "tbodygyrojerkmag", "tbodygyromag", "tgravityacc.x", 
                  "tgravityacc.y", "tgravityacc.z", "tgravityaccmag")

means <- group_by(means, Actions, Subjects)
tidy_mean <- summarize(means, mean(fbodyacc.x), mean(fbodyacc.y), mean(fbodyacc.z), mean(fbodyaccjerk.x), 
                       mean(fbodyaccjerk.y), mean(fbodyaccjerk.z), mean(fbodyaccmag), mean(fbodyaccjerkmag), 
                       mean(fbodygyrojerkmag), mean(fbodygyromag), mean(fbodygyro.x), mean(fbodygyro.y), 
                       mean(fbodygyro.z), mean(tbodyacc.x), mean(tbodyacc.y), mean(tbodyacc.z), mean(tbodyAccjerk.x), 
                       mean(tbodyAccjerk.y), mean(tbodyAccjerk.z), mean(tbodyaccjerkmag), mean(tbodyaccmag), 
                       mean(tbodygyro.x), mean(tbodygyro.y), mean(tbodygyro.z), mean(tbodygyrojerk.x), 
                       mean(tbodygyrojerk.y), mean(tbodygyrojerk.z), mean(tbodygyrojerkmag), mean(tbodygyromag), 
                       mean(tgravityacc.x), mean(tgravityacc.y), mean(tgravityacc.z), mean(tgravityaccmag))
write.table(tidy_mean, file="tidy_mean.txt", row.names=FALSE)