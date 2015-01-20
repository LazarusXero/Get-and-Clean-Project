---
title: "CodeBook"
author: "David P. Leonard"
date: "Sunday, January 18, 2015"
output: html_document
---
# Getting and Cleaning Data - Codebook
This codebook will describe the methods I used to extract, clean, assemble and analyze the data for the Getting and Cleaning Data Course provided by Coursera.org through Johns Hopkins University.

### Reading the Data

All data is being extracted from text files provided at the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract the ZIP file contents and (**!!VERY IMPORTANT!!**) place the following files into the **same directory** as the "merge_data.R"" file:

1. *subject_test.txt* - contains the test subject numbers for each observation of the test group
2. *y_test.txt* - contains the activity numbers for each observation of the test group
3. *x_test.txt* - contains all of the feature data observations for the test group
4. *subject_train.txt* - contains the test subject numbers for each observation of the test group
5. *y_train.txt* - contains the activity numbers for each observation of the training group
6. *x_train.txt* - contains all of the feature data observations for the training group
7. *features.txt* - contains the names of each feature measured

### Assembling the Data

The `merge_data()` function will extract the data from the text files using the `read.table` command.  Once extracted, the function will use the `cbind` command to attach the activity numbers to each data set (test and training) and then also `cbind` the subject numbers to the data sets.

Once each data set has the subject numbers and activity numbers attached, the column names of each of the two data sets are matched and the data sets are bound together using the `rbind` command.  

Next, the official column names are appended to the completed data set using the `colnames` command with the string "Avg of" pasted to the columns of sensor data (column 3 onward).

### Extracting the Useful Data

Once the data set is finally combined, the columns containing the string "mean" and "std" are found and indexed using the `grep` command.  In the complete data set though, columns 555 to 561 each contained the string "Mean", but since these were actually measurements of angle, they were **NOT** collected.

The index vector is used to extract the subset of data and save to a new table and finally sorted using the `sort` command.

### Creating the Tidy Data Set

Now that all of the data is collected, processed and sorted, I set up a new `matrix` that will be the foundation of the final tidy data set.  This is constructed having 180 rows and 81 columns and the first two columns (subject.numbers and activity.numbers respectively) are filled using `for` loops.

Next, the means of data subsets are determined and persisted to the appropriate areas within the matrix.  This is done using a nested `for` loop with a row counter.  The column names from the original full data set is appended to the matrix and then it is converted to a `data.frame`.  This is due to the fact that the activity labels will be used instead of integers in column 2 and a matrix cannot handle two types of data.  

A quick `for` loop is used to save the activity labels over their corresponding numbers in column 2 and then the final tidy data set is written to "tidydf.txt" using the `write.table` command.
