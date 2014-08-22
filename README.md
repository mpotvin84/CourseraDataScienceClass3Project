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

Considering only the column names containing the words "-std" or "-mean". The following variable were retain:

1. SubjectLabel
2.	Activity
3.	tBodyAccMeanX
4.	tBodyAccMeanY
5.	tBodyAccMeanZ
6.	tGravityAccMeanX
7.	tGravityAccMeanY
8.	tGravityAccMeanZ
9.	tBodyAccJerkMeanX
10.	tBodyAccJerkMeanY
11.	tBodyAccJerkMeanZ
12.	tBodyGyroMeanX
13.	tBodyGyroMeanY
14.	tBodyGyroMeanZ
15.	tBodyGyroJerkMeanX
16.	tBodyGyroJerkMeanY
17.	tBodyGyroJerkMeanZ
18.	tBodyAccMagMean
19.	tGravityAccMagMean
20.	tBodyAccJerkMagMean
21.	tBodyGyroMagMean
22.	tBodyGyroJerkMagMean
23.	fBodyAccMeanX
24.	fBodyAccMeanY
25.	fBodyAccMeanZ
26.	fBodyAccMeanFreqX
27.	fBodyAccMeanFreqY
28.	fBodyAccMeanFreqZ
29.	fBodyAccJerkMeanX
30.	fBodyAccJerkMeanY
31.	fBodyAccJerkMeanZ
32.	fBodyAccJerkMeanFreqX
33.	fBodyAccJerkMeanFreqY
34.	fBodyAccJerkMeanFreqZ
35.	fBodyGyroMeanX
36.	fBodyGyroMeanY
37.	fBodyGyroMeanZ
38.	fBodyGyroMeanFreqX
39.	fBodyGyroMeanFreqY
40.	fBodyGyroMeanFreqZ
41.	fBodyAccMagMean
42.	fBodyAccMagMeanFreq
43.	fBodyBodyAccJerkMagMean
44.	fBodyBodyAccJerkMagMeanFreq
45.	fBodyBodyGyroMagMean
46.	fBodyBodyGyroMagMeanFreq
47.	fBodyBodyGyroJerkMagMean
48.	fBodyBodyGyroJerkMagMeanFreq
49.	tBodyAccStdX
50.	tBodyAccStdY
51.	tBodyAccStdZ
52.	tGravityAccStdX
53.	tGravityAccStdY
54.	tGravityAccStdZ
55.	tBodyAccJerkStdX
56.	tBodyAccJerkStdY
57.	tBodyAccJerkStdZ
58.	tBodyGyroStdX
59.	tBodyGyroStdY
60.	tBodyGyroStdZ
61.	tBodyGyroJerkStdX
62.	tBodyGyroJerkStdY
63.	tBodyGyroJerkStdZ
64.	tBodyAccMagStd
65.	tGravityAccMagStd
66.	tBodyAccJerkMagStd
67.	tBodyGyroMagStd
68.	tBodyGyroJerkMagStd
69.	fBodyAccStdX
70.	fBodyAccStdY
71.	fBodyAccStdZ
72.	fBodyAccJerkStdX
73.	fBodyAccJerkStdY
74.	fBodyAccJerkStdZ
75.	fBodyGyroStdX
76.	fBodyGyroStdY
77.	fBodyGyroStdZ
78.	fBodyAccMagStd
79.	fBodyBodyAccJerkMagStd
80.	fBodyBodyGyroMagStd
81.	fBodyBodyGyroJerkMagStd

####3. Uses descriptive activity names to name the activities in the data set

Using a right outer join with the y_test/y_train.

####4. Appropriately labels the data set with descriptive variable names. 

Based on the Activity Label data set names, transforming them into the camelCase writing convention plus by removing undesired punctuation such as "(", ")", "-", etc. See Step 2.

####5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

The "plyr" package was used, grouping by the activity names and by subject.