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
