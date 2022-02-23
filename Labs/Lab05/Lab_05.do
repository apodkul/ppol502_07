/* 
In-class Lab File 05
PPOL 502-07
02/23/2022
*/

************************************************************
**** Lab Notes
************************************************************

use "lawsch85.dta"
browse
summarize


** Log Transformation 
gen salary_logged = log(salary)
reg salary_logged lsat east


** Standardization/Scaling
reg salary gpa lsat age
reg salary gpa lsat age, beta

egen gpa_std = std(gpa)
egen lsat_std = std(lsat)
egen age_std = std(age)

reg salary gpa_std lsat_std age_std

drop gpa_std lsat_std age_std


** Visualizing Transformations 
gladder cost


** Additional Transformations
gen age_months = age*12

reg salary age
reg salary age_months

egen min_lsat = min(lsat)
egen max_lsat = max(lsat)
gen lsat_norm = (lsat - min_lsat)/(max_lsat - min_lsat)

reg salary lsat
reg salary lsat_norm


** Quadratic
gen lsat_squared = lsat^2

reg salary lsat lsat_squared
nlcom _b[lsat] + 2*_b[lsat_squared]*170

reg salary c.lsat##c.lsat
margins, dydx(lsat) at(lsat = 170)


**** Plotting Quadratic 
reg salary c.lsat##c.lsat
twoway scatter salary lsat || qfit salary lsat
twoway scatter salary lsat || qfitci salary lsat
twoway scatter salary lsat || qfitci salary lsat, scheme(s2mono)


** Producing Nicer Regression Tables 
ssc install outreg2
reg salary lsat 
outreg2 using myregression.doc, replace ctitle(Bivariate)

reg salary lsat gpa north
outreg2 using myregression.doc, append ctitle(MLR)

help outreg2


** Interaction Terms (Again!)
reg salary c.lsat##i.top10
margins top10, at(lsat=(140(10)180))
marginsplot
