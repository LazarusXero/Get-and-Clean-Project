---
title: "ReadMe"
author: "David P. Leonard"
date: "Monday, January 19, 2015"
output: html_document
---

# Readme File for Run_Analysis.R Function

The following is an in-depth explanation of the code of the R function for the Getting and Cleaning data course project.  

The first part of the function reads all of the data from the .txt files into descriptive objects.

```
run_analysis <- function(){
        # read in test data from 'x_test.txt'
        test.data <- read.table("x_test.txt")

        # read in test activity numbers from 'y_test.txt'
        test.activity.numbers <- read.table("y_test.txt")
        
        # read in test subject numbers from 'subject_test.txt'
        test.subject.number <- read.table("subject_test.txt")
        
        # read in activity labeles from 'activity_labels.txt'
        activity.labels <- read.table("activity_labels.txt")
        
        # read in feature labels from 'features.txt'
        feature.data <- read.table("features.txt")
        
        # read in training data from 'x_train.txt'
        train.data <- read.table("x_train.txt")
        
        # read in training activity numbers from 'y_train.txt'
        train.activity.numbers <- read.table("y_train.txt")
        
        # read in training subject numbers from 'subject_train.txt'
        train.subject.number <- read.table("subject_train.txt")
```

The next part of the code starts putting together the pieces of the .txt files.  First I add a column for the activity numbers to the beginning of each data set (both test and training data).

```        
        # column bind test and training activity numbers to test and training data
        test.data <- cbind(test.activity.numbers, test.data)
        train.data <- cbind(train.activity.numbers, train.data)
```

Next I add a column of data to the beginning of the data sets containing the subject numbers.

```
        # column bind test and training subject numbers to test and training data
        test.data <- cbind(test.subject.number, test.data)
        train.data <- cbind(train.subject.number, train.data)
```

Next the function will match the column names of the two data sets in order for the `rbind` command to work properly.  Then the datasets are put together using `rbind`.

```
        # match column names and row bind the test and training data together into all.data
        colnames(test.data) <- colnames(train.data)
        all.data <- rbind(test.data, train.data, deparse.level = 0)
```

Next the function creates a vector that will serve as the column names.  Additionally, the string "Avg of" is pasted to each feature label as this will be the column names of the eventual tidy data set containing the average of the mean data and standard deviation data.

```
        # save feature labels to character vector with two additional columns
        # for subject number and activity name
        features <- c("subject.number", "activity.name", paste("Avg of ",as.character(feature.data[,2])))

        # add column names to all.data table
        colnames(all.data) <- features
```

Next, the function will create a vector with all of the column numbers in which the feature name contains the string "mean" or "std".  After found, these vectors will be concatenated and included with the 1, and 2 numbers since I will still need to persist the first two columns as well.

```
        # select the index of features containing the phrase 'mean'
        mean.index <- grep("mean", features)
        
        # select the index of features containing the phrase 'std'
        std.index <- grep("std", features)
        
        # concatenate the mean and std indices with 1 and 2 to keep the subject
        # number and activity type
        feature.index <- c(1, 2, mean.index, std.index)
```
**It is important to note that the features in columns 555 to 561 each contain the string "Mean" but were not collected as part of this.  These columns are measured angles and were not deemed to be mean values to be collected.**

Next, the index is sorted and then a new data set containing only the subject number (column 1), activity number (column 2) and the mean or standard deviation features was created.

```
        # sort the feature index
        feature.index <- sort(feature.index)
        
        # extract the data containing the columns in the feature index
        extracted.data <- all.data[,feature.index]
```
The data set was sorted according to subject number and then activity number.

```
        # sort the extracted data based on subject number and activity type
        sorted.data <- extracted.data[order(extracted.data[,1], extracted.data[,2]),]
```
Next, the function creates a matrix that will be used for the final tidy data set.  It will have 180 rows and 81 columns.  The first two columns will be subject number and activity number and are filled in using `for` loops.  These for loops will create a structure such as this:
```
Subj.No     Act. No.
  1             1
  1             2
  1             3
  1             4
  1             5
  1             6
 ----------------- #Division created to illustrate data breakdown
  2             1
  2             2
  2             3
  2             4
  2             5
  2             6
```
This will allow for one row of means for each combination of subject number and activity number.  The matrix and first to column contents were created using the code below.

```
        # create tidy table structure
        tidy.table <- matrix(nrow = 180, ncol = 81)
        
        # create a vector of subject numbers
        x <- 1
        vec <- vector()
        for(i in 1:30){for(j in 1:6){vec[x] <- i; x <- x + 1}}
        
        # save to column 1 of tidy.table
        tidy.table[,1] <- vec
        
        # create activity number column in tidy.table column 2
        tidy.table[,2] <- rep(1:6, 30)
```
Next, the means were calculated and saved into the matrix using a nested `for` loop.  The x counter is used to count the row numbers, the i counter is for the subject numbers and the j counter is for activity types.  The code takes the column means for each subset of data and all columns containing features (columns 3:81).

```
        # reset row counter
        x <- 1
        
        # start looping to capture and persist mean values
        for(i in 1:30){
                for(j in 1:6){
                        temp <- colMeans(subset(sorted.data, subset = sorted.data[,1] == i & sorted.data[,2] == j, select = 3:81))
                        tidy.table[x,3:81] <- temp; x <- x + 1
                }
        }
```
Next, the function attaches column names and turns the matrix into a `data.frame`.
```
        # attach column names to the new table
        colnames(tidy.table) <- colnames(sorted.data)
        
        # convert to data frame so I can import character data types
        tidy.df <- data.frame(tidy.table)
```
The function then exchanges the activity numbers for their respective activity descriptive labels in the data set (column 2).
```
        # merges the activity name in the activity number table in column 2
        for(i in 1:nrow(tidy.df)){
                tidy.df[i,2] <- as.character(activity.labels[tidy.df[i,2],2])
        
        }
```
Finally, the function outputs the tidy data set to a file named "tidydf.txt" using the `write.table` command.
```
        # write to file 'tidydf.txt'
        write.table(tidy.df, file = "tidydf.txt", row.names = FALSE) 
        }
```        