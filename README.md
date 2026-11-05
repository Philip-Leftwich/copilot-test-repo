# Workshop repository: AI-assisted R (Day 4)

Your own copy of the Day 4 template for *Advancing in R*. Blocks 2 to 8, and
the self-study page on the Copilot cloud agent, all work in this repository.
The course pages tell you what to do in each block.

## Getting started

1. Fork and clone it, and open it as a project:
   `usethis::create_from_github("<owner>/<repo>", fork = TRUE)`.
2. In the R console, install any of these packages you do not have:
   `install.packages(c("tidyverse", "here", "testthat", "assertr", "callr", "ellmer", "fs", "gert", "jsonlite", "usethis"))`.
3. Check that everything works: `testthat::test_dir(here::here("tests"))`.
   Expect no failures; tests for blocks you have not done yet are skipped.

## Built with

The template was built and tested with R version 4.5.2 (2025-10-31 ucrt) on
Windows 11, with these package versions. Other versions may work, but these
are the ones the tests were run with. If a test fails, compare yours with
`packageVersion()`.

| Package | Version |
|---|---|
| assertr | 3.0.1 |
| callr | 3.7.6 |
| dplyr | 1.1.4 |
| ellmer | 0.5.0 |
| fs | 1.6.6 |
| gert | 2.2.0 |
| here | 1.0.2 |
| jsonlite | 2.0.0 |
| readr | 2.1.6 |
| testthat | 3.3.1 |
| tibble | 3.3.0 |
| tidyr | 1.3.1 |
| tidyverse | 2.0.0 |
| usethis | 3.2.1 |

## Run order, inputs and outputs

Run each script from the project root in a fresh R session, for example
`Rscript scripts/05_analysis.R`. Packages are attached by
`scripts/00_packages.R`, which every script and test sources.

| Script | Reads | Writes |
|---|---|---|
| `scripts/00_profile.R` | `data/raw/voles_raw.csv` | `docs/profile*.csv` |
| `scripts/02_validate.R` | `data/raw/voles_raw.csv`; `data/derived/voles_clean.csv` if present | console only |
| `scripts/03_audit_cleaning.R` | `data/derived/cleaning_log.csv` (made by a cleaning step that is not on this branch) | console only |
| `scripts/04_load_data.R` | `data/raw/voles_metabolism.csv` | object `voles` |
| `scripts/05_analysis.R` | `voles` from `04_load_data.R` | object `metabolic_summary` |
| `scripts/explore_voles.R` | `data/raw/voles_metabolism.csv` | console only |
| `scripts/explore_mass_change_plot.R` | `data/raw/voles_metabolism.csv` | `outputs/mass_change_by_arm.png` |
| `scripts/fig_house.R` | `data/raw/voles_metabolism.csv` | `outputs/fig_house_mass_post.png` |

`tests/test_analysis_script.R` checks that `05_analysis.R` still reproduces
the reference captured in `tests/fixtures/metabolic_summary.rds`.

## LLM use

AI assistants helped write and refactor code in this repository; see
`docs/ai-log.md` for each piece of work.

## If you fall behind

Commit or discard your changes, then switch branch from the Git pane:

| Branch | State |
|---|---|
| `checkpoint-skills` | the end of Block 4 |
| `checkpoint-cleaning` | the end of Block 7 |
| `checkpoint-refactor` | the end of Block 8, Step 1 |

## Good to know

- `AGENTS.md` holds the project's conventions; Claude Code reads it at the
  start of every conversation.
- `.claude/settings.json` starts Claude Code in Manual mode and denies edits
  to the raw data, the checks and the references.
- Files in `data/raw/` are never changed; derived data go in `data/derived/`
  and figures in `outputs/` (not tracked by git).
- Record AI-assisted work in `docs/ai-log.md`, one line per piece of work:
  `date; tool and model; task; what you kept or changed`.
