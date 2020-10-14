test_that("without any MLFLOW_* env variable set, the executable is found", {
  orig_global <- mlflow:::.globals$python_bin
  rm("python_bin", envir = mlflow:::.globals)
  on.exit(assign("python_bin", orig_global, envir = mlflow:::.globals))
  withr::with_envvar(
    # variables potentially set in parent process:
    # https://github.com/mlflow/mlflow/blob/master/dev/install-common-deps.sh#L52
    list(
      MLFLOW_BIN = "",
      MLFLOW_PYTHON_BIN = ""
    ),
    {
      binary <- python_mlflow_bin()
      # alternative (wouln't rely on modifying .globals and associated logic):
      # callr::r(python_mlflow_bin())
      expect_equal(processx::run(binary, '--version')$status, 0)
    }
  )
})
