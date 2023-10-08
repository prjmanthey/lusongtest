#' One-Sample Lu-Song Test on Variance
#'
#' @description Estimate the variance, test the null hypothesis using the Lu-Song test that the variance is equal to a user-specified value, and create a bootstrapped confidence interval for the variance.
#' @param x numeric vector of observations. Missing (\code{NA}), undefined (\code{NaN}), and infinite (\code{Inf}, \code{-Inf}) values are allowed but will be removed.
#' @param alternative character string indicating the kind of alternative hypothesis. The possible values are \code{"two.sided"} (the default), \code{"greater"}, and \code{"less"}.
#' @param conf.level numeric scalar between 0 and 1 indicating the confidence level associated with the confidence interval for the population variance. The default value is \cr \code{conf.level=0.95}
#' @param sigma.squared a numeric scalar indicating the hypothesized value of the variance. The default value is \code{sigma.squared=1}.
#' @param data.name character string indicating the name of the data used for the test of variance.
#' @param R The number of bootstrap replicates to use for bootstrapped statistics.
#'
#' @return A list of class \code{"htest"} containing the results of the hypothesis test.
#' @references
#' Lu, Y., Song, L. (2011). *U*-Statistics Testing Method in Testing Variance Differences of a Single Population. *Journal of Jilin University: Science Edition*, 49(6), 1064-1067.
#'
#' Millard, S. P., Kowarik, A., & Kowarik, M. A. (2022). Package ‘EnvStats’.
#'
#' Mangiafico, S., & Mangiafico, M. S. (2017). Package ‘rcompanion’. *Cran Repos*, 20, 1-71.
#'
#' @author Peter R. Manthey (\email{prjmanthey@gmail.com})
#' @note A one-sample variance test is a type of hypothesis test that is used to determine if the population variability is significantly different from a specific value. The hypothesis test traditionally utilized for these use cases is the chi-squared test on the population variance, which works under the assumption that the underlying population is normally distributed. However, this test is extremely sensitive to departures from normality. This means that for populations that are not normally distributed Type I error rates would be larger than assumed, making a nonparametric test more appropriate. One such alternative hypothesis test that could be used is the Lu-Song test, which is based on a *U*-statistic rather than the chi-squared statistic.
#'
#' The function \code{lu.test} can be used to perform a hypothesis test for the population variance based on the methodology described by Yuan-yuan Lu and Li-xin Song in their paper "*U*-Statistics Testing Method in Testing Variance Differences of a Single Population". The function itself was adapted from the \code{varTest} function from the package \pkg{EnvStats} for ease of use. The function can then also be used to generate a bootstrapped confidence interval for the population variance as well. The syntax for the bootstrapped confidence interval was adapted from the syntax used in the package \pkg{rcompanion} to again help with ease of use.
#'
#' @section See Also:
#' [var.test].
#' @export
#' @examples
#' # Generate 20 observations from a normal distribution with parameters
#' # mean=2 and sd=1.  Test the null hypothesis that the true variance is
#' # equal to 0.5 against the alternative that the true variance is not
#' # equal to 0.5.
#' # (Note: the call to set.seed allows you to reproduce this example).
#'
#' set.seed(23)
#' dat <- rnorm(20, mean = 2, sd = 1)
#' lu.test(dat, sigma.squared = 0.5)
#'
#' #Results of Hypothesis Test
#' #--------------------------
#' #
#' #Null Hypothesis:                 variance = 0.5
#' #
#' #Alternative Hypothesis:          True variance is not equal to 0.5
#' #
#' #Test Name:                       Lu-Song Test on Variance
#' #
#' #Estimated Parameter(s):          variance = 0.753708
#' #
#' #Data:                            dat
#' #
#' #Test Statistic:                  U-Statistic = 1.7018
#' #
#' #P-value:                         0.08879
#' #
#' #95% Confidence Interval:         LCL = 0.4045517
#' #                                 UCL = 1.0342297
#'
#' # Note that in this case we would not reject the
#' # null hypothesis at the 5% level.
#'
#' # Clean up
#' rm(dat)
#' @keywords htest
#' @keywords model


lu.test <-
  function (x, alternative = "two.sided", conf.level = 0.95, sigma.squared = 1,
            data.name = NULL, R = 1000)
  {
    if (is.null(data.name))
      data.name <- deparse(substitute(x))
    alternative <- match.arg(alternative, c("two.sided", "less",
                                            "greater"))
    if ((bad.obs <- sum(!(x.ok <- is.finite(x)))) > 0) {
      is.not.finite.warning(x)
      x <- x[x.ok]
      warning(paste(bad.obs, "observations with NA/NaN/Inf in 'x' removed."))
    }
    if (length(unique(x)) < 2) {
      stop("All values in 'x' are the same.  Variance is zero.")
    }
    if (!missing(sigma.squared))
      if ((length(sigma.squared) != 1) || !is.finite(sigma.squared) ||
          sigma.squared <= 0)
        stop(paste("argument 'sigma.squared' must be a",
                   "single positive numeric value."))
    n <- length(x)
    var.x <- var(x)
    mean_xa <- mean(x)
    diff <- x - mean_xa
    tesseracted_diff <- diff^4
    A4 <- sum(tesseracted_diff) / length(x)
    Tn <- (sqrt(n)*(var.x-sigma.squared))/(sqrt(A4-var(x)^2))
    p.less <- pnorm(Tn)
    p.greater <- 1 - pnorm(Tn)
    p.value <- switch(alternative, two.sided = 2 * min(p.less, p.greater),
                      less = p.less, greater = p.greater)
    boot.stat<-rep(NA, R)
    for(i in 1:R){
      curr.sample <- sample(x, n, TRUE)
      boot.stat[i] <- var(curr.sample)
    }
    ci.interval <- quantile(boot.stat, c((1-conf.level)/2,
                                         1-((1-conf.level)/2)))
    statistic <- Tn
    names(statistic) <- "U-Statistic"
    null.value <- sigma.squared
    names(null.value) <- "variance"
    method <- "Lu-Song Test"
    estimate <- var.x
    names(estimate) <- "variance"
    attr(ci.interval, "conf.level") <- conf.level
    ret.val <- c(list(statistic = statistic, p.value = p.value,
                      estimate = estimate, null.value = null.value,
                      alternative = alternative, method = method,
                      data.name = data.name), list(conf.int = ci.interval))
    oldClass(ret.val) <- "htest"
    return(ret.val)
  }
