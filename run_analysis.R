
#read files
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

#bind train and test data
X_bind <- rbind(X_test, X_train)
Y_bind <- rbind(Y_test, Y_train)
#set column name
colnames(X_bind) <- features[,2]
#add label column
X_bind$Label <- Y_bind[,1]

#Find 'mean()' and 'std()' rows
ptn = 'mean()'
ndx = grep(ptn, features$V2, perl=T)
selected_means <- features[ndx,]
ptn = 'std()'
ndx = grep(ptn, features$V2, perl=T)
selected_stds = features[ndx,]
selected_features <- rbind(selected_means,selected_stds)
selected_features2 <- selected_features[,2]

#subset Label,means, and stds only
X_bind2 <- subset(X_bind, select=as.character(selected_features2))
X_bind2$Label <- X_bind$Label

#Labels with activity name
TidyData = merge(x = X_bind2, y = activity_labels, by.x = "Label", by.y = "V1", all.x=TRUE)
colnames(TidyData)[ncol(TidyData)] <- "Activity"

#write to file
save(TidyData, file = "./TidyData.Rda")