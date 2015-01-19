---
title: "CodeBook"
author: "David P. Leonard"
date: "Sunday, January 18, 2015"
output: html_document
---
# Getting and Cleaning Data - Codebook
This codebook will describe the methods I used to extract, clean, assemble and analyze the data for the Getting and Cleaning Data Course provided by Coursera.org through Johns Hopkins University.


## <u>My Data</u>

### Extracting the Data

All data is being extracted from text files provided at the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract the ZIP file contents and (**!!VERY IMPORTANT!!**) place the following files into the **same directory** as the "merge_data.R"" file:

1. subject_test.txt
2. y_test.txt
3. x_test.txt
4. subject_train.txt
5. y_train.txt
6. x_train.txt
7. features.txt

### Cleaning the Data

### Assembling the Data

### Analyzing the Data


## My Scripts

### Merge_Data.R Function

Here is the code for my merge_data.R function:

```        
        merge_data <- function(){
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
        
        # merges the activity name in the activity number table in column 2
        for(i in 1:nrow(test.activity.numbers)){
                test.activity.numbers[i,2] <- activity.labels[test.activity.numbers[i,1],2]
        }
                
        # read in training data from 'x_train.txt'
        train.data <- read.table("x_train.txt")
        
        # read in training activity numbers from 'y_train.txt'
        train.activity.numbers <- read.table("y_train.txt")
        
        # read in training subject numbers from 'subject_train.txt'
        train.subject.number <- read.table("subject_train.txt")
        
        # merges the activity name in the activity number table in column 2
        for(i in 1:nrow(train.activity.numbers)){
                train.activity.numbers[i,2] <- activity.labels[train.activity.numbers[i,1],2]
        }
        
        # column bind test and training activity names to test and training data
        test.data <- cbind(test.activity.numbers[,2], test.data)
        train.data <- cbind(train.activity.numbers[,2], train.data)
        
        # column bind test and training subject numbers to test and training data
        test.data <- cbind(test.subject.number, test.data)
        train.data <- cbind(train.subject.number, train.data)
        
        # match column names and row bind the test and training data together into all.data
        colnames(test.data) <- colnames(train.data)
        all.data <- rbind(test.data, train.data, deparse.level = 0)
        
        # save feature labels to character vector with two additional columns
        # for subject number and activity name
        features <- c("subject.number", "activity.name", as.character(feature.data[,2]))
        
        # add column names to all.data table
        colnames(all.data) <- features
        
        ############### end of part 1 from the course project #######################
                
        }
```





---
This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
