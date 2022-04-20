/* 
In-class Lab File 11
PPOL 502-07
04/20/2022
*/

************************************************************
**** Lab Notes
************************************************************

clear all
import delimited "https://raw.githubusercontent.com/apodkul/ppol502_07/main/Labs/Lab11/Admissions_missing.csv", varnames(1) numericc(_all)

*** Working with Missing Data
histogram grescore

gen guess1 = .
replace guess1 = 0 if grescore < 320
replace guess1 = 1 if grescore >= 320

gen guess2 = 0
replace guess2 = 1 if grescore >= 320

gen guess3 = .
replace guess3 = 0 if grescore < 320
replace guess3 = 1 if grescore >= 320
replace guess3 = . if grescore == .

tab guess1, missing
tab guess2, missing
tab guess3, missing

*** Summarizing Missing Data
misstable summarize
misstable patterns

*** Median/Mean Imputation
summarize grescore
replace grescore = 316.97 if grescore == .

*** Regression Imputation
reg grescore cgpa chanceofadmit research sop lor
predict gre_score2
gen gre_score_imp = grescore
replace gre_score_imp = gre_score2 if grescore == .

*** Multiple Imputation (using MICE)
clear all
import delimited "https://raw.githubusercontent.com/apodkul/ppol502_07/main/Labs/Lab11/Admissions_missing.csv", varnames(1) numericc(_all)


reg chanceofadmit grescore cgpa research

mi set wide 
mi register imputed grescore cgpa research
mi impute mvn grescore cgpa research = chanceofadmit, add(5) force
mi estimate: regress chanceofadmit grescore cgpa research

