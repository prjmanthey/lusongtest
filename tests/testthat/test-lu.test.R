test_that("lu.test returns an htest under normal conditions", {
  expect_s3_class(lu.test(rnorm(20, mean = 2, sd = 1), sigma.squared = 0.5),"htest")
})
test_that("lu.test returns an error when x is not finite", {
  expect_error(lu.test(append(rnorm(20, mean = 2, sd = 1),NA), sigma.squared = 0.5))
})
test_that("lu.test returns an error when all values are the same", {
  expect_error(lu.test(rnorm(20, mean = 2, sd = 0), sigma.squared = 0.5), "All values in 'x' are the same.  Variance is zero.")
})
test_that("lu.test returns an error when sigma.squared is not a single positive numeric value", {
  expect_error(lu.test(rnorm(20, mean = 2, sd = 1), sigma.squared = 0), "argument 'sigma.squared' must be a single positive numeric value.")
})
