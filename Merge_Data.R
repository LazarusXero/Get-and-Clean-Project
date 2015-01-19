merge_data <- function(){
        # move working directory to folder 'Data'
        
        #setwd("Data")
        
        
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
                
        # actions to check code above
        all.data.g <<- all.data
        
}