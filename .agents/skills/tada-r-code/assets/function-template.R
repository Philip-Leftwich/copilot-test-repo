##### scripts/functions/summary_functions.R #####
# Functions moved from scripts/05_analysis.R. Sourced by that script and by
# tests/test_summary_functions.R, after scripts/00_packages.R.
#
# Example names are placeholders: replace them with your own.

#' Summarise metabolic rate by species and treatment
#'
#' Moved unchanged from scripts/05_analysis.R, section "Metabolic summary".
#' Produces the values in Table 2 of the manuscript.
#'
#' @param data A data frame with columns `species`, `treatment` and
#'   `metabolic_rate_w` (whole-animal metabolic rate, W).
#' @return A data frame of mean metabolic rate per species and treatment.
#'   Because `summarise()` drops only the last grouping level, the result is
#'   grouped by `species`, exactly as the original code produced it.
summarise_metabolism <- function(data) {
  ##### Argument checks #####
  # Reject only inputs the original code could not have handled. The missing
  # column names travel with the error, so a test can check them.
  if (!is.data.frame(data)) {
    cli::cli_abort(
      "{.arg data} must be a data frame, not {.obj_type_friendly {data}}.",
      class = "invalid_data_error"
    )
  }

  required <- c("species", "treatment", "metabolic_rate_w")
  missing_columns <- setdiff(required, names(data))

  if (length(missing_columns) > 0) {
    cli::cli_abort(
      c(
        "{.arg data} is missing required columns.",
        "x" = "Missing: {.field {missing_columns}}."
      ),
      class = "missing_columns_error",
      missing_columns = missing_columns
    )
  }

  ##### Summary #####
  # Body moved from the original script; only the dplyr namespace was added.
  # The grouping of the result is preserved deliberately: dropping it would
  # change the output and is a behaviour change for the user to decide.
  data |>
    dplyr::group_by(species, treatment) |>
    dplyr::summarise(mean_rate_w = mean(metabolic_rate_w))
}
