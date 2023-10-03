# lusongtest
<!-- badges: start -->
[![R-CMD-check](https://github.com/prjmanthey/lusongtest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/prjmanthey/lusongtest/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Overview

Package Overview to be added soon

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
```
