---
title: "README"
output: html_document
---

The data consists of measurements from accelerometers and gyroscopes worn by subjects (with unique IDs numbered 1-30) while performing 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing and laying). A detailed description of the variables can be found in 'codebook.md'. 

The script first reads in the relevant data, and creates data frames for the training set and test set data. To both these data frames, we add the variable names coming from the feature list. Then these two data frames are merged into one which contains all of the observations.

We then select only variables which are measuring the mean or standard deviation of some quantity, and provide cleaner names for these variables, as described in 'codebook.md'.

We then form the data frame 'distData', which is the subset of 'allData' which contains only the information on the distribution of each variable (mean and std. deviation). We add two columns, one containing the subject ID for each observation, and one containing the activity label for each observation.

The various activities were given integer labels 1-6; in our data frame we replace these integers by the names of each activity. 

To create our tidy data set, we create 'AvgData' by taking the mean of each variable for each combination of subject and activity. That is, we find the mean of each variable recorded when subject number 1 was walking,  and then walking downstairs, and so on, and the same for each of the 30 subjects.

Finally, this tidy data set is saved as a text file 'tidy_data.txt'.
