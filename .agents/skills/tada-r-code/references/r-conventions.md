# R conventions

Read before writing or moving any code. For which changes alter results, see `modernisation.md`.

## Packages and namespacing

This skill deliberately relaxes TADA's checklist item asking for every call to be written as `package::function()` (see `sources.md`). Instead:

- **Attach packages in one place.** `scripts/00_packages.R` (from `assets/packages-template.R`) holds every `library()` call and is sourced at the top of each script and each test, so scripts and tests always run with the same packages attached. Creating it, and pointing the scripts at it, is a refactor under the characterisation test.
- **Namespace dplyr throughout.** Write every dplyr function as `dplyr::function()`. Several of its most-used verbs share names with functions in packages that are commonly attached alongside it, and a masked verb fails silently or gives a different answer.
- **Namespace these other known clashes**, and nothing else:

  | Write | Clashes with |
  |---|---|
  | `here::here()` | plyr |
  | `purrr::map()` | maps |
  | `purrr::transpose()` | data.table |
  | `tidyr::extract()` | terra, raster |
  | `tidyr::expand()`, `tidyr::pack()`, `tidyr::unpack()` | Matrix |
  | `lubridate::year()`, `month()`, `week()`, `wday()`, `yday()`, `hour()` | data.table |

  For reference, the dplyr clashes include `filter()` and `lag()` (stats), `select()` (MASS), `summarise()`, `summarize()`, `mutate()`, `rename()`, `arrange()`, `count()` and `desc()` (plyr), and `first()`, `last()` and `between()` (data.table).
- **Optional safety net.** `library(conflicted)` in the packages file turns any remaining clash between attached packages into an error instead of a silent switch; `conflicted::conflicts_prefer()` then records each choice. Suggest it; do not add it unasked.
- Adding or removing a namespace, or a `library()` call, can change which function runs. Both are refactors under the test, never annotation.

## Other conventions

- **Pipe.** The native pipe `|>`, as in the tidyverse style guide (R 4.1 or later). See `modernisation.md` for when an existing `%>%` must stay.
- **Paths.** `here::here("data", "raw", "file.csv")`. Never `setwd()` or an absolute path.
- **Function files.** `scripts/functions/<topic>_functions.R`. One roxygen2-style block per function: a title; a description saying where the code came from and which manuscript output it feeds; `@param` for each argument, naming required columns and their units; `@return` stating the class, columns and grouping of the result. Outside a package the tags are documentation only, so do not add `@export`.
- **Argument checks.** Reject only inputs the original code could not have handled: data that are not a data frame, or lack a required column. Raise them with `cli::cli_abort()`, giving a condition class and, for missing columns, a `missing_columns` field holding their names, so a test can check both. In a refactor, add no new constraints such as no-missing-value or range checks; those are behaviour changes.
- **Annotation.** A header on each script; section markers (`#####` or `#----`); each chunk says what it does, why, and where its output appears in the manuscript.
- **Seeds.** `set.seed()` at the start of each independently runnable section, before anything random (SORTEE Stage 6). Adding one where none existed is an enabling change.
- **Data.** `data/raw/` is never written to; scripts write to `data/processed/` or `output/`. Objects passed between scripts go through `saveRDS()` and `readRDS()`.
- **Formatting.** If the user wants `styler::style_file()`, apply it as its own change set, so substantive diffs stay readable.

## Package versions

A reference captured under one set of package versions can legitimately differ from output under another. Before concluding that a change altered behaviour, compare the versions in `tests/fixtures/provenance.txt` with the current session, and report both possibilities if they differ. The TADA-Wiki recommends `renv` to fix the environment, although TADA does not require it.
