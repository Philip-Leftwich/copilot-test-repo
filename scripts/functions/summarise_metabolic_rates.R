#' Summarise post-treatment metabolic rates by treatment arm and sex
#'
#' @param voles_df A data frame containing `treatment_arm`, `sex`, and
#'   `metabolic_rate_post` columns.
#'
#' @return A tibble with one row per treatment arm and sex combination, with:
#'   `mean_rate`, `sd_rate`, and `n`.
#'
#' @examples
#' voles_df <- tibble::tibble(
#'   treatment_arm = c("control", "control", "treated"),
#'   sex = c("female", "male", "female"),
#'   metabolic_rate_post = c(3.2, 3.8, 4.1)
#' )
#' summarise_metabolic_rates(voles_df)
summarise_metabolic_rates <- function(voles_df) {
  stopifnot(is.data.frame(voles_df))

  required_columns <- c("treatment_arm", "sex", "metabolic_rate_post")
  missing_columns <- setdiff(required_columns, names(voles_df))

  if (length(missing_columns) > 0) {
    rlang::abort(
      message = paste(
        "Missing required columns:",
        paste(missing_columns, collapse = ", ")
      ),
      class = "missing_required_columns"
    )
  }

  voles_df |>
    dplyr::group_by(treatment_arm, sex) |>
    dplyr::summarise(
      mean_rate = mean(metabolic_rate_post),
      sd_rate = sd(metabolic_rate_post),
      n = dplyr::n(),
      .groups = "drop"
    )
}
