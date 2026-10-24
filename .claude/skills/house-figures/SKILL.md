---
name: house-figures
description: >-
  Applies this project's conventions to any ggplot2 figure that will appear
  in a report, poster or paper. Use when asked to create, revise or polish a
  figure for presentation. Not for quick exploratory plots.
---

# House figure style

## Rules
1. Where any group has fewer than 30 observations, show every observation
   (jittered points or a dot plot) with a summary overlaid. Never draw a bar
   with error bars ("dynamite plot").
2. Colour categorical groups with the Okabe-Ito palette
   (grDevices::palette.colors(palette = "Okabe-Ito")), and map the same
   variable to point shape so the figure works without colour.
3. Axis titles give the quantity and its unit, for example "Body mass (g)".
4. Use theme_classic(base_size = 12).
5. Show the number of observations per group on the figure.
6. Never add p-values or significance markers unless the user supplies a
   fitted model and asks for them.

## Before returning code
List which rules you applied, and any you could not apply and why.
