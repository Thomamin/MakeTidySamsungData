Run_analysis.R to make a tidy data set from the course project provided UCI HAR Dataset
========================================================
This document is describing how the script 'Run_analysis.R' works.
To run 'run_analysis.R', download 'run_analysis.R' to '/UCI HAR Dataset' folder


**Step 1. Read files**

```r
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")
```


**Step 2. Bind train and test data**

```r
X_bind <- rbind(X_test, X_train)
Y_bind <- rbind(Y_test, Y_train)
```


**Step 3. Set column names using data from 'features.txt' **

```r
colnames(X_bind) <- features[, 2]
```


**Step 4. Add 'Label' column **

```r
X_bind$Label <- Y_bind[, 1]
```


**Step 5. Find 'mean()' and 'std()' column names only **

```r
ptn = "mean()"
ndx = grep(ptn, features$V2, perl = T)
selected_means <- features[ndx, ]
ptn = "std()"
ndx = grep(ptn, features$V2, perl = T)
selected_stds = features[ndx, ]
selected_features <- rbind(selected_means, selected_stds)
selected_features2 <- selected_features[, 2]
```


**Step 6. Subset means, stds, and Label **

```r
X_bind2 <- subset(X_bind, select = as.character(selected_features2))
X_bind2$Label <- X_bind$Label
```


**Step 7. Labels with activity name **

```r
TidyData = merge(x = X_bind2, y = activity_labels, by.x = "Label", by.y = "V1", 
    all.x = TRUE)
colnames(TidyData)[ncol(TidyData)] <- "Activity"
```


**Step 7. Write to file **

```r
save(TidyData, file = "./TidyData.Rda")
```

