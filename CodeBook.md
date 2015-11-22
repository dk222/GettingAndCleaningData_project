---
title: "Codebook"
output: html_document
---

This is a collection of body motion data obtained from wearable devices.

The data are measurements from accelerometers and gyroscopes contained in Samsung Galaxy S smartphones. Measurements from thirty subjects (given a unique ID 1-30) were taken, and the activity of the subject at the time of the measurement was recorded (activity could be "walking", "walking upstairs", "walking downstairs", "sitting", "standing", or "laying").


 **Each measurement variable is normalized so that its values range from -1 to 1.**
 
### Variable names
 
1. 'Subject' is the subject ID, an integer from 1-30.
2. 'Activity' is the name of the one of six activities being performed at the time of measurement (as listed above).

The rest of the variable names were largely unchanged from the original data set.

1. variables whose names begin with 't' are time domain variables, those beginning with 'f' are frequency domain variables, obtained by fast Fourier transforms.
2. 'Body' measures the motion of the body of the user, 'gravity' measures the component of the acceleration which is due to gravity.
3. 'Acc' refers to measurements of the accelerometer, and 'gyro' to measurements of the gyroscope.
4. 'X', 'Y' and 'Z' refers to the each of the three axes of measurement.
5. 'Mag' measures the magnitude of the three-dimensional vector measured in 'X', 'Y' and 'Z' components.
6. 'Jerk' is the time derivative of the acceleration
7. 'mean' refers to the mean value of the variable over a sample window; measurements taken at 50 Hz, windows of length 2.56 s, so each window contains 128 measurements
8. Similarly, 'std' is the standard deviation and 'meanFreq' the mean frequency over each sample window.

### Changes to Data

The variable names are unchanged from the original names, with the following 2 exceptions:

1. Parentheses were removed ( 'tBodyAcc-std()-X' becomes 'tBodyAcc-std-X')
2. Original variable names had some occurences of 'BodyBody', which were replaced with a single 'Body'

The original data had several statistical measurements for each variable; 'tidy_data.txt' has kept only the means and standard deviations of each variable.

The activity labels were originally numbers 1-6 in the data; we replaced them with the activity names.

Finally, we only record the mean of these variables for each subject and for each activity. Correspondingly, our tidy data contains only 180 rows of observations (30 subjects and 6 activities).
 
