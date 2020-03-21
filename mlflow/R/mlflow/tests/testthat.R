library(testthat)
library(mlflow)


if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  message("Current working directory: ", getwd())
  # needed for test that uses mlflow cli
  conda_install("xgboost", envname = mlflow:::mlflow_conda_env_name())
  test_check("mlflow")
}
