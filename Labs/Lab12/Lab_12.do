/* 
In-class Lab File 12
PPOL 502-07
04/27/2022
*/

************************************************************
**** Lab Notes
************************************************************
use "healthcare.dta"
browse 
summarize

** Residual Analysis 
reg doctor age female educ income
rvpplot age, yline(0)
rvpplot income, yline(0)

** Heteroskedasticity
**** Detecting 
estat hettest

**** Correcting 
reg doctor age female educ income, robust

** Binary DV

**** LPM 
reg doctor age female educ income, robust
predict doctor_lpm

**** G(z)
display invlogit(3.2)
display logit(0.96)

display normal(1.96)
display invnormal(.975)

**** Logit
logit doctor age female educ income
predict doctor_logit

**** Probit
probit doctor age female educ income
predict doctor_probit

reg doctor_logit doctor_probit

**** Observed Values, Discrete Differences 
quietly probit doctor age female educ income

gen female_0 = 0
gen female_1 = 1

gen P0 = normal(_b[_cons] + _b[age]*age + _b[female]*female_0 + _b[educ] * educ + _b[income] * income)
gen P1 = normal(_b[_cons] + _b[age]*age + _b[female]*female_1 + _b[educ] * educ +  _b[income] * income)

gen diff = P1 - P0
summarize diff if e(sample)

**** Log Likelihood Ratio 
logit doctor age female educ income
estimates store m1
logit doctor age 
estimates store m2

lrtest m1 m2


** Outliers 
quietly reg income educ female age married
predict st_resid, rstudent

list st_resid in 1/5 if st_resid > 2 | st_resid < -2

*** DFBETA 
quietly reg income educ female age married
dfbeta
browse
hist _dfbeta_1


*** Cook's Distance 
quietly reg income educ female age married
predict csd, cooksd
histogram csd

** Prediction Errors 
quietly reg income educ female age married
predict stdp, stdp
predict stdf, stdf


