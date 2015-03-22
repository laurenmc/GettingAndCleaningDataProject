# Getting and Cleaning Data Project

##Overview

Project for the getting and cleaning data Coursera course

Please refer to the CodeBook.md for more information about the data, how it was processed and the data produced.

##Pre-requisites

Before calling the run_analysis function follow the following steps:

    Download the zipped data file from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Unzip the file into the working directory containing run_analysis.R, this should create a new sub-directory called UCI HAR Dataset

##Code

All code is supplied within the run_analysis.R file. This contains a function called run_analysis() which can be called to load, tidy and output the final cleansed and summarised result set.

E.g. From the working directory containing the R file:

source('run_analysis.R')
results <- run_analysis()
View(results)

