# Getting and Cleaning Data Course Project


# Introduction

The files included constitute the output files as required for the Getting and Cleanding Data Course Project as conducted by Coursera.com.

It is assumed the that individuals viewing these documents are peers in the course or some other authorized Coursera individual with access to the course project details.

The details of the project will not be duplicated here in this document as those are found in the course project details.  

The data source links required for the class project will not be duplicated as again those are also found in the details of the course project.

# Project Approach Overview

The original source data was spread across several files.  This data needed to be merged prior to extraction of the required fields and further steps as defined by the project.

1. Load the individual files.
2. Along the way the columns are named as appropriate.  This way as data sets are manipulated, the column names move along with the data sets.
3. Merge the data sets.
4. Extract the required columns from the merged file.
5. Perform the calculations as per project requirements.
6. Save the final dataset.

# Files

- README.md:
This file.
- run_analysis.R:
Constitutes the R code executed to accomplish the requirements of the project.
- ProjectData.txt
The final output data file as per project requirements.
- ProjectDataCodebook.txt
A file detailing the fields found in the ProjectData.txt data file.

# Assumptions

1.  The class project requires an extraction of "only the measurements of the mean and standard deviation for each measurement" columns from the original data sets.  As per the codebook used in the project data set (features_info.txt found in the project source files) it is understood that:

- Mean columns have "mean()" in the column name.
- Standard deviation columns have "std()" in the column name.
- Other columns may have "mean" or "std" in their names; however, these other fields were not included as these columns had additional manipulations and hence I felt were not "**only**" the mean and standard deviations as required by the project.

2.  If an attempt is made to execute the R code found in run_analysis.R I have chosen certain paths to place my data.  These paths may need to be altered on your part accordingly.
3.  The original data describes the individuals in the study as "volunteers"; hence, in the final output data set (ProjectData.txt) I have used the column name "Volunteer". ***See the ProjectDataCodebook.txt file for details of all fields found in ProjectData.txt.***
4.  The volunteers had to accomplish various activities like walking or standing.  In the final output data set (ProjectData.txt) I have used the column name "Activity" accordingly.  ***See the ProjectDataCodebook.txt file for details of all fields found in ProjectData.txt.***
5.  All other field names were maintained from the original source data files to the final output file (ProjectData.txt).  I could have attempted to make them more "friendly"; however, I feel that would have added unnessary complication to the grading of my project as now extra mapping efforts would be required by my peers.  ***See the ProjectDataCodebook.txt file for details of all fields found in ProjectData.txt.***
6.  I imagine the project may change over time as the course progresses.  There will be no attempt to keep the details of these files current upon completion of the course.

# Hardware and Software Details

1. RStudio version 1.0.44
2. R version 3.3.2
3. Windows 7
4. Intel i7 based 2013 HP laptop
5. Any libraries referenced were the latest as of Nov 17, 2016.
6. Project was executed on Nov 17. 2016.