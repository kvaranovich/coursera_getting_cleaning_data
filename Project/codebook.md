Codebook
================

Codebook - Getting and Cleaning Data
====================================

Kiryl Varanovich

### Description

This is a codebook describing all the variables in the final dataset. The raw data comes from **UCI - Machine Learning Repository**. For more information about data processing steps and data sources, please refer to `readme.md` and `run_analysis.R` in this repository.

### Source Data

Please refer to: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#>

### Dataset Characteristics

-   Observations: 10299;
-   Variables: 88;
-   Size: 10506 KB;
-   Missing values: None;
-   Date of creation: 2018-09-09.

### Variables

-   ACTIVITY
    -   STANDING
    -   WALKING
    -   WALKING\_UPSTAIRS
    -   WALKING\_DOWNSTAIRS
    -   SITTING
    -   LAYING
-   ID\_SUBJECT - id of a volunteer
    -   \[1-30\]

### How to read data:

All other variables contain measurements which are represented as floating-point values, normalised and bounded within \[-1,1\].

-   ACC stands for accelerometer;
-   GYRO stands for gyroscope;
-   MEAN stands for average/mean values;
-   STD stands for standard deviation;
-   GRAVITY - gravitational component of acceleration signal;
-   BODY - mody motion component of acceleration signal;
-   MAG - magnitude;
-   JERK - jerk signals;
-   X, Y, Z - axises.

### List of measurement variables

-   TIME\_BODY\_ACC\_MEAN\_X
-   TIME\_BODY\_ACC\_MEAN\_Y
-   TIME\_BODY\_ACC\_MEAN\_Z
-   TIME\_BODY\_ACC\_STD\_X
-   TIME\_BODY\_ACC\_STD\_Y
-   TIME\_BODY\_ACC\_STD\_Z
-   TIME\_GRAVITY\_ACC\_MEAN\_X
-   TIME\_GRAVITY\_ACC\_MEAN\_Y
-   TIME\_GRAVITY\_ACC\_MEAN\_Z
-   TIME\_GRAVITY\_ACC\_STD\_X
-   TIME\_GRAVITY\_ACC\_STD\_Y
-   TIME\_GRAVITY\_ACC\_STD\_Z
-   TIME\_BODY\_ACC\_JERK\_MEAN\_X
-   TIME\_BODY\_ACC\_JERK\_MEAN\_Y
-   TIME\_BODY\_ACC\_JERK\_MEAN\_Z
-   TIME\_BODY\_ACC\_JERK\_STD\_X
-   TIME\_BODY\_ACC\_JERK\_STD\_Y
-   TIME\_BODY\_ACC\_JERK\_STD\_Z
-   TIME\_BODY\_GYRO\_MEAN\_X
-   TIME\_BODY\_GYRO\_MEAN\_Y
-   TIME\_BODY\_GYRO\_MEAN\_Z
-   TIME\_BODY\_GYRO\_STD\_X
-   TIME\_BODY\_GYRO\_STD\_Y
-   TIME\_BODY\_GYRO\_STD\_Z
-   TIME\_BODY\_GYRO\_JERK\_MEAN\_X
-   TIME\_BODY\_GYRO\_JERK\_MEAN\_Y
-   TIME\_BODY\_GYRO\_JERK\_MEAN\_Z
-   TIME\_BODY\_GYRO\_JERK\_STD\_X
-   TIME\_BODY\_GYRO\_JERK\_STD\_Y
-   TIME\_BODY\_GYRO\_JERK\_STD\_Z
-   TIME\_BODY\_ACC\_MAG\_MEAN
-   TIME\_BODY\_ACC\_MAG\_STD
-   TIME\_GRAVITY\_ACC\_MAG\_MEAN
-   TIME\_GRAVITY\_ACC\_MAG\_STD
-   TIME\_BODY\_ACC\_JERK\_MAG\_MEAN
-   TIME\_BODY\_ACC\_JERK\_MAG\_STD
-   TIME\_BODY\_GYRO\_MAG\_MEAN
-   TIME\_BODY\_GYRO\_MAG\_STD
-   TIME\_BODY\_GYRO\_JERK\_MAG\_MEAN
-   TIME\_BODY\_GYRO\_JERK\_MAG\_STD
-   FREQ\_BODY\_ACC\_MEAN\_X
-   FREQ\_BODY\_ACC\_MEAN\_Y
-   FREQ\_BODY\_ACC\_MEAN\_Z
-   FREQ\_BODY\_ACC\_STD\_X
-   FREQ\_BODY\_ACC\_STD\_Y
-   FREQ\_BODY\_ACC\_STD\_Z
-   FREQ\_BODY\_ACC\_MEAN\_FREQ\_X
-   FREQ\_BODY\_ACC\_MEAN\_FREQ\_Y
-   FREQ\_BODY\_ACC\_MEAN\_FREQ\_Z
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_X
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_Y
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_Z
-   FREQ\_BODY\_ACC\_JERK\_STD\_X
-   FREQ\_BODY\_ACC\_JERK\_STD\_Y
-   FREQ\_BODY\_ACC\_JERK\_STD\_Z
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_FREQ\_X
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_FREQ\_Y
-   FREQ\_BODY\_ACC\_JERK\_MEAN\_FREQ\_Z
-   FREQ\_BODY\_GYRO\_MEAN\_X
-   FREQ\_BODY\_GYRO\_MEAN\_Y
-   FREQ\_BODY\_GYRO\_MEAN\_Z
-   FREQ\_BODY\_GYRO\_STD\_X
-   FREQ\_BODY\_GYRO\_STD\_Y
-   FREQ\_BODY\_GYRO\_STD\_Z
-   FREQ\_BODY\_GYRO\_MEAN\_FREQ\_X
-   FREQ\_BODY\_GYRO\_MEAN\_FREQ\_Y
-   FREQ\_BODY\_GYRO\_MEAN\_FREQ\_Z
-   FREQ\_BODY\_ACC\_MAG\_MEAN
-   FREQ\_BODY\_ACC\_MAG\_STD
-   FREQ\_BODY\_ACC\_MAG\_MEAN\_FREQ
-   FREQ\_BODY\_BODY\_ACC\_JERK\_MAG\_MEAN
-   FREQ\_BODY\_BODY\_ACC\_JERK\_MAG\_STD
-   FREQ\_BODY\_BODY\_ACC\_JERK\_MAG\_MEAN\_FREQ
-   FREQ\_BODY\_BODY\_GYRO\_MAG\_MEAN
-   FREQ\_BODY\_BODY\_GYRO\_MAG\_STD
-   FREQ\_BODY\_BODY\_GYRO\_MAG\_MEAN\_FREQ
-   FREQ\_BODY\_BODY\_GYRO\_JERK\_MAG\_MEAN
-   FREQ\_BODY\_BODY\_GYRO\_JERK\_MAG\_STD
-   FREQ\_BODY\_BODY\_GYRO\_JERK\_MAG\_MEAN\_FREQ
-   ANGLET\_BODY\_ACC\_MEAN\_GRAVITY
-   ANGLET\_BODY\_ACC\_JERK\_MEAN\_GRAVITY\_MEAN
-   ANGLET\_BODY\_GYRO\_MEAN\_GRAVITY\_MEAN
-   ANGLET\_BODY\_GYRO\_JERK\_MEAN\_GRAVITY\_MEAN
-   ANGLE\_X\_GRAVITY\_MEAN
-   ANGLE\_Y\_GRAVITY\_MEAN
-   ANGLE\_Z\_GRAVITY\_MEAN
