This script reads in raw data and provides a tidy dataset that produces the average of the variables that contains the mean and std variables in the raw data grouped by subject and activity.

There are five major step in this script:

1. Reads in the various data from the raw data set. The data had to be merged based on rows and then the test data and the train data had to be set together.
2. only keep the variables that contain the mean and standard deviation in the variable names (contains mean() or std())
3. rename the activity variable to the activity label
4. rename the variable names to a more descriptive label
5. calculate the average of each variable for each subject and activity group

The resulting data set contains the following data set:

*Subject_id-the id of each subject
