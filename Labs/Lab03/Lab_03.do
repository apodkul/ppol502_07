/* 
In-class Lab File 03
PPOL 502-07
02/09/2022
*/


** Load .dta 
use "https://github.com/apodkul/ppol502_07/raw/main/Labs/Lab03/mlr06.dta"

** Plotting univariate data 
**** Numerical Data
****** Histograms 
histogram overall_crime_rate
histogram overall_crime_rate, percent
histogram overall_crime_rate, percent by(Region, total)

****** Box Plots 
graph box overall_crime_rate
sum overall_crime_rate, detail
graph box overall_crime_rate, marker(1, mlabel(id))
graph box overall_crime_rate, marker(1, mlabel(id)) by(Region)

****** Density Plots 
twoway kdensity overall_crime_rate

**** Categorical Variables
****** Bar Charts 
graph bar, over(Region)
graph bar (mean) overall_crime_rate, over(Region)
graph bar (mean) overall_crime_rate (median) overall_crime_rate, over(Region)


****** Pie Charts 
** do not make pie charts, ever


** Bivariate Numerical Data 
twoway scatter overall_crime_rate annual_police_funding

** Bivariate Regression Models 
twoway scatter overall_crime_rate annual_police_funding ///
	|| lfit overall_crime_rate annual_police_funding

twoway scatter overall_crime_rate annual_police_funding ///
	|| lfitci overall_crime_rate annual_police_funding
	
** Graph Matrix 
graph matrix overall_crime_rate annual_police_funding in_college_rate violent_crime_rate


** Adding Details 
** https://stats.idre.ucla.edu/stata/faq/how-can-i-view-different-marker-symbol-options/
twoway scatter overall_crime_rate annual_police_funding, ///
	title("Plot Title") xtitle("Annual Police Funding") ytitle("Crime Rate")

twoway scatter overall_crime_rate annual_police_funding, ///
	title("Plot Title") xtitle("Annual Police Funding") ytitle("Crime Rate") ///
	msymbol(Sh)

	
** Using Stata Schemes 
histogram overall_crime_rate, percent scheme(s2mono)
histogram overall_crime_rate, percent scheme(economist)

** Residual Plots 
reg overall_crime_rate annual_police_funding
predict fitted
predict resid, residual
twoway scatter resid fitted, yline(0, lcolor(maroon))


** Saving Graphs 
histogram overall_crime_rate, percent scheme(economist) 
graph export test_file.png
