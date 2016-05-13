# The cleansing/transformation related activities of the script run_analysis.R, are described below...

## Libraries loaded: plyr

## Reference files loaded:

- features.txt
- activity_labels.txt
	
## Transformations related to the feature observations captured within the test/train data files, while making ready a data set that includes mean values for serveral variables, grouped by subject and activity:

1. Capture of all columns present in the test/train data files, delimiting columns by the presence or one/more space characters
2. The assignment of column names to each of the resulting data frames, using a data frame populated from the file "features.txt"
3. The capture of columns among the test/train data frames, where the associated column name includes the phrase "mean()" or "std()"
4. The column-wise amalgamation of the data frames that result from step 3
5. The capture of test/train related "activity key" values from the files "test/y_test.txt" and "train/y_train.txt" 
6. The association of an "activity descriptor" with each of the "activity reference" rows captured in step 5
7. The column-wise amalgamation of "activity key" data frame readied by step 6, with that readied by step 4
8. The capture of test/train related "subject key" values from the files "test/subject_test.txt" and "train/subject_train.txt"
9. The column-wise amalgamation of the "subject key" data frame readied by step 8, with that readied by step 7
10. The row-wise amalgamation the data frames readied by step 9 above
11. A sort operation concerning the data frame readied by step 10, ordering its contents (ascending) by the columns "Subject", and "Activity_key"
12. The creation of a data frame that captures, for the grouping columns "Subject", "Activity_key", and "Activity", the mean for each of the feature observation columns present in the data frame readied by step 11
13. The assignment of column names to each of the grouping columns present in the data frame readied by step 12
14. A sort operation concerning the data frame readied by step 13, ordering its contents by "Subject" and "Activity_key"
15. The assignment of numerically ascending row names to the data frame readied by step 14, beginning at one 
16. A file write operation that records the data frame readied by step 15, within the file "tidydata.txt", delimiting columns with a tab character, while suppressing the use of quote characters, and the presence of row names
