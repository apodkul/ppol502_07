/* 
In-class Lab File 10
PPOL 502-07
04/13/2022
*/

************************************************************
**** Lab Notes
************************************************************

clear all
use "https://github.com/apodkul/ppol502_07/raw/main/Labs/Lab09/KFF_example.dta" 

gen support_po = . 
replace support_po = 1 if publicop == 1 | publicop ==  2
replace support_po = 0 if publicop == 3 | publicop ==  4


*** Making Predictions 
reg support_po i.D1 c.age##c.age i.rvote

predict preds

*** Standard Error of the Prediction 
predict stdp, stdp
predict stdf, stdf


*** Plotting the Standard Error of the Prediction 
reg support_po age
twoway lfitci support_po age
twoway lfitci support_po age, stdf


*** Training and Testing a Model 
set seed 1789 
gen rand_num = runiform(0, 1)
gen test_set = 0
replace test_set = 1 if rand_num > .8
tab test_set

probit support_po i.D1 c.age##c.age i.rvote i.race i.party if test_set == 0

predict pr_mod 
gen predicted_response = .
replace predicted_response = 0 if pr_mod < 0.5
replace predicted_response = 1 if pr_mod >= 0.5

table predicted_response if test_set == 1


*** Classification Metrics 
estat classification if test_set == 0
estat classification if test_set == 1

*** K-Fold Cross Validation
**ssc install cv_kfold
probit support_po i.D1 c.age##c.age i.rvote i.race i.party
cv_kfold, k(5)

