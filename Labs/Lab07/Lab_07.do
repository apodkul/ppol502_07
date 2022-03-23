/* 
In-class Lab File 07
PPOL 502-07
03/23/2022
*/

************************************************************
**** Lab Notes
************************************************************
use "healthcare.dta"
browse 
summarize

replace income = income*1000


** Calculate _alpha_
gen log_income = log(income) 
reg log_income hhkids educ age female married

predict log_y_fitted
gen exp_log_y_fitted = exp(log_y_fitted)

twoway scatter income exp_log_y_fitted 

** To calculate alpha-hat, Method 1 
* Step 1: calculate residuals 
predict resid_1, resid

* Step 2: exponentiate those residuals 
gen exp_resid_1 = exp(resid_1)
tabstat exp_resid_1, statistics(sum)

* Step 3: plug into equation 
display  2231.25/2039 /* 2039 is the sample size used in the model*/


** To calculate alpha-hat, Method 2
* Step 1: calculate m
predict logy_hat 
gen m_hat = exp(logy_hat)
gen m_hat_income = m_hat*income

* Step 2: calculate m-squared
gen m_hat_squared = m_hat*m_hat
tabstat m_hat_squared, statistics(sum)
tabstat m_hat_income, statistics(sum)


* Step 3: plug into equation 
display 2.29/2.12


** Estimating linear probability Model 
summarize healthy
table healthy 
histogram healthy, percent

reg healthy educ income, robust
reg healthy educ income


hettest
rvpplot educ, yline(0)

predict multvar_lpm
histogram multvar_lpm

** Logit function 
display invlogit(1.5)
display logit(0.9)


** Logistic Regression & Predicted Probabilities
logit healthy educ
predict bivar_logit
graph twoway (scatter bivar_logit educ)

logit healthy educ income
predict multvar_logit
estat class

** Marginal Effects 
quietly logit healthy educ income
margins, atmeans post
marginsplot

quietly logit healthy educ income
margins, at(educ=10) atmeans post
marginsplot

quietly logit healthy educ income 
margins, at(educ=(7(1)18)) atmeans post
marginsplot


************************************************************
**** Data Wrangling
************************************************************∂

clear all 
use "csp_elections.dta"
browse


** Merge 
merge 1:1 year st stateno state using "csp_policyIdeology.dta"
help merge

** Collapse
collapse (max) any_earl=earlvot, by(st)
help collapse

** Reshape 
clear all
use "csp_elections.dta"
keep state year earlvot vep

** Long to Wide
reshape wide earlvot vep, i(state) j(year)

** Wide to Long
reshape long earlvot vep, i(state) j(year)


