*** 
clear all 
use union.dta

** Quick summaries 
summarize
summarize left

** Bivariate Regression 
reg union left 

** Multiple Regression 
reg union left europe

** ** Make predictions and residuals 
predict fitted_values 
predict residuals, resid

** Multiple Regression with Logged Variables 
gen union_logged = log(union)
gen left_logged  = log(left)

reg union left_logged europe 
reg union_logged left europe 
reg union_logged left_logged europe 

** Standardized Coefficients 
reg union left europe, beta

** Running Polynomial (Quadratic Model) 
gen left_squared = left^2
reg union left left_squared

** Running Interaction Model 
gen int_left_europe = left*europe
reg union left europe int_left_europe

reg union c.left##i.europe
margins europe
marginsplot
margins, dydx(europe)
marginsplot


