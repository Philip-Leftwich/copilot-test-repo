# Copilot Instructions: R Analytical Repository

This repository contains analytical R code for computationally reproducible
research. Most items below are written for you to follow as you generate code.
A short Verification section lists the few things that are also checked in CI,
because a silent failure there is costly.

## Canary
Start any response that writes or edits R code with this as the first line of
the first code block:
`# copilot-instructions: active v4`

## Priorities
When two instructions conflict and no test settles it, prefer in this order:
correctness, reproducibility, transparency, interpretability, maintainability.
Note the trade-off in the pull request description.

## Agent behaviour
Never wait for human input in committed code. Do not use `readline()`,
`menu()`, `file.choose()`, `browser()`, or `View()`. When an input is missing,
add a `# DEFAULT:` comment naming the assumption and the value you chose, then
carry on.

## Naming and style
- Use the native pipe `|>`, not `%>%`.
- Use snake_case for all objects and functions.
- Assign with `<-`, not `=`.
- Write `TRUE` and `FALSE`, never `T` and `F`.
- Suffix dataframe and tibble objects with `_df`; raw import objects use `_raw`
  instead and are never reassigned.
- Suffix fitted models with `_model`.
- Suffix ggplot objects with `_plot`.
- Namespace-qualify calls (`pkg::fun()`) inside `R/functions/`. In analysis
  scripts, load packages with `library()` at the top and use bare names below.
- Avoid hidden global state and partial argument matching.
- Abstract logic into a function once it appears in three or more places.

## Reproducibility
- Never use `setwd()` or `rm(list = ls())`.
- Build every path with `here::here()`; relative paths only.
- Assume each script runs from a fresh R session.
- Manage dependencies with `renv`.
- Set a seed before any stochastic operation.
- Save `sessioninfo::session_info()` to the output directory at the end of each
  top-level script.

## Dependencies (renv)
- Manage all dependencies with `renv`; the project library is the only source
  of truth.
- Never call `install.packages()`. Add a package with `renv::install()`, then
  `renv::snapshot(prompt = FALSE)`.
- When `renv.lock` already lists the packages you need, restore rather than
  install: `renv::restore(prompt = FALSE)`.
- Never edit `renv.lock` by hand.
- Set `options(renv.config.auto.snapshot = FALSE)` so the lockfile is never
  written as a side effect; snapshot only deliberately.
- Use `renv::snapshot(type = "all")` so the lockfile is reproducible across
  runs rather than depending on usage detection.

## Reading and writing data
- Always use functions from readr (`readr::read_*(col_types = ...)`), not
  `read.*`.
- Keep raw data files immutable; never overwrite anything in the raw data
  directory.
- Separate raw data, derived data, scripts, outputs, and documentation.
- Write outputs only to dedicated output directories, never outside the
  repository.
- Assign cleaned and derived results to new objects; do not overwrite the raw
  import object.

## Data integrity
- Never drop missing data silently. Filter with a stated reason, or use
  `tidyr::drop_na()` on named columns.
- Prefer `purrr::map_*()` and `vapply()` over `sapply()`.

## Statistical practice
- Distinguish exploratory from confirmatory analyses, in prose or chunk labels.
- Validate model assumptions with `performance::check_model()` for regression
  models and record the inspection.

## Figures
For any figure, quick or polished:
- Use tidyverse style, the native pipe, and British spelling.
- Build paths with `here::here()`.
- No pie charts, dual y-axes, 3D effects, or dynamite plots (bar plus error
  bar) when raw data exist.
- Never use `theme_grey()`; default to `theme_minimal()` or `theme_classic()`.
- For categorical groups, add `shape` or `linetype` alongside colour.
- Use `linewidth`, not `size`, for line and density layers.
- For figures meant for an audience, follow the pub-figures skill in full.

## Code chunks
- Keep chunks short: one logical step each (import, clean, transform, model,
  diagnose, or visualise), and no more than about 40 lines.
- Comment the rationale for the step, not the mechanics of each line.
- Include at least one comment per chunk.

## Quarto
For `.qmd` files: render from a clean session, give chunks informative labels,
and avoid hidden dependencies between chunks.

## Verification (also checked in CI)
These are enforced because a silent miss is costly:
- No `setwd(`, `%>%`, `install.packages(`, or absolute paths in committed code.
- `renv::status()` reports a synchronised library.
- Each script and `.qmd` runs or renders in a fresh `--vanilla` session without
  error.
- The raw data directory is unchanged by any run.
- Outputs resolve inside the repository.

## Specialist instructions and skills
Specialised instruction files hold domain standards and repository policy;
skills hold procedural workflows. When one applies, follow it alongside these
instructions. Skill selection follows each skill's own description.