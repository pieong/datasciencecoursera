**tidy_mean.txt** is the tidy data set organized in the types of actions/movements from the 30 participants

**CodeBook.md** gives the explaination of the number codes used in the Actions column of the tidy_mean.txt
and it contains information explaning the names of each column.

**run_analysis.R** is the R script containing the R codes used to generate the tidy_mean.txt dataset.
I first loaded in the two dataset: training an test, then I grab their column names from feature.txt. 
After that, I added the action and subject columns extracted from y_training, x_training, subject_test,
and subject_train text files. I then combined the two datasets(training and test) together.

I extracted just the mean and standard deviation from each measurement along with the subject and action
codes called mean_std. I renamed the columns after extracting just the means from the mean_std dataset.
Then I grouped the data by action and subjects and calculated the average for each variable means.
