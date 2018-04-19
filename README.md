# partition_datasets

## INPUT

* list of images
* keyword
* training fraction

## PROCESSING
Do the following with *partition_data_two_class.sh*

Use existing subdirectory, if available; otherwise create a new one
The name of the subdirectory is a concatenation of the keyword and training fraction, i.e., *disc40* for keyword *disc* and 40% of the data used for training.

### 1. Get indecies for data that matches keyword

1.1 Select positive examples

1.2 Select negative examples

1.3 Show quantities of positive and negative examples

### 2. Select a whole bunch of indecies for POSITIVE examples at random, many more than will be needed

2.1 Select the first TRAIN_FRAC of the indecies

2.2 Create a script to RETAIN selected rows, by row_id, from data

3.3 Now, KEEP the identified rows for TRAINING using *keep_idx.sh*

## 3. Now, do the same for NEGATIVE examples

3.1 Select the first TRAIN_FRAC of the indecies

3.2 Create a script to REMOVE selected rows, by row_id, from data

3.3 Now TOSS the identified rows, using the rest for TESTING using *toss_idx.sh*

## 4. Summarize results using *show_datasets.sh*

4.1 Configure an input file to visit in each subdirectory, i.e., *datafile=summary.csv*

4.2 Get the keyword from the command-line, *keyword=$1*

4.3 Find all partitions on keyword

* for each directory name that is a combination of *keyword**fraction*
    + report the directory name if the input file is present
    
## OUTPUT

* disc80
    + cells4_bins7
    + cells4_bins8
    + cells5_bins7
    + cells5_bins8
 
