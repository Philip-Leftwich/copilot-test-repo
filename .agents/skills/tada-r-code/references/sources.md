# Sources, attribution and verification status

## Attribution

The evaluation criteria are adapted from the TADA-Wiki: Ivimey-Cook, E. R. (2026). *TADA-Wiki: Best practice for sharing analytical code.* https://github.com/EIvimeyCook/TADA-Wiki, commit 197043f448a439d6230ceda3a4504f25bbc5fa74 (25 October 2026). The wiki text is licensed CC BY 4.0; its templates are licensed MIT (licence in `assets/TADA-Wiki-LICENSE.txt`). `assets/README-template.md` is the wiki's template, unaltered.

Changes made in this skill: the checklists were condensed and reorganised into a graded rubric with identifiers and severities; R detection notes, the git and branch workflow, the four groups of change, the enabling-change catalogue, the modernisation catalogue and the characterisation-refactor procedure were added. These additions are not findings of the source papers.

Deliberate departure from TADA, at the user's direction: TADA's Annotated checklist asks for every package to be called by namespace (`package::function()`). This skill namespaces only dplyr and a short list of functions with known clashes, and attaches packages in one file (criterion N6, `r-conventions.md`).

The wiki asks that users cite the underlying papers rather than the wiki.

## References

Verification status is as of 26 October 2026. "PubMed" means the citation was matched to a PubMed record; "wiki only" means it is taken from the wiki's reference list and was not checked against a bibliographic database. When citing any of these to the user, state its status; never cite from memory.

- Ivimey-Cook, E. R., Culina, A., Dimri, S., Grainger, M. J., Kar, F., Lagisz, M., Moran, N. P., Nakagawa, S., Roche, D. G., Tattan, S., Sánchez-Tójar, A., Windecker, S. M., & Pick, J. L. (2025). TADA! Simple guidelines to improve analytical code sharing for transparency and reproducibility. *EcoEvoRxiv* (preprint, not peer reviewed). https://doi.org/10.32942/X2D93K. Wiki only.
- Pick, J. L., et al. (2026). The SORTEE guidelines for data and code quality control in ecology and evolutionary biology. *Peer Community Journal* 6: e20. https://doi.org/10.24072/pcjournal.687. Wiki only.
- Ivimey-Cook, E. R., Pick, J. L., Bairos-Novak, K. R., et al. (2023). Implementing code review in the scientific workflow: Insights from ecology and evolutionary biology. *Journal of Evolutionary Biology* 36: 1347–1356. https://doi.org/10.1111/jeb.14230. PubMed, PMID 37812156.
- Trisovic, A., Lau, M. K., Pasquier, T., & Crosas, M. (2022). A large-scale study on research code quality and execution. *Scientific Data* 9: 60. https://doi.org/10.1038/s41597-022-01143-6. PubMed, PMID 35190569. (74% of over 9,000 archived R files failed to run without error, as reported in the wiki.)
- Hardwicke, T. E., et al. (2021). Analytic reproducibility in articles receiving open data badges at the journal Psychological Science: An observational study. *Royal Society Open Science* 8: 201494. https://doi.org/10.1098/rsos.201494. Wiki only.
- Archmiller, A. A., et al. (2020). Computational reproducibility in The Wildlife Society's flagship journals. *The Journal of Wildlife Management* 84: 1012–1017. https://doi.org/10.1002/jwmg.21855. Wiki only.

## Software behaviour

Checked on 26 October 2026 against the packages' source, NEWS files or documentation on GitHub (main branches), or CRAN package NAMESPACE files via the GitHub CRAN mirror:

- dplyr: `.by` ordering; `arrange()` C-locale default; `summarise()` grouping default; `filter()` treatment of `NA`; join `relationship`; `if_else()` type rules; the 1.1.0 additions (`.by`, `join_by()`, `reframe()`, `pick()`, `case_when(.default = )`); the 1.2.0 defunct list and `case_match()` soft-deprecation; superseded status of `top_n()`, `sample_n()` and the scoped verbs.
- tidyr: superseded status of `gather()` and `spread()`. purrr: `map_dfr()` superseded and `list_rbind()` added in 1.0.0. lifecycle: definition of "superseded".
- testthat: `local_edition()` scope; `expect_error()` `class`, `regexp` and returned condition; `expect_equal()` labels. rlang and cli: extra condition fields passed through `cli_abort()`; `.obj_type_friendly`.
- lintr linters; readr's differences from base readers; the tidyverse style guide on pipes; conflicted's `conflicts_prefer()`; here's documented clash with plyr; `Sys.chmod()` on Windows (read-only attribute only).
- Masking pairs in `r-conventions.md`: exports checked in the NAMESPACE files of plyr, MASS, data.table, maps, Matrix and terra.
- Claude Code permissions: Edit rules cover all built-in file-editing tools, follow gitignore patterns, and do not apply to shell subprocesses (https://docs.anthropic.com/en/docs/claude-code/iam; https://code.claude.com/docs, permissions page).

Packages change; if a claim matters to a decision, check the installed version's documentation.
