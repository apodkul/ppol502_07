/* 
In-class Lab File 06
PPOL 502-07
03/16/2022
*/

************************************************************
**** Lab Notes
************************************************************

use "catholic.dta"
browse
summarize

** Run regression 
reg read12 motheduc

** Visualize regression 
twoway scatter read12 lfaminc ///
	|| lfit read12 lfaminc

** Residual plot 
rvpplot motheduc, yline(0)


** BP Test
estat hettest

** White Test
estat imtest, white

** Re-estimate regression with heteroskedastic-robust standard errors
reg read12 motheduc, robust
reg read12 motheduc lfaminc, robust
