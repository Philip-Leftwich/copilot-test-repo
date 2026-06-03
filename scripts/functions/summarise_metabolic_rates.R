#' Summarise post-treatment metabolic rates by group
#'
#' @param voles A data frame containing `treatment_arm`, `sex`, and
#'   `metabolic_rate_post` columns.
#'
#' @return A tibble with one row per treatment arm and sex combination,
#'   containing mean metabolic rate (`mean_rate`), standard deviation
#'   (`sd_rate`), and group size (`n`).
#'
#' @examples
#' sample_voles <- tibble::tibble(
#'   treatment_arm = c("Control", "Control", "Drug"),
#'   sex = c("F", "F", "M"),
#'   metabolic_rate_post = c(12.3, 13.1, 14.2)
#' )
#' summarise_metabolic_rates(sample_voles)
#'
#' @export
summarise_metabolic_rates <- function(voles) {
  stopifnot(is.data.frame(voles))

  required_columns <- c("treatment_arm", "sex", "metabolic_rate_post")
  missing_columns <- setdiff(required_columns, names(voles))

  if (length(missing_columns) > 0) {
    rlang::abort(
      message = paste("Missing required columns:", paste(missing_columns, collapse = ", ")),
      class = "metabolic_summary_missing_columns"
    )
  }

  dplyr::group_by(voles, treatment_arm, sex) |>
    dplyr::summarise(
      mean_rate = mean(metabolic_rate_post),
      sd_rate = sd(metabolic_rate_post),
      n = dplyr::n(),
      .groups = "drop"
    )
}
