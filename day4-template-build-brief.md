# Build brief: the Day 4 workshop template repository

This brief has two parts. **Part A is for you, the instructor**: what is
already in place, what Claude will write, and how to start. **Part B is for
Claude**, working inside the existing GitHub repository
`{{TEMPLATE_OWNER}}/{{TEMPLATE_REPO}}`: how to turn it into the participant
template that learners fork before Day 4, together with its three checkpoint
branches.

Use it with **Claude Code** on your own machine, started in the root of the
local clone of that repository. The build has to run R, git and the test
suite. A claude.ai Project cannot run any of these, so it cannot do this job.

---

# Part A: for you

## A1. Fill these in before you start

Claude stops and asks if any is still a placeholder.

| Placeholder | Meaning | Your value |
|---|---|---|
| `{{TEMPLATE_OWNER}}` | GitHub user or organisation that owns the repository (the login, as in the remote URL) | Philip-Leftwich |
| `{{TEMPLATE_REPO}}` | Repository name; also the `.Rproj` name | copilot-test-repo |
| `{{COURSE_DATE}}` | Date used in the checkpoint AI-log lines, as `YYYY-MM-DD` | 2026-10-23 |
| `{{BASE_FOR_MAIN}}` | What the new `main` starts from: `master` (keeps the repository's history, then replaces its contents) or `orphan` (a new branch with no history) | orphan |

## A2. What is already in place

The repository already exists, locally and on GitHub
(`origin` = `https://github.com/{{TEMPLATE_OWNER}}/{{TEMPLATE_REPO}}.git`),
and holds earlier Copilot practice material on `master`,
`copilot-agent-mode`, `copilot-skills` and `custom-copilot-instructions`.
It has no `main`, no `.Rproj` and no renv.

Every input is already in `inputs/` at the repository root:

| # | Input | Where | Why Claude needs it |
|---|---|---|---|
| 1 | This brief, with A1 filled in | `day4-template-build-brief.md` | The instructions |
| 2 | The template source files | `inputs/template-files/` (including the dot-folders) | The source of truth for every shipped file that is not data. Claude copies these verbatim. |
| 3 | The skills | `inputs/skills/` | `clean-with-codebook/` and `characterisation-refactor/` are shipped in `.agents/skills/` and `.claude/skills/`. `pub-figures/` and `research-readme/` are **not** shipped (see B2, rule 6). |
| 4 | The Day 4 pages | `inputs/pages/` (`11-AI-programming-integrated.qmd` and every `11*.qmd`) | Solutions for the checkpoint branches, and cross-checks |
| 5 | The instructor notes | `inputs/notes/` (`workshop-template-checklist.md`, `ai-blocks-instructor-notes.md`, `status-2026-10-23.md`) | The checklist is the specification; the notes hold the planted-error script and the data specification |
| 6 | The clean data | `inputs/data/voles_metabolism.csv` | Identical to the `data/voles_metabolism.csv` already tracked on this branch; it moves to `data/raw/` in the template |

None of `inputs/`, `instructor-only/` or this brief may ever be committed.
Claude keeps them out of git with `.git/info/exclude` (local to your clone,
never pushed), because the shipped `.gitignore` must stay byte for byte.

Do **not** provide `planted_errors.csv` or any answer key. Claude writes the
answer key into `instructor-only/`, which is excluded from git.

## A3. Before you start Claude

1. **Leave a clean working tree.** The current branch has uncommitted edits
   (`.github/skills/pub-figures/SKILL.md`, `scripts/01_load_data.R`,
   `scripts/02_analysis.R`) and untracked files (`.positai/`, `.vscode/`,
   `README.md`, `outputs/`, `scripts/03-plots.R`, `untitled`). Commit them
   to the branch you are on, stash them, or delete them yourself. Claude
   will not touch them, and stops in Phase 0 if any are still there.
2. **Optional: pause OneDrive.** The repository sits in a OneDrive
   folder. renv's project library and the Phase 5 clone create many small
   files that OneDrive will try to sync. Pausing OneDrive sync for the build
   avoids locked-file errors on Windows.

## A4. What Claude writes

| Output | Where | Notes |
|---|---|---|
| The template, on a new `main` branch | this repository | Every file in the checklist's *Files the template must ship* table, and nothing else |
| Files copied verbatim | this repository | Everything in `inputs/template-files/` **except** `checkpoints/`; the two course skills into both skill folders |
| Files Claude generates | this repository | `data/raw/voles_metabolism.csv` (moved from the supplied file), `data/raw/voles_raw.csv`, `tests/fixtures/raw_checksum.txt`, `data/derived/.gitkeep`, `{{TEMPLATE_REPO}}.Rproj`, `renv.lock`, `.Rprofile`, `renv/activate.R`, `renv/settings.json` |
| Three checkpoint branches | `checkpoint-skills`, `checkpoint-cleaning`, `checkpoint-refactor` | Each built on the one before, using the solutions in the pages |
| Instructor-only files | `instructor-only/` (git-excluded, never committed) | `make_dirty_voles.R`, `planted_errors.csv`, `build-report.md` |
| The build report | `instructor-only/build-report.md` | Every file and where it came from, every test result, what still needs you |

The existing branches (`master`, `copilot-agent-mode`, `copilot-skills`,
`custom-copilot-instructions`) are left exactly as they are.

## A5. What stays your job

Claude stops before anything outward-facing. You:

1. push `main` and the three checkpoint branches to `origin` (Claude gives
   you the exact commands);
2. on GitHub, make `main` the default branch, so that forks and *Use this
   template* start from it, and delete the old practice branches (by hand,
   before learners fork);
3. tick **Template repository** in the GitHub settings, if learners use it as
   a template rather than a fork;
4. put the real template name into `11a-setup-claude-code.qmd` in the course
   repository;
5. run the interactive checks that need Claude Code in the template itself:
   `/permissions` lists 17 rules, `/memory` lists `AGENTS.md`, a new session
   starts in Manual mode, the agent is refused when it edits
   `data/raw/voles_raw.csv` and allowed to write `scripts/01_clean.R`;
6. the dry run on Windows and macOS with fresh accounts, including Block 6
   with a brand-new Console key.

## A6. How to start

**1.** Fill in A1 and clear the working tree (A3).

**2. Open Claude Code in the repository root:**

```bash
cd ~/"OneDrive - University of East Anglia/Physalia/copilot-test-repo"
claude
```

**3. Give it this first prompt:**

```text
Read day4-template-build-brief.md in full, then every file it tells you to
read. Carry out Phase 0 only and stop for my approval.
```

Approve each phase as Claude reports it. Expect about an hour of Claude's
time, most of it in running tests.

---

# Part B: for Claude

## B1. Goal

Turn this existing repository into the participant template for Day 4 of
*Advancing in R*: a new `main` branch and three checkpoint branches, so that
every item in `inputs/notes/workshop-template-checklist.md` holds. Learners
fork this repository, run `renv::restore()`, and work in it all day. They
cannot see this brief, `inputs/` or `instructor-only/`.

## B2. Hard rules

1. **The answer key never enters git.** `make_dirty_voles.R`,
   `planted_errors.csv`, this brief, `inputs/` and `instructor-only/` are
   never staged on any branch. Before every commit, check that the staged
   files contain none of them and no text from them.
2. **No `CLAUDE.md`** on any branch you create, and none in the working
   tree. Claude Code would then read it instead of `AGENTS.md`.
3. **Shipped files are copied byte for byte** from `inputs/template-files/`
   and `inputs/skills/`. Do not "improve", reformat or re-wrap them. If one
   looks wrong, report it in the build report and carry on with the original.
4. **Never edit a test, a fixture or a tolerance to make a test pass.** If a
   page's solution fails a shipped test, stop and report both.
5. **Nothing outward-facing.** Do not push, fetch into, or delete remote
   branches, do not change the GitHub repository's settings, and do not
   change global git settings. Commit locally only, with the instructor's git
   identity, and with no `Co-Authored-By` or other trailers: learners fork
   these commits.
6. **Leave the existing branches and the instructor's work alone.** Do not
   commit to, rebase, reset or delete `master`, `copilot-agent-mode`,
   `copilot-skills` or `custom-copilot-instructions`. Never discard, stash
   or overwrite uncommitted changes you did not make. The material from
   those branches (`.github/`, the `pub-figures` and `refactor` skills,
   `scripts/01_load_data.R`, `02_analysis.R`, `blank_script.R`,
   `tests/metabolic_summary.rds` and so on) does not go on `main` or the
   checkpoint branches. Nor do `inputs/skills/pub-figures/` or
   `inputs/skills/research-readme/`.
7. **Add nothing beyond the checklist** without asking. Propose any file you
   think is missing (a short `README.md` is the likely one) in Phase 0.
8. **Stop at the end of each phase**, report in a few lines, and wait for
   approval. Stop sooner if anything below is ambiguous, contradicts another
   source, or a placeholder in Part A is unfilled.
9. British spelling in everything you write.

## B3. The repository

```
{{TEMPLATE_REPO}}/                   the git repository; you start Claude Code here
  .git/info/exclude                  you add inputs/, instructor-only/ and the brief here
  day4-template-build-brief.md       this file; never committed
  inputs/                            read-only for you; never committed
    template-files/                  source of truth for shipped files
    skills/                          clean-with-codebook/, characterisation-refactor/ (shipped);
                                     pub-figures/, research-readme/ (not shipped)
    pages/                           the Day 4 .qmd pages
    notes/                           checklist, instructor notes, status note
    data/voles_metabolism.csv        the clean data
  instructor-only/                   you write here; never committed
  ...                                the template's own files, on main and the checkpoint branches
```

Because the inputs live inside the working tree, they stay put when you
switch branches. Check `git status` after every switch: only the template's
files should appear, never `inputs/`, `instructor-only/` or the brief.

The pages include code with chunk options such as
`file = here::here("_instructor", "template-files", ...)`: that path means
`inputs/template-files/` here. They also use webexercises (`hide()`,
`unhide()`) and glossary calls; the code inside the hidden sections is what
you need.

Run R from the repository root with `Rscript`, so that `here::here()` and
renv resolve here.

## B4. Sources, in order of precedence

1. The shipped tests in `inputs/template-files/tests/`: they are the
   acceptance criteria.
2. `inputs/template-files/`: the shipped files themselves.
3. `inputs/notes/workshop-template-checklist.md`: what ships, what each
   branch adds, and the checks.
4. `inputs/notes/ai-blocks-instructor-notes.md`: the planted-error script,
   the data note's facts and the Block 8 data requirements.
5. `inputs/pages/*.qmd`: the solutions the checkpoint branches use.
6. `inputs/notes/status-2026-10-23.md`: what has changed. Its removal list
   (`CLAUDE.md`, `typed_numbers.R`, `reports/`, `test_readme.R`) and the
   `block5-done`/`block7-done`/`block9-done` branches refer to an older live
   template, not to this repository; report any that you do find.

If two sources disagree, stop and report. Do not choose for the instructor.

## B5. Phase 0: read and plan (then stop)

**Repository state first.** Run `git status`, `git branch -a`,
`git remote -v` and `git ls-files`. If the working tree has any change other
than the untracked `inputs/`, `instructor-only/` and this brief, stop and
ask the instructor to deal with it (A3). Then add these three lines to
`.git/info/exclude` and confirm that `git status` no longer lists them:

```
/inputs/
/instructor-only/
/day4-template-build-brief.md
```

Read all of `inputs/notes/`, every file in `inputs/template-files/` and
`inputs/skills/clean-with-codebook/` and
`inputs/skills/characterisation-refactor/`, and these parts of the pages:

- `11a-setup-claude-code.qmd`: *Your workshop repository* and the layout
  reference (the target layout);
- `11c-debugging.qmd`: what Block 2 expects of the data;
- `11d-context-disclosure-autonomy.qmd`: Exercise 2 (the `mass_change_g`
  column, the plot script, the AI-log format);
- `11e-instructions-skills.qmd`: Activity 1 (the two `AGENTS.md` edits) and
  Activity 2 (the `house-figures` skill and `scripts/fig_house.R`);
- `11k-build-an-agent.qmd`: Task 2 (`summarise_rate_tidy()` in
  `scripts/functions/summaries.R`);
- `11g-data-cleaning.qmd`: the agreed codebook (*A codebook you could agree
  on*) and the cleaning outputs;
- `11i-characterisation-tests.qmd`: Step 1 (the refactored
  `summarise_metabolic_rate()`, the new `05_analysis.R`, the characterisation
  test and the deny rule).

Then check that R, git and the packages are available
(`Rscript --version`, `git --version`, and whether tidyverse, here, testthat,
jsonlite, renv, callr, fs, usethis, gert, waldo and ellmer are installed).

Report, and stop:

- the placeholders from A1 and their values;
- the repository state: branches, remote, and that the working tree is clean
  apart from the excluded paths;
- the full file list for `main`, marked *copied*, *generated* or *written*;
- every file tracked on `{{BASE_FOR_MAIN}}` (if `master`) that will be
  removed from `main`;
- what each checkpoint branch will add, and the page each file comes from;
- any conflict between sources, and any file you propose to add;
- anything missing (packages, inputs) that the instructor must supply.

## B6. Phase 1: the data (then stop)

Work in `instructor-only/` for every script in this phase.

**1. Check the clean file, `inputs/data/voles_metabolism.csv`,** against
every requirement below. If it fails one, report which and **ask before
changing it** (the instructor notes allow reordering the rows once if they
are already sorted; nothing else). Do not generate a replacement.

| Requirement | Used by |
|---|---|
| Columns, in this order: `subject_id`, `sex`, `treatment_arm`, `mass_pre_g`, `mass_post_g`, `metabolic_rate_post` | `load_voles.R` |
| 72 rows, one per animal; IDs `V001` to `V072`, unique | Data note; test_cleaning |
| `sex` is `M` or `F`; `treatment_arm` is exactly `Control`, `Low_dose` or `High_dose`; 24 animals per arm | Block 2, Exercise 1 expects `nrow(high_dose)` of 24 |
| Mean `mass_post_g - mass_pre_g` rises from Control to Low_dose to High_dose, clearly | Block 2, Exercise 2 |
| Masses in grams, inside 15–60 with margin, one decimal place | Data note ranges; the kg and ×10 plants must fall out of range |
| `metabolic_rate_post` inside 5–30, one decimal place | Data note range |
| Exactly one missing value in the whole file, in `metabolic_rate_post`, written as an empty field; not in rows 5, 7, 12, 15, 20, 27, 33, 41, 58 or 64 (the planted rows) | test_translation (`aggregate()` drops it); Block 8, Step 2 |
| `distinct(treatment_arm, sex)` in file order is **not** already sorted | Block 8's `arrange()` lesson |
| Row 15's ID starts `V0`; rows 58 and 64 have non-missing values in the planted columns | The planted-error script |

Record in the build report which treatment arm and sex the missing value
falls in: Block 8's Step 2 discussion needs it.

**2. Create `main` and its data folder.** You need the template's
`data/raw/` and `.gitattributes` before writing any data:

- if `{{BASE_FOR_MAIN}}` is `master`: `git switch -c main master`;
- if it is `orphan`: `git switch --orphan main` (the working tree then
  keeps only untracked and excluded files).

Copy `inputs/template-files/.gitattributes` to the root, then copy the clean
file to `data/raw/voles_metabolism.csv` byte for byte. Do not commit yet.

**3. The planted file, `voles_raw.csv`.** Copy the script from the
`make_dirty_voles.R` section of `ai-blocks-instructor-notes.md` into
`instructor-only/make_dirty_voles.R`. Change only its paths: read the clean
file from `data/raw/`, write `voles_raw.csv` into `data/raw/`, and write
`planted_errors.csv` into `instructor-only/`. Run it. Check: 74 rows; raw
row 31 duplicates the original row 7; raw row 52 is the near duplicate with
a malformed ID; the answer key has ten rows.

**4. The checksum**, from the repository root:

```r
writeLines(unname(tools::md5sum("data/raw/voles_raw.csv")),
           "tests/fixtures/raw_checksum.txt")
```

Report the data checks and stop.

## B7. Phase 2: build `main` (then stop)

You are on `main`, created in Phase 1.

1. **Clear out the old material** (only if `{{BASE_FOR_MAIN}}` is
   `master`). `git rm` every tracked file that the checklist does not name,
   as listed and approved in Phase 0. This includes `.github/`,
   `data/voles_metabolism.csv` (now at `data/raw/`), `scripts/01_load_data.R`,
   `scripts/02_analysis.R`, `scripts/blank_script.R`,
   `tests/metabolic_summary.rds`, and the old `tests/make_reference.R` (the
   shipped one replaces it). Ask before removing anything not listed in
   Phase 0. The old files stay available on `master`.
2. **Copy the shipped files** from `inputs/template-files/`, keeping paths
   and dot-files, **except the `checkpoints/` folder** (it is source material
   for `checkpoint-cleaning`, not part of `main`). Every shipped file
   replaces whatever is at that path.
3. **Copy the two course skills** (`clean-with-codebook`,
   `characterisation-refactor`) into both `.agents/skills/<name>/` and
   `.claude/skills/<name>/`, as copies, not links (links fail on Windows).
4. **Add the empty folders' placeholders:** `data/derived/.gitkeep` (empty);
   `outputs/.gitkeep` comes from the template files.
5. **Add `{{TEMPLATE_REPO}}.Rproj`** with RStudio's default project settings.
6. **Set up renv.** The lockfile must pin tidyverse, here, testthat,
   jsonlite, renv, callr, fs, usethis (with gert), waldo and ellmer; not the
   *Going further* packages. Check the lockfile itself, not this list: the
   tests call callr, jsonlite and gert directly, and learners call usethis
   in the console, which renv's implicit snapshot will not see. renv must
   not snapshot packages that only `inputs/` or `instructor-only/` use: make
   sure its dependency scan ignores them (for example with a
   `renv/settings.json` or `.renvignore` entry, and only if this does not
   add a shipped file the checklist does not name; ask if it would). Choose
   the method that makes a fresh clone report no problems from
   `renv::status()` after `renv::restore()`, and say in the build report how
   you did it. Ship `.Rprofile`, `renv/activate.R` and `renv/settings.json`;
   let renv write its own `renv/.gitignore`.
7. **Do not ship** `CLAUDE.md`, `.github/`, `hooks/`, `docs/ai-log.md`,
   anything in `scratch/`, or anything learners create during the day (the
   checklist lists them).
8. **Commit** in a few logical commits with plain messages, for example
   "Remove Copilot practice material", "Add template files", "Add data and
   checksum", "Add renv". `.gitattributes` must be committed *before or
   with* the first commit that adds a data file. Then check with
   `git ls-files --eol data/` that every data file is stored with LF.

## B8. Phase 3: verify `main` (then stop)

From the repository root, in a fresh R session each time:

1. `Rscript -e "renv::status()"`: no problems.
2. `Rscript -e "testthat::test_dir('tests')"`: `FAIL 0`, `PASS 8`, the rest
   skipped. Paste the summary line in the report.
3. Each shipped script that should run on `main` runs without error:
   `scripts/explore_voles.R`, `scripts/00_profile.R` (then delete the
   `docs/profile*.csv` files it writes: learners make those in Block 7),
   `scripts/05_analysis.R`.
4. `git status` is clean, and `git ls-files` shows no answer-key file, no
   brief, nothing under `inputs/` or `instructor-only/`, no `CLAUDE.md`, no
   `.github/`, and nothing under `scratch/` or `outputs/` except `.gitkeep`.
5. `.claude/settings.json` is identical to the source and holds 17 deny
   rules, `defaultMode` `"default"` and no `allow` list.

Report and stop.

## B9. Phase 4: the checkpoint branches (then stop after each)

Build each branch from the one before (`main` → `checkpoint-skills` →
`checkpoint-cleaning` → `checkpoint-refactor`), with
`git switch -c <branch>`. Take every file's content from the page named.
Where a page gives no exact text, write the smallest version that does what
the page describes and passes the tests, follow `AGENTS.md`, and flag it in
the report as *written, not from a page*.

AI-log lines use the format the tests check,
`date; tool and model; task; what was kept or changed`, dated
`{{COURSE_DATE}}`.

**`checkpoint-skills`** (Blocks 3 and 4)

- `docs/ai-log.md` with two lines: Block 3's (the example in `11d`) and
  Block 4's.
- `mass_change_g` (`mass_post_g - mass_pre_g`) added to `voles` in
  `scripts/explore_voles.R`.
- `scripts/explore_mass_change_plot.R`: plots `mass_change_g` by treatment
  arm and saves to `outputs/` with `ggsave()`; leaves no `Rplots.pdf`.
- Two edits to `AGENTS.md`, as in `11e` Activity 1: one rule deleted from
  *Structure*, *R style*, *Reproducibility* or *Data integrity*, and one
  specific convention added. Keep the canary and the *Tests*, *Statistics*,
  *Version control* and *Working with me* sections exactly as they are.
- `.agents/skills/house-figures/SKILL.md` with the text in `11e`, and its
  copy in `.claude/skills/house-figures/`.
- `scripts/fig_house.R`: `mass_post_g` by `treatment_arm`, following every
  rule in `house-figures`, saved to `outputs/`.
- Check: the test suite has `FAIL 0` and `test_explore.R` and `test_ai_log.R`
  now pass rather than skip; both scripts run in a fresh session; `outputs/`
  stays untracked.

**`checkpoint-cleaning`** (Blocks 6 and 7)

- `scripts/functions/summaries.R` with `summarise_rate_tidy(data)`, a
  tidyverse translation that behaves like `legacy_rate_summary()` in
  `tests/test_translation.R`, including dropping the animal with the missing
  value. Add its AI-log line.
- `docs/codebook.csv`: the agreed codebook in `11g`, byte for byte, with
  `<unit>` kept for metabolic rate.
- `scripts/01_clean.R`, copied from
  `inputs/template-files/checkpoints/checkpoint-cleaning/scripts/01_clean.R`.
- Run it once. Commit the three files it writes:
  `data/derived/voles_clean.csv`, `cleaning_log.csv` and
  `exclusion_log.csv`. Do not commit the `docs/profile*.csv` files.
- Check against `instructor-only/planted_errors.csv`: raw rows 31 and 52
  excluded, five values set to `NA` (two sentinels, the `-1` code, the two
  out-of-range masses), labels recoded, the genuine missing value left as it
  was. The test suite has `FAIL 0`, and `test_translation.R` and
  `test_cleaning.R` pass rather than skip.

**`checkpoint-refactor`** (Block 8, Step 1 only)

In this order:

1. Capture the reference from the **original** `scripts/05_analysis.R` by
   running `Rscript tests/make_reference.R`, and commit
   `tests/fixtures/metabolic_summary.rds` on its own.
2. `scripts/functions/summary_functions.R`: the refactored
   `summarise_metabolic_rate()` from `11i`.
3. `scripts/05_analysis.R`: the *after refactoring* version from `11i`.
4. `tests/test_summary_functions.R`: the characterisation test from `11i`.
   It must read the `.rds` and call `summarise_metabolic_rate()`, and never
   write or regenerate the reference.
5. Add `"Edit(/tests/test_summary_functions.R)"` to the `deny` list in
   `.claude/settings.json` (the committed file, not `settings.local.json`).
   This is the one edit to that file anywhere in the build.
- Check: the test suite has `FAIL 0` and **nothing skips**; the reference is
  unchanged since its commit.

When all three are done, switch back to `main`.

## B10. Phase 5: verify as a learner would (then stop)

1. `git clone --no-hardlinks` the repository from its local path into a new
   folder **outside** the repository and outside OneDrive (for example under
   the system temporary directory), so the clone has no access to `inputs/`
   or `instructor-only/`. Check out `main` there; the clone has the
   checkpoint branches as `origin/…` and `git switch <branch>` creates them.
2. In the clone, run `renv::restore()`, then `renv::status()` and the test
   suite, on `main` and then on each checkpoint branch (`git switch`, with a
   fresh R session each time). Expected: `main` `FAIL 0 | PASS 8`;
   every branch `FAIL 0`; `checkpoint-refactor` no skips.
3. On this Windows machine, confirm that the raw-data checksum and the
   cleaning reproducibility test pass in the clone (they fail if line endings
   were converted).
4. Confirm that no file in the clone, on any of the four branches, matches
   or quotes `planted_errors.csv`, `make_dirty_voles.R` or this brief.
5. Run the checks in *Verify on the live template* in the checklist that do
   not need GitHub, and mark the rest *for the instructor*.
6. Delete the clone when the checks pass.

## B11. Phase 6: the build report and hand-off

Write `instructor-only/build-report.md` with:

1. **Inputs used**, and the values of the A1 placeholders.
2. **Every file on each branch**, marked *copied* (with its source),
   *generated* (with the script) or *written* (with the page section, or
   *not from a page*); and every file removed from `{{BASE_FOR_MAIN}}`.
3. **Data facts:** row counts, animals per arm and sex, mean mass change per
   arm, the arm and sex of the missing value, the first rows of
   `distinct(treatment_arm, sex)` in file order, and the md5 of
   `voles_raw.csv`.
4. **Test summaries**, pasted verbatim, for every branch, from the build and
   from the clone.
5. **How renv was set up**, the R version, and the package versions pinned.
6. **The checklist**, item by item: *done and verified*, *done, not
   verifiable here*, or *for the instructor*.
7. **What the instructor does next:** the commands to publish the four
   branches to the existing remote, for example:

   ```bash
   git push -u origin main checkpoint-skills checkpoint-cleaning checkpoint-refactor
   gh repo edit {{TEMPLATE_OWNER}}/{{TEMPLATE_REPO}} --default-branch main
   gh repo edit {{TEMPLATE_OWNER}}/{{TEMPLATE_REPO}} --template
   ```

   If `{{BASE_FOR_MAIN}}` is `orphan`, say that `main` shares no history with
   `master`. Note the old practice branches still on `origin`
   (`master`, `copilot-agent-mode`, `copilot-skills`,
   `custom-copilot-instructions`): the instructor will delete them by hand
   before learners fork, because forks copy every branch. Give all of
   these as commands for the instructor to run; do not run them. Then the A5
   list, and the line to change in `11a-setup-claude-code.qmd`
   (`<template-owner>/<template-repo>` → `{{TEMPLATE_OWNER}}/{{TEMPLATE_REPO}}`).
8. **Anything you could not do**, or flagged, with the reason.

End with a three-line summary in the chat and the path to the report.
