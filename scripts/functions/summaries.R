# scripts/functions/summaries.R ----
# Tidyverse translation of legacy_rate_summary() in tests/test_translation.R.

#' Mean post-treatment metabolic rate and count by treatment arm and sex
#'
#' Matches the original base R summary, which used aggregate() with a formula:
#' that drops any animal whose metabolic_rate_post is missing, so this does too.
#'
#' @param data A data frame with columns treatment_arm, sex and
#'   metabolic_rate_post.
#' @return A tibble with one row per treatment_arm and sex, giving the mean
#'   rate (metabolic_rate_post) and the number of animals behind it (n).
summarise_rate_tidy <- function(data) {
  data |>
    # drop animals with no rate, as aggregate() did in the original
    dplyr::filter(!is.na(metabolic_rate_post)) |>
    dplyr::summarise(
      metabolic_rate_post = mean(metabolic_rate_post),
      n = dplyr::n(),
      .by = c(treatment_arm, sex)
    ) |>
    dplyr::arrange(treatment_arm, sex)
}
