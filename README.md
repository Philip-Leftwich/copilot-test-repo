# Vole Metabolism Study

<!-- TODO: supply paper DOI badge — not provided; do not leave in final submission -->
<!-- TODO: supply code/data archive DOI badge — not provided; do not leave in final submission -->
<!-- TODO: supply licence badge — not provided; do not leave in final submission -->

## Description

<!-- TODO: supply a brief description of the project — not provided; do not leave in final submission -->

## Abstract

<!-- TODO: supply manuscript abstract — not provided; do not leave in final submission -->

## Instructions

This repository contains the code and data accompanying the manuscript above.
To reproduce the analysis:

1. Obtain the data as described under *Data files* below.
2. Restore the package environment (see *Dependencies*).
3. Run the scripts in the order given under *Scripts*.

> **Note:** this project does not currently use `renv`. Before submission or
> archiving, run `renv::init()` followed by `renv::snapshot()` to pin the
> package environment, then commit `renv.lock` to the repository.

## Authors

| Name | ORCID | Affiliation |
|------|-------|-------------|
| <!-- TODO: supply author name --> | <!-- TODO: supply ORCID --> | <!-- TODO: supply affiliation --> |

### Funding

<!-- TODO: supply funder names and grant numbers — not provided; do not leave in final submission -->

## Data files

### `data/voles_metabolism.csv`

72 rows × 6 columns. One missing value in `metabolic_rate_post` (subject to be
identified and documented before submission).

Collected: <!-- TODO: supply collection dates --> at <!-- TODO: supply collection location -->.

| Column | Type | Range / values | Description | Unit |
|--------|------|----------------|-------------|------|
| `subject_id` | character | 72 unique values | <!-- TODO: plain-language description --> | — |
| `sex` | character | F, M | <!-- TODO: plain-language description --> | — |
| `treatment_arm` | character | 3 levels: Control, High…<!-- TODO: confirm all three level names --> | <!-- TODO: plain-language description of treatment arms --> | — |
| `mass_pre_g` | numeric | 20.40 to 33.70 | <!-- TODO: plain-language description --> | g (confirm) |
| `mass_post_g` | numeric | 20.60 to 34.90 | <!-- TODO: plain-language description --> | g (confirm) |
| `metabolic_rate_post` | numeric | 11.09 to 15.69 | <!-- TODO: plain-language description --> | <!-- TODO: supply unit --> |

## Scripts

Run in the following order:

| Order | Script | Description |
|-------|--------|-------------|
| 1 | `scripts/01_load_data.R` | Reads `voles_metabolism.csv` into the R session with explicit column types and prints a data glimpse |
| 2 | `scripts/02_analysis.R` | Sources `01_load_data.R`, computes per-group summary statistics (mean and SD of post-treatment metabolic rate by treatment arm and sex), and fits a linear model of post-treatment body mass against treatment arm |
| 3 | `scripts/03-plots.R` | Sources `01_load_data.R`, produces raincloud and bar-chart figures of post-treatment body mass by treatment arm, and saves combined panel figure to `outputs/figures/` as both PDF and PNG |

> `scripts/blank_script.R` is a template placeholder and is not part of the
> analysis pipeline.

## Dependencies

This project does not currently include an `renv.lock` file. The R version and
package versions below were recorded at the time of analysis; they may not
exactly match your installed environment.

<!-- TODO: run `renv::init()` then `renv::snapshot()` and replace this table
     with the output of `renv::status()` or the parsed renv.lock contents -->

| Package | Version |
|---------|---------|
| colorspace | <!-- TODO --> |
| dplyr | 1.2.1 |
| ggdist | <!-- TODO --> |
| ggplot2 | 4.0.3 |
| here | <!-- TODO --> |
| lubridate | 1.9.5 |
| patchwork | <!-- TODO --> |
| purrr | 1.2.2 |
| ragg | <!-- TODO --> |
| readr | 2.2.0 |
| stringr | 1.6.0 |
| tibble | 3.3.1 |
| tidyr | 1.3.2 |

R version: <!-- TODO: supply R version — run `R.version.string` to obtain -->

## AI declaration

This README was generated with the assistance of Posit Assistant (an AI agent)
on 2026-06-04. The agent read repository files to produce file and variable
summaries and draft the document structure; all scientific content, metadata,
and variable descriptions require review and completion by the authors before
submission.

---

*Repository generated from code at:* <!-- TODO: supply archive URL/DOI — blocking for submission -->
