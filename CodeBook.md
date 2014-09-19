# Code Book for Peer Assessment

## Raw Data Information

The data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available here: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## TidyData

- The feature names (FNames) were read from features.txt
- The activity labels (ALabels) were read from activity_labels.txt, 
  each row has an activity number and an activity label
- The subject, activity and testdata from the test dataset were combined into a single dataframe
  with cbind, and the columns were named with the feature names.
- This was repeated with the train dataset.
- test and train dataframes were combined into a single dataframe and stored as a temporary data frame (tData)
  each row has a subject number, an acivity number and 561 feature observations.
- The columns of feature names containing any words identical to  "Mean", "mean, Std" or, "std" were 
  extracted and the result then stored in a new frame (data) toghether with subject and activity numbers.
- The activity numbers in 'data' are substituted with the more descriptive activity labels.
- All the feature names in 'data' are cleaned up.
- 'data' was then grouped by subject then activity, and the mean was calculated for each feature
  in each group. The result was stored as the data frame 'tidymean'.
