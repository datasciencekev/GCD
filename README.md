---
title: "Coursera Getting and Cleaning Data"
output: html_document
---

This file documents the actions taken in the run_analysis.R file for Getting and Cleaning Data course project.

Initially, we read in the features list, as we will need this to add sensible variable names

We then read in the training features, labels, and subjects files.  For the labels and subjects files, we assign sensible column names immediately.  We will do this for the features columns later.

Similarly, we read in the test features, labels and subjects, and assign sensible names for labels and subjects.

We then assign sensible names to the features sets.

Once all column names are assigned, we bind the features, labels and subjects together for both the training and test data, then bind the training and test sets together to have one complete data set.

Once the data set is complete, we change the labels from numbers to more descriptive names.

we then use grep to pull lists of the mean and standard deviation columns.

Once we have the lists, we extract the means and stds, and the activities and subjects, and build a list of 180 averages buy subject and activity.  This is then written out to output.csv