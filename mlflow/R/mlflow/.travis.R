library(reticulate)
use_condaenv(mlflow:::mlflow_conda_env_name())
parent_dir <- dir("../", full.names = TRUE)
package <- parent_dir[grepl("mlflow_", parent_dir)]
install.packages(package)
install.packages("roxygen2")
# -------------------------------------------------- REMOVE COMMENT ------------
#devtools::check_built(path = package, error_on = "note", args = "--no-tests")
# source("testthat.R")
pyfunc <- import("mlflow.pyfunc")
