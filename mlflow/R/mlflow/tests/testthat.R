library(testthat)
library(mlflow)
library(reticulate)

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  message("Current working directory: ", getwd())
  # needed for test that uses mlflow cli
  conda_install("xgboost", envname = mlflow:::mlflow_conda_env_name())
  use_condaenv(mlflow:::mlflow_conda_env_name())
  pyfunc <- import("mlflow.pyfunc")
  # test_check("mlflow")
}
