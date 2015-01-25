This script reads in raw data and provides a tidy dataset that produces the average of the variables that contains the mean and std variables in the raw data grouped by subject and activity.

There are five major step in this script:

1. Reads in the various data from the raw data set. The data had to be merged based on rows and then the test data and the train data had to be set together.
2. only keep the variables that contain the mean and standard deviation in the variable names (contains mean() or std())
3. rename the activity variable to the activity label
4. rename the variable names to a more descriptive label
5. calculate the average of each variable for each subject and activity group

The raw data contains many files that are used:
1. X_test and X_train-these contain all the measurements for each subject and activity
2. Y_test and Y_train-these contain the activity ids for each row
3. subject_test and subject_train-these contain the subject ids for each row
4. activity_labels-this maps the activity ids (#2) to the activity labels
5. features-contains the variable names for #1

*For step #1 we have to merge #1, #2, #3 together by rows. We also need to rename the variable names from features to the data from #1.
*For step #3 we add the activity_labels based on the activity id from the data created from the previous step.


The resulting data set contains the following data set:

*Subject_id-the id of each subject
*activity_label-the descriptions of each activity
*all the averages of the means and std of the raw data (68 variables containing mean() or std())

