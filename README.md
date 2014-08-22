##ReadME

#Purpose

Coursera > Data Science > Getting and Cleaning Data in R > Course Project

In here, I will explain how to successfully use the "run_analysis.R" script in R. I will also provide a short explanation for each of the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#How it works

The final crosstab data frame was made using the plyr package. Please install the following package before getting started:

    install.packages("plyr").

The Samsung files must be in your main directory. For example, this should be the path for the X\_train.txt:

    ./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X\_train.txt

To successfully run the package, simply run the following command in R:

     run_analysis()

No variable needed. The script will push a txt file in the following location:

     ./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt


If you don't want that, simply delete the following command in the run_analysis.R:

     #========================================Write the result into txt file=======================================#
        if(file.exists("./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt")){
                file.remove("./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt")
                write.table(finalDF,"./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt",row.names=FALSE)
        }else{
                write.table(finalDF,"./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt",row.names=FALSE)
        }

#Steps
####1. Merges the training and the test sets to create one data set.

Nothing Special. Loading activities and row + column binding related tasks..

####2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Considering only the column names containing the words "-std" or "-mean"

####3. Uses descriptive activity names to name the activities in the data set

Using a right outer join with the y_test/y_train.

####4. Appropriately labels the data set with descriptive variable names. 

Based on the Activity Label data set names, transforming them into the camelCase writing convention plus by removing undesired punctuation such as "(", ")", "-", etc.

####5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

The "plyr" package was used, grouping by the activity names and by subject.
