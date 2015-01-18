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
        
        
        
        # actions to check code above
        print(unique(train.activity.numbers))
        
        
}