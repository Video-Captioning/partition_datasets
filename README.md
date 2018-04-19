# partition_datasets

## INPUT

* list of images
* keyword
* training fraction

## PROCESSING
(Accomplished via *partition_data_two_class.sh*)

* Use existing subdirectory, if available; otherwise create a new one
* The name of the subdirectory is a concatenation of the keyword and training fraction, i.e., *disc40* for keyword *disc* and 40% of the data used for training

### 1. Get indecies for data that matches keyword

* Select positive examples
* Select negative examples
* Show quantities of positive and negative examples

### 2. Select a whole bunch of indecies for POSITIVE examples at random, many more than will be needed

* Select the first TRAIN_FRAC of the indecies
* Create a script to RETAIN selected rows, by row_id, from data
* Now, KEEP the identified rows for TRAINING (Accomplished via *keep_idx.sh*)

## 3. Now, do the same for NEGATIVE examples

* Select the first TRAIN_FRAC of the indecies
* Create a script to REMOVE selected rows, by row_id, from data
* Now TOSS the identified rows, using the rest for TESTING (Accomplished via *toss_idx.sh*)

## 4. Summarize results
(Accomplished via *show_datasets.sh*)

* for each directory name that is a combination of *keyword**fraction*
    + report the directory name if the input file is present
    
## OUTPUT

* disc40
    + cells4_bins7
    + cells4_bins8
    + cells5_bins7
    + cells5_bins8
 
