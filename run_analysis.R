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
        
        # column bind test and training activity numbers to test and training data
        test.data <- cbind(test.activity.numbers, test.data)
        train.data <- cbind(train.activity.numbers, train.data)
        
        # column bind test and training subject numbers to test and training data
        test.data <- cbind(test.subject.number, test.data)
        train.data <- cbind(train.subject.number, train.data)
        
        # match column names and row bind the test and training data together into all.data
        colnames(test.data) <- colnames(train.data)
        all.data <- rbind(test.data, train.data, deparse.level = 0)
        
        # save feature labels to character vector with two additional columns
        # for subject number and activity name
        features <- c("subject.number", "activity.name", paste("Avg of ",as.character(feature.data[,2])))
        
        # add column names to all.data table
        colnames(all.data) <- features
        
        # select the index of features containing the phrase 'mean'
        mean.index <- grep("mean", features)
        
        # select the index of features containing the phrase 'std'
        std.index <- grep("std", features)
        
        # concatenate the mean and std indices with 1 and 2 to keep the subject
        # number and activity type
        feature.index <- c(1, 2, mean.index, std.index)
        
        # sort the feature index
        feature.index <- sort(feature.index)
        
        # extract the data containing the columns in the feature index
        extracted.data <- all.data[,feature.index]
        
        # sort the extracted data based on subject number and activity type
        sorted.data <- extracted.data[order(extracted.data[,1], extracted.data[,2]),]
        
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
        
        # reset row counter
        x <- 1
        
        # start looping to capture and persist mean values
        for(i in 1:30){
                for(j in 1:6){
                        temp <- colMeans(subset(sorted.data, subset = sorted.data[,1] == i & sorted.data[,2] == j, select = 3:81))
                        tidy.table[x,3:81] <- temp; x <- x + 1
                }
        }
        
        # attach column names to the new table
        colnames(tidy.table) <- colnames(sorted.data)
        
        # convert to data frame so I can import character data types
        tidy.df <- data.frame(tidy.table)
        
        # merges the activity name in the activity number table in column 2
        for(i in 1:nrow(tidy.df)){
                tidy.df[i,2] <- as.character(activity.labels[tidy.df[i,2],2])
        
        }
        
        # write to file 'tidydf.txt'
        write.table(tidy.df, file = "tidydf.txt", row.names = FALSE)        
        
}