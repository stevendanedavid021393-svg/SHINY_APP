# Iris Explorer (Shiny App)

A simple R Shiny app built on R's built-in `iris` data set.

## What it includes

**Dashboard with 3 visualizations**
1. Scatter plot — chosen measurement vs. Petal.Width, colored by species
2. Histogram — distribution of the chosen measurement
3. Box plot — chosen measurement by species

**Interactive function**
- A measurement dropdown and a species checkbox group. Changing either one
  updates all three charts (via a Shiny `reactive()` filter).

## Run it

In RStudio, open `app.R` and click **Run App**, or from R:

```r
install.packages(c("shiny", "ggplot2"))   # first time only
shiny::runApp("SHINY_APP")
```

Reference: https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/
