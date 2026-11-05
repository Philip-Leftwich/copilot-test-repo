---
name: "tada-r-code"
description: Evaluates R analysis code (scripts, R Markdown, Quarto) against the TADA guidelines and the four Rs of code review, then, only with approval and on a new git branch, makes enabling changes, captures a frozen reference, refactors and modernises to current tidyverse under a characterisation test, annotates, and finally makes any behaviour changes the user chooses. Use when the user asks to review, audit, refactor, functionalise, modernise, annotate or prepare R analysis code for sharing, archiving, journal submission, a data editor or code review, or asks whether code meets TADA or SORTEE. Do not use for debugging a specific error, explaining what code does, writing a new analysis from scratch, or general questions about reproducibility; answer those directly, but suggest this skill if the user is about to change code that produced reported results.
compatibility: The improve stage needs a shell with git and Rscript running inside the user's own git repository (Claude Code or Cowork). Without that, the skill evaluates statically and hands the user exact files and commands to run themselves.
---

# Evaluate and improve R analysis code against TADA

This skill applies one standard in a fixed order: check git, evaluate, agree a plan, improve on a new branch, re-evaluate. The standard is the TADA-Wiki's synthesis of the TADA guidelines, the SORTEE data and code quality-control guidelines, and the four Rs of code review, with the departures listed in `references/sources.md`.

Evaluation comes first because analysis code is the record of how published numbers were produced. An unrequested rewrite can change results without any error, and without a baseline nobody can say whether a change was an improvement.

## 0. Establish the mode and the git state

**Project mode.** You can run git and Rscript inside the user's project, with their data, package library and history. **Hand-off mode.** The code was pasted or uploaded into a chat, or you are in a sandbox that is not the user's project. In hand-off mode, do not execute the user's analysis or code you have written: the sandbox lacks their data, package versions and history, so a run there proves nothing. Give the user exact commands and files, and wait for them to paste the output verbatim. State the mode in one line.

Then check git (run the commands in project mode; ask the user to run them in hand-off mode):

1. `git rev-parse --is-inside-work-tree`. If the project is not a git repository, say so at the top of the report. The read-only evaluation may proceed, but nothing is changed until the user has initialised a repository and committed the current state as the record of the original code. Do not do this yourself: what to commit, and what to keep out (large or sensitive data), is the user's decision.
2. `git status --porcelain`. If anything is uncommitted, say so; nothing is changed until the user has committed or stashed it, so that work starts from a known commit.
3. Record the branch and commit: `git branch --show-current` and `git rev-parse HEAD`.

## 1. Evaluate (the default; read-only)

1. **Inventory.** Scripts and their run order; what each reads and writes; packages loaded and their installed versions (`packageVersion()`); whether `README`, `LICENSE`, an `.Rproj` file, `renv.lock`, `tests/` and `tests/fixtures/` exist.
2. **Assess.** Read `references/tada-rubric.md` and grade every criterion as Pass, Partial, Fail or Not assessable, citing file and line. A criterion that depends on material you have not seen (the manuscript, the archive, a fresh run) is Not assessable; say what would settle it. Never infer a Pass.
3. **Execution checks** (project mode, with permission only). A run can be slow, write files or overwrite outputs. Run in a fresh R process from the project root, for example `Rscript scripts/01_clean_data.R`.
4. **Report** in the chat, following `assets/evaluation-report-template.md`. Sort every proposed change into one of four groups:
   - **Enabling:** the smallest edits without which a meaningful reference cannot be captured, such as seeds, paths, interactive calls, defunct functions, or results never assigned to an object. See `references/enabling-changes.md`.
   - **Refactor and modernise:** edits to executable code intended to leave results unchanged, such as moving code into functions, namespacing, pipes and superseded functions. These run under a characterisation test. See `references/modernisation.md`.
   - **Annotation and documentation:** comments, headers, section markers, README, LICENSE.
   - **Behaviour changes:** anything that can change a result by choice, such as bug fixes, missing-value handling or sorting. These are the user's decision.
5. **Stop.** Ask which items to implement. Edit nothing in this stage.

## 2. Improve (only the items the user approved)

1. **Branch.** Before the first edit, propose a branch name (`tada/<yyyy-mm-dd>-<short-description>`, for example `tada/2026-10-26-functionalise-summary`). Once the user agrees, confirm that `git status --porcelain` is empty and create the branch from the current commit with `git switch -c <name>`. All work happens on this branch. The user reviews and commits at each gate and decides when to merge; never commit, merge or push yourself.
2. **Enabling changes**, one type per change, following `references/enabling-changes.md`. These precede the reference, so no test can check them: each must be small enough to verify by reading its diff. The user commits them.
3. **Capture the reference** once, broadly, following `references/characterisation-refactor.md`. The user commits it.
4. **Refactor and modernise** under the characterisation test, one type of change at a time, following `references/characterisation-refactor.md`, `references/r-conventions.md` and `references/modernisation.md`.
5. **Annotation and documentation**, following the Annotated and Documented criteria and `assets/README-template.md`.
6. **Behaviour changes**, one at a time. For each, state what will change, why, which outputs it affects and the expected direction of the difference. The characterisation test will then fail by design; report this. Whether to recapture the reference is the user's decision and the user's action. Known-answer tests may be added now.

Throughout, keep the user's analytical choices (model family, exclusion criteria, thresholds). If one looks wrong, report it under Reliable; do not change it.

TADA's Documented checklist and the SORTEE guidelines require disclosure of large language model use in code generation. After any edit, draft the README "LLM use" line describing what you changed, for the user to accept or amend.

## 3. Re-evaluate (the benchmark)

Re-grade every criterion that was Fail or Partial and present a before and after table with evidence. Report test output verbatim. State plainly that a passing characterisation test shows the output is unchanged for this input, not that it is correct.

## Hard rules

- No edit before the evaluation is approved and the branch exists.
- Never edit, regenerate or delete anything under `tests/fixtures/`, and never edit `tests/make_reference.R`. Before every test run, check `git status --porcelain -- tests/fixtures`; if it reports anything, stop.
- Never change a test, tolerance or reference to make a test pass; report the difference instead.
- Never commit, merge, push or change settings files (`.claude/settings.json`, `.Rprofile`, `renv/settings.json`, `.lintr`) unless the user asks.
- Never write `setwd()`, absolute paths or `rm(list = ls())`.
- Cite only from `references/sources.md`, with its verification status; never cite from memory.

## Bundled files

- `references/tada-rubric.md`: graded criteria with R detection notes. Stages 1 and 3.
- `references/enabling-changes.md`: what may change before capture, and how each is verified.
- `references/characterisation-refactor.md`: capture, lock, refactor and test gates.
- `references/r-conventions.md`: house style, including which calls are namespaced.
- `references/modernisation.md`: defunct, superseded and look-alike changes, and how each is classified.
- `references/sources.md`: attribution, departures from TADA, references and verification status.
- `assets/`: report template; capture, packages, function and test templates; the wiki's README template and licence.
