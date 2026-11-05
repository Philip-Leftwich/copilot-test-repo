# TADA rubric for R analysis code

Adapted from the TADA-Wiki checklists (`templates/tada-checklist.md` and `templates/code-review-checklist.md`) and chapters, commit 197043f. IDs, severities and the R detection notes are additions for this skill, not findings of the source papers.

## Contents

1. Grading
2. T: Transferable
3. A: Available
4. D: Documented
5. A: Annotated (IDs N1 to N8)
6. The four Rs of code review
7. SORTEE mapping
8. Optional automated checks

## 1. Grading

- **Pass:** you saw evidence that the criterion is met.
- **Partial:** met in some files or in some respects; say which.
- **Fail:** you saw evidence that it is not met.
- **Not assessable:** depends on material you have not seen. Say what would settle it.

Severity follows the wiki's review worksheet: **M** (must fix) and **N** (would be nice). Record what worked well as well as what failed; the worksheet treats this as part of the review.

Summarise each principle as "Pass n of m assessable". Do not compute an overall percentage: the criteria are not of equal weight, and a single number hides which ones failed.

## 2. T: Transferable

Anyone can open, view and run the code without conversion or alteration, on another computer and operating system.

| ID | Criterion | How to check | Sev |
|---|---|---|---|
| T1 | Each script has its language's extension (`.R`, `.Rmd`, `.qmd`); no code exists only in `.docx` or `.pdf` | File listing | M |
| T2 | No `setwd()` anywhere | Search for `setwd(` | M |
| T3 | No absolute or user-specific paths | Search string literals for `/Users/`, `/home/`, `C:/`, `C:\\`, `~/`, `Dropbox`, `OneDrive`, `Desktop` | M |
| T4 | Paths built with `here::here()`, or relative to the project root; a root marker (`.Rproj`, `.here` or `.git`) exists so `here()` resolves | Read every file read and write call | M if paths cannot resolve; N if relative without `here()` |
| T5 | Data, code and materials are in one project directory; nothing is read or sourced from outside it | Compare every path with the project tree | M |
| T6 | The README says how to open the project (`.Rproj`, or open the folder) | README | N |
| T7 | Runs in a fresh R process, with no dependence on objects, options or packages left from an interactive session | Static signs of failure: `rm(list = ls())` at the top (it removes objects, not loaded packages or options); objects used before they are created; a script relying on objects from a previous script without reading that script's saved output. A Pass needs a fresh run | M |

## 3. A: Available

The code is publicly archived with long-term access. Almost none of this can be judged from code: ask the user, and grade Not assessable unless the README or the user supplies the evidence.

| ID | Criterion | Sev |
|---|---|---|
| A1 | Deposited in an immutable, freely accessible repository (Zenodo, Figshare, Dataverse) with a persistent identifier (DOI or SWHID) | M |
| A2 | The identifier is cited in the manuscript text and the reference list | M |
| A3 | The version-specific identifier matches the code that produced the published results | M |
| A4 | If developed on GitHub, a release was created and linked to Zenodo or Figshare (GitHub is not an archive) | M |
| A5 | Nothing exists only as supplementary material; restricted data have a documented access route | M |
| A6 | For double-blind review, an anonymised copy exists and files were checked for names, email addresses and personal paths (T3 hits are also anonymity leaks) | M where applicable |

## 4. D: Documented

Accurate metadata, usually a README at the project root.

| ID | Criterion | Sev |
|---|---|---|
| D1 | `README.md` or `README.txt` at the top level | M |
| D2 | Manuscript title and abstract; authors with a contact email; funders | N |
| D3 | R version and key packages, each with version numbers | M |
| D4 | Full environment recorded (`sessionInfo()` output or `renv.lock`), included or referenced | N |
| D5 | Where the data are, with a persistent identifier if archived separately | M |
| D6 | What each file contains | M |
| D7 | The order in which to run the code | M |
| D8 | What each script reads and writes | M |
| D9 | Slow, memory-hungry or specialist-hardware steps flagged, with saved outputs archived for them | M if any step is slow; otherwise N |
| D10 | Every variable in every data file described, with units | M |
| D11 | A licence chosen, stated in the README and attached (a `LICENSE` file or repository setting); data and code licences each suit what they cover | M |
| D12 | Use of large language models in code generation disclosed (a SORTEE requirement, also on the TADA checklist) | M |

`assets/README-template.md` is the wiki's README template (MIT; licence in `assets/TADA-Wiki-LICENSE.txt`). Its fields cover D1 to D12; use it when drafting or completing a README.

## 5. A: Annotated (IDs N1 to N8)

Comments within each code file, or code embedded in R Markdown or Quarto with descriptive text.

