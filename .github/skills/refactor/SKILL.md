---
name: refactor-inline-pipeline
description: Extract an inline R analysis pipeline into a documented set of reusable functions and write a test against a human-captured reference. Use whenever the user asks to move an inline pipeline or computation into a function, refactor an analysis script in scripts/, separate a function from its calling script, or add a test that compares against a stored reference fixture (.rds or similar). Trigger even when the user does not say the word "skill", as long as the task is refactoring an inline computation into a function and testing it.
---

# Refactor inline pipeline into a documented, tested function

This skill encodes a two-stage procedure for lifting an inline analysis pipeline
into a reusable function and verifying it against a human-supplied reference. The
two stages occupy distinct turns and are never combined, because writing the test
in the same turn as the refactor invites tests that pass by construction rather
than tests that verify intent.

## Stage 1 — refactor only

- Move the inline computation into a function placed under `scripts/functions/`.
- Make this folder if it does not already exist.
- Document the function with a complete roxygen2 block covering `@param`,
  `@return`, and at least one `@examples` entry.
- Validate inputs explicitly at the top of the function body. Use `stopifnot()`
  for simple invariants, or `rlang::abort()` with a condition class for errors a
  caller should be able to handle programmatically.
- Have the calling script source the function and call it. Remove the inline
  code rather than commenting it out.
- Do not author or modify any tests in this stage. Do not touch anything under
  `tests/`.

## Stage 2 — test only

- Write the test in a separate turn from the refactor.
- Load the human-captured reference fixture. Never create, regenerate, or modify
  any fixture: a reference derived from the code under test verifies only
  self-consistency, not correctness.
- Run the function on the same inputs the fixture was captured from.
- Grouped output may carry an unspecified row order (a known risk with `.by` and
  no trailing `arrange()`). Sort both the result and the reference on a key set
  that is unique per row before comparison, so that only row order is neutralised.
  If the grouping keys alone do not give a total order, sort on additional columns
  until the ordering is deterministic, otherwise the comparison can still fail
  spuriously on tied rows.
- Compare with `expect_equal()` on the full objects, retaining types and
  attributes, so the test catches value, type, and structural regressions.

## Invariants that always hold

- The two stages occupy distinct turns and are never combined.
- The agent never writes a test that depends on output it generated in the same
  session.
- The fixture is treated as read-only ground truth.

## R conventions

- Provide tidyverse solutions where possible.
- Use British spelling in prose and comments.