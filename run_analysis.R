library(dplyr)
##READ IN ALL DATASET##
x_test<-read.table("./test/X_test.txt") #read in test data
y_test<-read.table("./test/y_test.txt") #read in activity group for test data
subject_test<-read.table("./test/subject_test.txt") #read in subject group for test data

x_train<-read.table("./train/X_train.txt") #read in train data
y_train<-read.table(".//train/y_train.txt") #read in activity group for train data
subject_train<-read.table("./train/subject_train.txt") #read in subject group for train data

activity_labels<-read.table("./activity_labels.txt") #read in activity descriptions
features<-read.table("./features.txt") #read in variable names

##ATTACH VAR NAMES TO DATA SET##
names_vector <- features[,2]  # first column - numbers, second column - names
colnames(x_test) <- make.names(names_vector, unique=TRUE)
colnames(x_train) <- make.names(names_vector, unique=TRUE)
#names(x_test) <- names_vector # add variable names to the x_test data
#names(x_train) <- names_vector# add variable names to the x_train data
subject_test<-rename(subject_test,subject_id=V1) # rename v1 to subject_id
subject_train<-rename(subject_train,subject_id=V1) # rename v1 to subject_id
activity_labels<-rename(activity_labels,activity_group=V1,activity_name=V2) #rename activity list variables
y_test<-rename(y_test,activity_group=V1)
y_train<-rename(y_train,activity_group=V1)

##STEP 1: MERGE DATA##
train_merge<-cbind(subject_train,y_train,x_train)
test_merge<-cbind(subject_test,y_test,x_test)
combined<-rbind(train_merge,test_merge)

##STEP 2: EXTRACT VARIABLES WITH MEAN AND STD##
combined2<-select(combined,subject_id,activity_group,contains("mean.."),contains("std.."))

##STEP 3: ADD DESCRIPTIVE NAMES TO ACTIVITY##
combined3<-merge(activity_labels,combined2,by.x="activity_group",by.y="activity_group")
combined3<-select(combined3,-contains("activity_group"))
##STEP 4: RENAME VARIABLE NAMES##
names(combined3)<-gsub("tBody","time.Body.",names(combined3))
names(combined3)<-gsub("tGravity","time.Gravity.",names(combined3))
names(combined3)<-gsub("fBody","frequency.Domain.Body.",names(combined3))
names(combined3)<-gsub("fGravity","frequency.Domain.Gravity.",names(combined3))
names(combined3)<-gsub("Acc","Acceleration.Signals",names(combined3))
names(combined3)<-gsub("Jerk",".Jerk.Signals",names(combined3))
names(combined3)<-gsub("Gyro","Gyroscope",names(combined3))
names(combined3)<-gsub(".X",".X.Axis",names(combined3))
names(combined3)<-gsub(".Y",".Y.Axis",names(combined3))
names(combined3)<-gsub(".Z",".Z.Axis",names(combined3))
names(combined3)<-gsub("Mag",".Magnitude",names(combined3))
names(combined3)<-gsub("mean..","mean",names(combined3))
names(combined3)<-gsub("std..","std",names(combined3))

##STEP 5: AVERAGE OF EACH ACTIVITY AND SUBJECT##
final_output<-combined3%>%
  group_by(subject_id,activity_name)%>%
  summarise_each(funs(mean))

##OUTPUT DATA TO TXT##
write.table(final_output,file="./tidy_dataset.txt",row.name=FALSE)
