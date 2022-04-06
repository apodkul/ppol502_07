/* 
In-class Lab File 09
PPOL 502-07
04/06/2022
*/

************************************************************
**** Lab Notes
************************************************************

clear all
use "https://github.com/apodkul/ppol502_07/raw/main/Labs/Lab09/lawsch85.dta"
browse 

** Strings/Numbers 
describe
summarize lsat 

tostring lsat, replace
summarize lsat 
describe lsat

destring lsat, replace
summarize lsat 
describe lsat

** Outliers
reg lsalary lsat gpa top10

*** Studentized Residuals 
gen dummy_1 = 0 
replace dummy_1 = 1 in 1
reg lsalary lsat gpa top10 dummy_1

quietly reg lsalary lsat gpa top10
predict st_resid, rstudent

list st_resid in 1/5

*** DFBETA 
quietly reg lsalary lsat gpa top10
dfbeta
browse
hist _dfbeta_1

*** Cook's Distance 
quietly reg lsalary lsat gpa top10
predict csd, cooksd
histogram csd

** Using/Displaying multiple models 
*ssc install outreg2
reg lsalary lsat
outreg2 using myregression.doc, replace ctitle(Model 1)

reg lsalary lsat gpa
outreg2 using myregression.doc, append ctitle(Model 2)

reg lsalary lsat gpa top10
outreg2 using myregression.doc, append ctitle(Model 3)


** Survey Data 
clear all
use "https://github.com/apodkul/ppol502_07/raw/main/Labs/Lab09/KFF_example.dta" 

*** (Unweighted) One-Way Table 
tab Q11

*** (Unweighted) Two-Way Table 
tab Q11 party, col 

*** Creating Weighted Tables 
svyset [pw = standwt]
svy: tab Q11
svy: tab Q11 party, col

*** Running a Bivariate Dependent Variable Model Example
tab publicop 
gen support_po = . 
replace support_po = 1 if publicop == 1 | publicop ==  2
replace support_po = 0 if publicop == 3 | publicop ==  4
svy: tab publicop support_po

svy: probit support_po age i.party
predict model1_probs

svy: probit support_po age i.party i.gender
predict model2_probs

probit support_po age i.party i.gender
predict model2_probs_unw



