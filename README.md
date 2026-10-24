# Workshop repository: AI-assisted R (Day 4)

Your own copy of the Day 4 template for *Advancing in R*. Blocks 2 to 8, and
the self-study page on the Copilot cloud agent, all work in this repository.
The course pages tell you what to do in each block.

## Getting started

1. Fork and clone it, and open it as a project:
   `usethis::create_from_github("<owner>/<repo>", fork = TRUE)`.
2. In the R console, run `renv::restore()` once to install the package
   versions in `renv.lock`.
3. Check that everything works: `testthat::test_dir(here::here("tests"))`.
   Expect no failures; tests for blocks you have not done yet are skipped.

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
