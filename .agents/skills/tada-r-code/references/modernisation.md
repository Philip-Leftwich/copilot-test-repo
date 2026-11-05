# Modernising to current tidyverse

## Principles

1. **Modernise only what earns its place.** Defunct code must change, because it no longer runs. Superseded functions have a known better alternative but are not going away (the tidyverse lifecycle definition), so replacing them is optional; propose it where the replacement is clearly more readable, not as churn.
2. **One type of change at a time** (for example, every `gather()` in the project in one change set), each under the characterisation test, so that a failure has one cause.
3. **Use only what the installed versions provide**, checked with `packageVersion()`, and record any raised minimum in the README (criterion D3): `|>` and `\(x)` need R 4.1; `.by`, `join_by()`, `reframe()`, `pick()` and `case_when(.default = )` need dplyr 1.1.0; `list_rbind()` and `list_cbind()` need purrr 1.0.0. If the project uses `renv`, the lockfile must be updated to match; that is the user's action.
4. **Published code is not modernised in place.** If this code is the archived version behind a paper, modernising produces a new version that did not produce the published results. Work on the branch, release it as a new version, cite the passing characterisation test as evidence of equivalence, and never replace the archived version (criterion A3).

## Tier 1: defunct, so it must change (an enabling change)

dplyr 1.2.0 made the following defunct; they now throw an error:

- the underscored verbs (`filter_()`, `mutate_()`, `select_()`, `summarise_()`, `group_by_()`, `arrange_()` and the rest);
- `mutate_each()` and `summarise_each()` (use `across()`);
- `summarise()` returning more or fewer than one row per group (use `reframe()`, which always returns an ungrouped result);
- `combine()`, `tbl_df()`, `as.tbl()` and `add_rownames()`;
- the `add` argument of `group_by()` (use `.add`).

If the installed dplyr is 1.2.0 or later and the code uses any of these, it will not run, so a reference cannot be captured until the user chooses one of the two routes in `enabling-changes.md`. `case_match()` is soft-deprecated in 1.2.0 (replaced by `recode_values()` and `replace_values()`): still working, so not yet an enabling change, but worth flagging.

## Tier 2: superseded, replaced under the test

| Old | Current | Known differences to watch |
|---|---|---|
| `%>%` | `|>` | `|>` has no `.` placeholder, `%$%` or `%<>%`; keep `%>%` where the code uses them |
| `mutate_at()`, `_if()`, `_all()`; `summarise_at()`, `_if()`, `_all()`; `filter_at()`, `_if()`, `_all()` | `across()`, `if_any()`, `if_all()` | Names of new columns when several functions are applied |
| `tidyr::gather()`, `spread()` | `pivot_longer()`, `pivot_wider()` | Argument names and defaults; the order of rows and columns in the result can differ |
| `top_n()` | `slice_max()`, `slice_min()` | Row order of the result can differ |
| `sample_n()`, `sample_frac()` | `slice_sample()` | The rows drawn may differ even with the same seed; if the test fails, this becomes a behaviour change |
| `purrr::map_dfr()`, `map_dfc()` | `purrr::map() |> purrr::list_rbind()` or `list_cbind()` | Edge cases in column binding |
| `by = c("a" = "b")` in joins | `by = dplyr::join_by(a == b)` | None expected; clearer, and allows inequality joins |
| `case_when(..., TRUE ~ x)` | `case_when(..., .default = x)` | None expected |

Because the test compares row order, a difference in row order fails it. That is intended: decide whether order matters downstream (`[1, ]`, `head()`, `first()`, `lag()` depend on it) before accepting a sorted comparison.

## Tier 3: changes that look like modernisation but alter results (behaviour changes)

Never apply these as refactors. Propose them as behaviour changes, with their consequences stated.

1. **`read.csv()` to `readr::read_csv()`.** readr leaves strings as they are, parses common date and time formats automatically and ignores the session locale; it returns a tibble and does not make column names syntactic as `read.csv()` does (`check.names = TRUE`). Types, names and class can all change. The same applies to `write.csv()` and `readr::write_csv()`, whose files differ byte for byte.
2. **`group_by() |> summarise()` to `summarise(.by = )`.** With `.by`, groups appear in order of first appearance in the data; `group_by()` sorts the group keys in ascending order. The `.by` result is also ungrouped.
3. **Adding `.groups = "drop"` or `ungroup()`.** With more than one grouping variable, `summarise()` by default drops only the last grouping level, so the result stays grouped. Dropping it changes the class, and how later group-wise steps behave.
4. **Adding `arrange()`.** Changes row order. In current dplyr, `arrange()` sorts character columns in the C locale by default, which can differ from base `order()` in the user's locale. Adding an explicit sort to a function's output is often a sound behaviour change (it makes order independent of input order, which matters once `.by` is used); propose it as one.
5. **`ifelse()` to `dplyr::if_else()`.** `ifelse()` takes its attributes from the test, so dates and factors lose their class. `if_else()` determines the output type from both branches (casting them to a common type, and erroring when there is none), so the class and type of the result can change.
6. **Loops and `sapply()` to purrr.** `sapply()` guesses whether to simplify its result; typed `map_*()` functions do not, and missing-value handling can differ.
7. **Missing values and factors.** Any change to `na.rm`, `tidyr::drop_na()`, `filter(!is.na(...))`, factor levels or level order (including `forcats` reordering and `droplevels()`).
8. **Random numbers.** Moving code that draws random numbers to a different point in the run changes the stream and therefore the results.
9. **Join assertions.** Adding `relationship = "many-to-one"` (or similar) is safe only if the assertion holds. If it errors, that is a finding about the data, not a reason to remove the check.
