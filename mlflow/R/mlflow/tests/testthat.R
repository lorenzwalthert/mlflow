library(testthat)
library(mlflow)
library(reticulate)

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  mlflow:::mlflow_maybe_create_conda_env(python_version = "3.6")
  message("Current working directory: ", getwd())
  # needed for test that uses mlflow cli
  conda_install("xgboost", envname = mlflow:::mlflow_conda_env_name())
  use_condaenv(mlflow:::mlflow_conda_env_name())
  test_check("mlflow")
}
