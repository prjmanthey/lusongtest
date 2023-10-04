test_that("lu.test returns an htest", {
  expect_s3_class(lu.test(rnorm(20, mean = 2, sd = 1), sigma.squared = 0.5),"htest")
})
