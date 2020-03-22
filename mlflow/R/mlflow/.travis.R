library(reticulate)
use_condaenv(mlflow:::mlflow_conda_env_name())
parent_dir <- dir("../", full.names = TRUE)
package <- parent_dir[grepl("mlflow_", parent_dir)]
install.packages(package)
install.packages("roxygen2")
pyfunc <- import("mlflow.pyfunc")
devtools::check_built(path = package, error_on = "note", args = "--no-tests")
source("testthat.R")


# notes:

# required: move keras installation out of test session because otherwise
# python envs are messed up.

# could make either keras or xgboost test work, not both. Because activated
# environment cannot be changed.

# seems we cannot use the same session because python versions are different
# evident with reticulate::use_conda_env(..., required = TRUE)

# maybe use envname ... in install_keras() to install to mlflow env.
