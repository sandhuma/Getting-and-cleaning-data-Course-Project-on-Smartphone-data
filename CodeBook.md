# Variables
* The folder `UCI HAR Dataset` that is extracted from the source dataset zip is placed in the R working directory.
* The file `activity_labels.txt` contains the 6 different activities that were performed by the subjects. Read in as `names_activity`
* The file `features.txt` contains the 561 different features that were derived the accelerometer and the gyroscope readings of the smartphone with the subjects. Read in as `names_features`

* The file `train\X_test.txt` contains the 561 different readings derived from the phone measurements of the training subjects. This contains about 7352 observations. Read in as `train_561`
* The file `test\X_test.txt` contains the 561 different readings derived from the phone measurements of the test subjects. This contains about 2947 observations. Read in as `test_561`

* The file `train\subject_test.txt` contains the subject id representing the volunteers who performed the 7352 training observations. Read in as `train_subject`
* The file `test\subject_test.txt` contains the subject id representing the volunteers who performed the 2947 test observations.Read in as `test_subject`

* The file `train\y_test.txt` contains the activity id representing the actions performed by the volunteers corresponding to the 7352 training observations. Read in as `train_activity`
* The file `test\y_test.txt` contains the activity id representing the actions performed by the volunteers corresponding to the 2947 test observations. Read in as `test_activity`

#Transformations
* The training and the test observations of the 561 observations, subject id and the activity id are merged using the `rbind()` function and named as `merged_561`, `merged_subject`, `merged_activity`.
* The names of the features are assigned to `merged_561` from the `names_features`
* A column with activity name is added to `merged_activity` from the `names_activity`
* Using cbind on `merged_561`, `merged_subject`, `merged_activity` a full dataset is obtained as `final.full.dataset`
* The features with `mean` or `std` in the names are obtained using the `grep` function. A subset of the `final.full.dataset` only with these columns and the subject and the activity info is obtained as `only.mean.std.dataset`
* The final dataset containing the averages of the columns group by subject and activity is obtained using the `ddply` function of the `plyr` package on the `only.mean.std.dataset` and is saved as `averages_dataset`.
* This `averages_dataset` is written to a text file using the `write.table()` function.
