---
applyTo: "**/*.qmd"
---

# Quarto document conventions

These rules apply to Quarto source files only. They concern how code is
presented and rendered in the document, not the analysis logic itself.

## Chunk options
- Set chunk options with the hashpipe (`#|`) inside the chunk, not in the
  `{r}` header. For example `#| echo: false`, not `{r, echo=FALSE}`.
- Give every code chunk a label (`#| label: fig-mass-by-arm`) so cross-
  references and cached results are stable.
- Every chunk that produces a figure must set `#| fig-cap:` with a caption;
  do not emit an uncaptioned figure into a rendered document.

## Echo and output for a written report
- Default to `#| echo: false` so the rendered document shows results, not
  source, unless the document is explicitly a code walkthrough.
- Use `#| warning: false` and `#| message: false` on chunks that load
  packages or fit models, so loading noise does not appear in the output.

## Figures
- Label figure chunks with a `fig-` prefix and reference them in prose with
  `@fig-...`, not by a hardcoded number.
- Set figure dimensions explicitly with `#| fig-width:` and `#| fig-height:`
  rather than relying on defaults.

## Reproducibility
- Resolve paths with `here::here()` inside chunks; never assume the working
  directory is the document's folder, because Quarto and the R session may
  differ on this.