run_analysis <- function() {
        #=====================Step 1: Merge/union the training and test set into 1 data frame =======================#
        # Load Descriptive DataFrames
        activityLabelsDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
        featuresDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")        
        # Load Test DataFrames
        xTestDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        yTestDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        sTestDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        names(yTestDF)<-"yLabel"
        names(sTestDF)<-"SubjectLabel"
        testDF<-cbind(xTestDF,yTestDF)
        testDF<-cbind(testDF,sTestDF)  
        # Load Train DataFrames
        xTrainDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        yTrainDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        sTrainDF<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
        names(yTrainDF)<-"yLabel"
        names(sTrainDF)<-"SubjectLabel"
        trainDF<-cbind(xTrainDF,yTrainDF)
        trainDF<-cbind(trainDF,sTrainDF)
        
        unionDF<-rbind(trainDF,testDF)
        
        #========================Step 2: Extract only the measurements on the mean and std ===========================#
        # Finding the good/desired fields to include in the final data frame
        desiredFields <- c(grep("-mean",featuresDF$V2),grep("-std",featuresDF$V2))
        desiredFieldsNames<-c("yLabel", "SubjectLabel")
        # Rename column based on the activity label data Frame
        for(i in 1:length(desiredFields)){
                names(unionDF)[desiredFields[i]]<-toString(featuresDF[desiredFields[i],"V2"])
                desiredFieldsNames<-append(desiredFieldsNames, toString(featuresDF[desiredFields[i],"V2"]))
                i=i+1
        }
        # Extract the desired fields
        mainDF<-unionDF[,desiredFieldsNames]
        
        #=====================================Step 3: Use descriptive activity names==================================#
        # Left outer join mainDF with activityLabelsDF
        mainDF<-merge(x=activityLabelsDF, y=mainDF, by.x="V1", by.y="yLabel", all.y = TRUE)
        # Drop the activity key and rename the activity label
        mainDF<-mainDF[,!(names(mainDF) == "V1")]
        names(mainDF)[1]<-"Activity"
        
        #=====================Step 4: Approprietely labels the data set with descriptive var. names ==================#
        names(mainDF)<-sub("-std","_std", names(mainDF))
        names(mainDF)<-sub("-mean","Mean", names(mainDF))
        names(mainDF)<-gsub("-","",names(mainDF))
        names(mainDF)<-gsub("\\(","", names(mainDF))
        names(mainDF)<-gsub("\\)","",names(mainDF))
        
        #===========Step 5: Data set with the average of each variable for each activity and each subject ============#
        library("plyr")
        finalDF<-ddply(x,.(SubjectLabel,Activity),colwise(mean))
        
        #========================================Write the result into txt file=======================================#
        if(file.exists("./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt")){
                file.remove("./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt")
                write.table(finalDF,"./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt",row.names=FALSE)
        }else{
                write.table(finalDF,"./getdata-projectfiles-UCI HAR Dataset/meanBySubjectByActivity.txt",row.names=FALSE)
        }
        
        return (finalDF)
}