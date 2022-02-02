/* 
In-class Lab File 02
PPOL 502-07
02/02/2022
*/


** Setting a working directory 
cd /* Replace with your working directory */

** Loading a file of .csv data type 
clear
import delimited using WRP_regional.csv
browse


** Loading a file of Microsoft Excel
clear
import excel sleep75.xlsx, firstrow
browse

** Loading a file of .dta data type (Stata file)
clear 
use mlr06.dta

** Review on Making Variable Labels (One Step!)
label var overall_crime_rate "Crime Rate Overall"

** Summary statistics 
summarize overall_crime_rate

summarize overall_crime_rate, detail 

tabstat violent_crime_rate, stats(mean min max sd)

tabstat violent_crime_rate, stats(mean min max sd) by(Region)

stem violent_crime_rate

** Multiple Regression 
reg violent_crime_rate college_rate
reg violent_crime_rate college_rate annual_police_funding
reg violent_crime_rate college_rate annual_police_funding, level(90) 

help reg

** Predictions from Multiple Regression 
reg violent_crime_rate college_rate annual_police_funding
predict fitted_val 
predict residuals_name, residuals

reg violent_crime_rate college_rate 
predict fitted_val2 
predict residuals_name2, residuals


** Subsetting Data 
summarize violent_crime_rate if Region == "A"
reg violent_crime_rate college_rate if Region == "A"
reg violent_crime_rate college_rate if Region != "A"
tab Region if high_school_educated_rate > 58.8

** OVB Example 
reg violent_crime_rate college_rate annual_police_funding/*full*/
reg violent_crime_rate college_rate/*partial*/
reg annual_police_funding college_rate /*aux*/

** Creating a useable codebook 
codebook


** Clearing the workspace 
clear all
