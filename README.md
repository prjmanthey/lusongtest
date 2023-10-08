# lusongtest
<!-- badges: start -->
[![R-CMD-check](https://github.com/prjmanthey/lusongtest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/prjmanthey/lusongtest/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/prjmanthey/lusongtest/graph/badge.svg?token=VSIIQTOI0S)](https://codecov.io/gh/prjmanthey/lusongtest)
<!-- badges: end -->

## Overview

lusongtest is an R package that provides a tool for performing a One-Sample Lu-Song Test on Variance. This can be accomplished by using the function `lu.test()` a numeric vector of observations. The Lu-Song test is a nonparametric hypothesis test that can be used as an alternative to the One-Sample Chi-Squared Test on Variance when there are concerns regarding the normality of the data. The function also utilizes bootstrapping to generate a confidence interval that is presented along with the hypothesis test results.

The methodology this package uses to perform Lu-Song tests was adapted from the 2011 paper “*U*-Statistics Testing Method in Testing Variance Differences of a Single Population” by Yuan-yuan Lu and Li-xin Song. The `lu.test()` function itself was adapted from the `varTest()` function from the [EnvStats](https://cran.r-project.org/web/packages/EnvStats/index.html) R package. The syntax for the bootstrapped confidence interval was adapted from the syntax used in the [rcompanion](https://rcompanion.org/handbook/) R package.


## Installation

``` r
# Install devtools if not already installed
install.packages("devtools")

# Load devtools and install lusongtest from github
library(devtools)
install_github("prjmanthey/lusongtest")
```
## Usage

``` r
library(lusongtest)

set.seed(23)
dat <- rnorm(20, mean = 2, sd = 1)
lu.test(dat, sigma.squared = 0.5)
#>
#> 	       Lu-Song Test
#>          
#> data:  dat
#> U-Statistic = 1.7018, p-value = 0.08879
#> alternative hypothesis: true variance is not equal to 0.5
#> 95 percent confidence interval:
#>  0.4045517 1.0342297
#> sample estimates:
#> variance 
#> 0.753708
#>
```
