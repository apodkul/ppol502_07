/* 
In-class Lab File 01 
PPOL 502-07
01/26/2022
*/



** Setting a working directory 
cd "your/file/path/here"


** Explore the directory
dir

** Explore the raw data of a file 
type 538averages.csv


**Make a new directory 
mkdir new_folder
dir

**Remove that new directory 
rmdir new_folder


** Loading data 
import delimited using 538averages.csv


** Checking out the Data Browser and Data Editor 
browse
edit


** Exploring new data 
summarize
describe
desc
list in 1/3


** Sorting our data 
sort party 
sort party state 

** Establishing a log for tracking inputs and oututs 
log using log_file_testing


** Gathering descriptive statistics 
tab party
tab party chamber
tab party chamber, column row
tab party chamber, summarize(agree_pct)


** Running a Regression 
reg agree_pct net_trump_vote


** Running a Regression (with an indicator variable)
**** Setting up the indicator variable
gen gop_dummy = 0
replace gop_dummy = 1 if party == "Republican"

**** Value Labels 
tab gop_dummy
label variable gop_dummy "Republican Member"
label define gop_dummy_vals 0 "Not Republican" 1 "Republican"
label values gop_dummy gop_dummy_vals
tab gop_dummy 

**** Renaming variables 
rename gop_dummy republican

**** Running Regression
reg agree_pct republican


**** Compare to t-test?
ttest agree_pct, by(republican)

**** Removing a Variable 
drop republican


** Subsetting 
tab party if state == "NJ"
tab party if state != "NJ"

** Help code 
help tab


** Save; Note: DO NOT SAVE OVER ORIGINAL DATA
save data_set.dta


** Closing the log 
log close 
** ** converting the log to a .pdf 
translate log_file_testing.smcl log_file_testing.pdf

** Creating a useable codebook 
codebook

** Clearing the workspace 
clear all
