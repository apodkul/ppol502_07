/* 
In-class Lab File 08
PPOL 502-07
03/30/2022
*/

************************************************************
**** Lab Notes
************************************************************

** Unrelated word of caution!
clear all
import delimited "https://raw.githubusercontent.com/apodkul/ppol502_07/main/Labs/Lab08/sample.csv"

reg y x1
reg y x1 x2
reg y x1 x2 x3

** Regularly scheduled programming 
clear all
use "https://github.com/apodkul/ppol502_07/raw/main/Labs/Lab08/admissions.dta"

** Continuing to work with G(z)
display invlogit(3.2)
display logit(0.96)


display normal(1.96)
display invnormal(.975)

** Estimating LPM vs. Logit vs. Probit 
reg admitted cgpa grescore lor, robust
predict lpm_admit

logit admitted cgpa grescore lor
predict logit_admit

probit admitted cgpa grescore lor
predict probit_admit

pwcorr lpm_admit logit_admit probit_admit
summarize lpm_admit logit_admit probit_admit


** Log Odds (Logit)
logistic admitted cgpa grescore lor
logit admitted cgpa grescore lor, or

** Log Likelihood Ratio 
** Let's explore the hypothesis that gpa and lor don't matter
probit admitted cgpa grescore lor
probit admitted grescore 

display 2*(-152.21633  - -192.27644)
display chi2tail(2, 2*(-152.21633  - -192.27644))


**Alternatively...
probit admitted cgpa grescore lor
estimates store m1
probit admitted grescore 
estimates store m2

lrtest m1 m2


** Marginal Effects
quietly probit admitted cgpa grescore lor
margins, at(cgpa=(7(.5)10)) atmeans post
marginsplot

** Observed Values, Discrete Differences Example 
quietly probit admitted cgpa grescore lor

gen lor_0 = 0
gen lor_1 = 1

gen P0 = normal(_b[_cons] + _b[cgpa]*cgpa + _b[grescore]*grescore + _b[lor] * lor_0)
gen P1 = normal(_b[_cons] + _b[cgpa]*cgpa + _b[grescore]*grescore + _b[lor] * lor_1)

gen diff = P1 - P0
summarize diff if e(sample)
