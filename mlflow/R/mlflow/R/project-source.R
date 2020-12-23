#' Source a Script with MLflow Params
#'
#' This function should not be used interactively. It is designed to be called via `Rscript` from
#'   the terminal or through the MLflow CLI.
#'
#' @param uri Path to an R script, can be a quoted or unquoted string.
#' @param transformer A function that transforms the input parameters. In
#'   particular, functions that perform string substitutions are useful, e.g.
#'   one that transforms "{{ today }}" into todays date.
#' @keywords internal
#' @export
mlflow_source <- function(uri, transformer = identity) {
  if (interactive()) stop(
    "`mlflow_source()` cannot be used interactively; use `mlflow_run()` instead.",
    call. = FALSE
  )

  uri <- as.character(substitute(uri))

  .globals$run_params <- list()
  command_args <- parse_command_line(commandArgs(trailingOnly = TRUE))

  if (!is.null(command_args)) {
    purrr::iwalk(command_args, function(value, key) {
      t <- transformer(value)
      if (length(t) > 1) {
        stop(paste(
          "Transfromer must transform ", value, ' into an object of length ',
          "one. Instead, the result was: ", as.character(t)
        ))
      }
      .globals$run_params[[key]] <- t
    })
  }

  tryCatch(
    suppressPackageStartupMessages(source(uri, local = parent.frame())),
    error = function(cnd) {
      message(cnd, "\n")
      mlflow_end_run(status = "FAILED")
    },
    interrupt = function(cnd) mlflow_end_run(status = "KILLED"),
    finally = {
      if (!is.null(mlflow_get_active_run_id())) mlflow_end_run(status = "FAILED")
      clear_run_params()
    }
  )

  invisible(NULL)
}

clear_run_params <- function() {
  rlang::env_unbind(.globals, "run_params")
}
