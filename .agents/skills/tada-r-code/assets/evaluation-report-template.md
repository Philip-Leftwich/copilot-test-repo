# Evaluation report structure

Write the report in the chat, in plain prose and tables, in this order. Every judgement cites file and line. Keep it as short as the findings allow.

---

**TADA evaluation: [project or file name]**
Git: [branch and commit hash; working tree clean or not] (or "not a git repository": no change can be made until the user creates one and commits the current state)
Mode: [project | hand-off]. Examined: [files]. Not available: [manuscript, archive record, data, a fresh run].

**Summary**

| Principle | Pass | Partial | Fail | Not assessable |
|---|---|---|---|---|
| Transferable (T1–T7) | | | | |
| Available (A1–A6) | | | | |
| Documented (D1–D12) | | | | |
| Annotated (N1–N8) | | | | |
| Four Rs (R1–R4) | | | | |

**Must fix**, ordered by consequence for running and reproducing the analysis:

1. [T3] `scripts/01_clean_data.R`, line 4: absolute path `"C:/Users/..."`. Proposed: `here::here("data", "raw", "caterpillars_2024.csv")`. Group: enabling; verified by comparing checksums of the old and project copies.

**Would be nice**

1. [N5] ...

**Worked well**

1. ...

**Questions only you can answer** (mainly R3, Reliable)

1. Is `mass` recorded in grams or kilograms?

**Proposed plan. Nothing has been changed.**

- Branch: `tada/[date]-[description]`, created from [commit] once you agree.
- Enabling (before capture; each states whether results should change and how it is verified): ...
- Capture: scripts in run order; expected fixture size.
- Refactor and modernise (under the characterisation test, one type at a time): ...
- Annotation and documentation: ...
- Behaviour changes (your decision, after everything above): ...

Which items should I implement?

---

For the stage 3 re-evaluation, replace the summary with a before and after table covering every criterion that was Fail or Partial, add the characterisation test output verbatim, and draft the README "LLM use" line describing the changes made.