| ID | Criterion | How to check | Sev |
|---|---|---|---|
| N1 | Each script opens with a header: what it does, what it produces, which script runs before it | First lines | M |
| N2 | Code in logical, labelled chunks; long scripts use RStudio section markers (`#####` or `#----`) | Read | N |
| N3 | Each chunk states what it does and why it is needed | Read | M |
| N4 | Each chunk producing a result signposts its manuscript location (Figure 2A, Table 1, a named Results section) | Read | M |
| N5 | Object names interpretable by someone who did not write the code | Flag `df2`, `tmp`, `x`, `model1` without a comment | N |
| N6 | dplyr functions, and the other known clashes listed in `r-conventions.md`, are called by namespace; packages are attached in one place. This deliberately relaxes TADA's checklist, which asks for every call to be namespaced | Search for bare calls to the listed functions | N |
| N7 | No unused `library()` calls | For each attached package, search for its functions; state that this is a heuristic. Removing one is a refactor under the test, because it can change which function runs | N |
| N8 | For R Markdown or Quarto, the source is archived, not only rendered output, and it renders top to bottom from a clean session | File listing; a render needs execution | M |

Style is not annotation: a neatly formatted script with no comments still fails N3 and N4.

## 6. The four Rs of code review

From Ivimey-Cook et al. (2023), as presented in the wiki.

**R1 Reported: does the code match what the methods section says was done?** Needs the methods text; Not assessable without it. With it, map each analysis described in the methods to code, and each substantive code step to the methods. Check model family, link, fixed and random effects, and filtering and exclusion criteria. Software and key package versions should appear in both the manuscript and the README. Sev M.

**R2 Run: can the code be executed?** A Pass needs a run from a fresh copy in a fresh session without manual fixes. Static checks: every package used is loaded or namespaced within the code; every file read exists in the project under that exact name; column names used in the code exist in the data files (when the data are available). Sev M.

**R3 Reliable: does it give the correct result, not merely a result?** This needs someone who knows the data, so report red flags and questions, not verdicts:

- columns selected or indexed by position (`df[, 3]`, `select(2:4)`, `across(3:5)`) rather than by name;
- joins without an explicit key (`by = dplyr::join_by(...)`) or without a row-count check; dplyr joins accept `relationship = "many-to-one"` and similar to assert the expected relationship;
- `filter()` conditions on columns that may contain `NA`: `filter()` treats `NA` as `FALSE` and drops those rows, so report row counts before and after;
- `na.rm = TRUE` with no record of how many values were dropped;
- unexplained thresholds and cut-offs;
- stochastic steps (`sample()`, random draws, bootstraps, MCMC, jitter in plots) without `set.seed()` at the start of each independently runnable section;
- user-defined functions without tests;
- intermediate outputs never compared with saved ones (the wiki suggests `identical()` for this).

End with questions only the user can answer, for example "Is `mass` in grams or kilograms?". Sev M for confirmed errors.

**R4 Reproducible: do the outputs match the manuscript?** Needs manuscript values and a run. Take three numbers from the results section and find them in the output. SORTEE Stage 6 expects an exact match unless the code metadata explains why results may differ (stochastic methods, figure post-processing, software versions). Where a tolerance is justified, use either:

- percentage error, PE = (new − original) / original × 100, judged on its absolute value: 0 is no error, above 0 and below 10 is minor, 10 or above is major and not reproducible (Hardwicke et al. 2021);
- conclusion and numbers: the same direction and significance, and intervals matching within one significant figure (Archmiller et al. 2020).

Sev M.

## 7. SORTEE mapping

The wiki's own mapping, not the SORTEE paper's, useful when the user is preparing for a data editor: Transferable covers Stages 1.4, 3.4 and, in practice, 5; Available covers 1.1 and 3.1; Documented covers 1.2, 1.5, 3.2 and 3.5; Annotated covers 3.5 and makes Stage 4 assessable. Stages 1.3, 3.3 (completeness), 2 (data match the manuscript) and 6 (results reproduce) are outside TADA. Data editors check minimum standards; they do not review code reliability, which is what R3 is for.

## 8. Optional automated checks

In project mode, and only if `lintr` is already installed (do not install packages without asking), these linters cover T2 and T3 mechanically. The default undesirable-function list also flags `library()` and `source()`, which would swamp the report, so pass an explicit list:

```r
lintr::lint_dir(
  here::here("scripts"),
  linters = list(
    absolute_path = lintr::absolute_path_linter(),
    nonportable_path = lintr::nonportable_path_linter(),
    undesirable_function = lintr::undesirable_function_linter(
      fun = c(setwd = "build paths with here::here() instead", attach = NA)
    )
  )
)
```

Treat lint output as evidence for a judgement, not as the judgement.
