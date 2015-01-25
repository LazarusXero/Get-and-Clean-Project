---
title: "CodeBook"
author: "David P. Leonard"
date: "Sunday, January 18, 2015"
output: html_document
---
# Getting and Cleaning Data - Codebook
This codebook will describe the methods I used to extract, clean, assemble and analyze the data for the Getting and Cleaning Data Course provided by Coursera.org through Johns Hopkins University.

### Data Details
The details of the data features were taken from the ReadMe file that came with the original data set.  The following is an explanation of the included features:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Final data included in this dataset took the averages of all measured values for the mean and standard deviation data only.

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
