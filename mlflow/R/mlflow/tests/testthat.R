library(testthat)
library(mlflow)


if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  message("Current working directory: ", getwd())
  # needed for test that uses mlflow cli
  test_check("mlflow")
}
