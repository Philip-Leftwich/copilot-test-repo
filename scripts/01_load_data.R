# R/01_load_data.R
library(tidyverse)
library(here)

voles <- readr::read_csv(
  here::here("data", "voles_metabolism.csv"),
  col_types = readr::cols(
    treatment_arm       = readr::col_character(),
    sex                 = readr::col_character(),
    metabolic_rate_post = readr::col_double()
  )
)

glimpse(voles)