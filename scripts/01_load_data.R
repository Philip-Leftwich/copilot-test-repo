# R/01_load_data.R
library(tidyverse)
library(here)

voles <- readr::read_csv(
  here::here("data", "voles_metabolism.csv"))


glimpse(voles)

