/* 
In-class Lab File 04
PPOL 502-07
02/16/2022
*/

************************************************************
**** Lab Notes
************************************************************

use "USAID.dta"
browse

**Running our regression with two IV's
reg awd_value very_high_corruption accountable

**Testing hypotheses
test very_high_corruption=0
test very_high_corruption=1
test very_high_corruption=accountable

lincom very_high_corruption
lincom very_high_corruption-1
lincom very_high_corruption-1, level(99)

**Isolating Critical Values/P-Values
display ttail(100, 2.0) /* one sided area to right */
display 1- ttail(100, 2.0) /* one sided area to left */
display 2*ttail(100, 2.0)/* two-sided sided */

display invttail(150, 0.05)
display invttail(150, 0.025)


** Introducing interaction model
reg awd_value very_high_corruption accountable

reg awd_value i.very_high_corruption i.accountable

gen very_high_corruption_accountable = very_high_corruption*accountable
reg awd_value very_high_corruption accountable very_high_corruption_accountable

lincom very_high_corruption + very_high_corruption_accountable


reg awd_value i.very_high_corruption##i.accountable

margins i.very_high_corruption
margins, dydx(i.very_high_corruption)
margins i.very_high_corruption, over(accountable)
marginsplot

margins very_high_corruption

**** Dummy by Continuous
clear all 
use "clinton1.dta"

gen veryhighcrime = .
replace veryhighcrime = 0 if crimeindex < 600
replace veryhighcrime = 1 if crimeindex >= 600

reg clintonpercent i.veryhighcrime##c.povertypercent
margins veryhighcrime
marginsplot
margins, dydx(veryhighcrime)
marginsplot
margins veryhighcrime, at(povertypercent=(20(10)80))
marginsplot

**** Continuous by Continuous 
reg clintonpercent c.percapitaincome##c.populationdensity
margins, dydx(percapitaincome)
marginsplot
margins, dydx(percapitaincome) at(populationdensity=(20(10)80))
marginsplot

