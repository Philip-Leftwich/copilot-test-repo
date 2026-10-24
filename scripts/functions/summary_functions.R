# scripts/functions/summary_functions.R: refactored ----
#' Summarise post-treatment metabolic rate by treatment arm and sex
#'
#' @param data A data frame with columns treatment_arm, sex and
#'   metabolic_rate_post.
#' @return A tibble with one row per treatment_arm and sex, sorted by both,
#'   giving the mean, standard deviation and number of rows.
summarise_metabolic_rate <- function(data) {
  stopifnot(is.data.frame(data))
  required <- c("treatment_arm", "sex", "metabolic_rate_post")
  missing_cols <- setdiff(required, names(data))
  if (length(missing_cols) > 0) {
    stop(
      "`data` is missing required column(s): ",
      paste(missing_cols, collapse = ", "),
      call. = FALSE
    )
  }

  data |>
    dplyr::summarise(
      mean_rate = mean(metabolic_rate_post),
      sd_rate   = stats::sd(metabolic_rate_post),
      n         = dplyr::n(),
      .by       = c(treatment_arm, sex)
    ) |>
    dplyr::arrange(treatment_arm, sex)
}
