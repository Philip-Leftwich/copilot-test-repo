# Enabling changes

The smallest edits without which a meaningful reference cannot be captured. They are made on the new branch, after the plan is approved and before capture.

Because no reference exists yet, no test can check them. That is the reason for the rules below: each must be small enough for the user to verify by reading its diff, and each must state in advance whether it should change results.

## When a change counts as enabling

Only when, without it, the code cannot do one of three things:

1. run unattended, in a fresh R process, from the project root;
2. give the same result every time it runs;
3. leave its results in named objects or files that the capture script can save.

Anything else waits for the refactor or behaviour-change stages, however tempting.

## Catalogue

| Problem | Enabling change | Should results change? | How it is verified |
|---|---|---|---|
| `setwd()` or absolute paths | `here::here()` paths to the copy inside the project | No | Compare `tools::md5sum()` of the old and project copies. If they differ, stop: the project copy is not the file that produced the results |
| Interactive calls (`View()`, `file.choose()`, `readline()`, `menu()`, `browser()`) | Remove; replace `file.choose()` with the fixed path | No | Diff |
| A package used but never loaded (it worked because it was attached in the author's session) | Add the `library()` call | No, unless it masks a function already in use | The run completes |
| Defunct functions under the installed package versions (for example, the dplyr 1.2.0 removals listed in `modernisation.md`) | The user chooses: install the versions the code last ran with (for example, with `renv`) and capture under those, then upgrade as a separate tested refactor; or replace the failing calls minimally now | First route: no. Second route: possibly | First route: none needed. Second route: diff and the user's judgement |
| Unseeded random numbers | `set.seed()` at the start of each independently runnable section, before the first random draw. Parallel code needs the parallel framework's own seeding option: a seed set in the main session does not control the workers' streams | Yes, by design | Run twice; the outputs must be identical |
| Results printed but never assigned (`summary(model1)` at the console; a figure piped straight from data) | Assign them to named objects (`abundance_summary <- summary(model1)`; `figure_1_data <- ...` before plotting) | No | Diff |
| The input to code that will be moved is overwritten later in the script | One added line keeping a copy under a new name immediately before that code (`metabolic_input <- metabolic_data`) | No | Diff |
| A script uses objects left in the session by an earlier script | The earlier script saves the object with `saveRDS()` and the later one reads it with `readRDS()`, which return the object exactly; a CSV round trip can change column types | No | Each script runs in its own fresh process |

Values that change on every run, such as `Sys.time()`, `Sys.Date()` or `tempfile()` names, are not enabling changes. List them in the plan; the test removes those named fields from both sides before comparing, and says so in a comment.

## Rules

- One type of enabling change per change set, so that each diff is reviewable on its own. The user commits each.
- In the plan, state for each change whether results should change and how it will be verified, as in the catalogue.
- **Seeds and the manuscript.** Once a seed is added, re-runs will generally not reproduce numbers from an earlier unseeded run, including any already published. Say so, and draft the README note that SORTEE Stage 6 expects when results cannot match exactly.
- If an enabling change turns out to be larger than a few lines, stop and discuss it with the user. It is probably a refactor or a behaviour change.
