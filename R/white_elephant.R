#' White Elephant Gift Exchange Presentation
#'
#' Generates a reveal.js presentation with:
#' - Title slide
#' - Rules slide
#' - One slide per participant in randomized order
#' - A footer link to the Rules slide on every slide
#'
#' @param names Character vector of participant names.
#' @return Renders a reveal.js presentation in the Viewer pane.
#' @export
white_elephant <- function(names) {
  if (!requireNamespace("quarto", quietly = TRUE)) {
    stop("The 'quarto' package is required. Install with install.packages('quarto').")
  }
  if (!requireNamespace("glue", quietly = TRUE)) {
    stop("The 'glue' package is required. Install with install.packages('glue').")
  }

  order <- sample(names)
  tmpdir <- tempdir()
  qmd_file <- file.path(tmpdir, "white-elephant.qmd")

  qmd_content <- glue::glue(
'---
title: "White Elephant Gift Exchange"
format:
  revealjs:
    theme: manhattan
    slide-number: true
    navigation-mode: linear
    preload: true
    include-in-header:
      text: |
        <style>
        .footer-link {{
          position: absolute;
          bottom: 20px;
          right: 20px;
          font-size: 0.8rem;
          opacity: 0.8;
        }}
        .footer-link a {{
          color: #888;
          text-decoration: none;
        }}
        .footer-link a:hover {{
          color: #000;
        }}
        </style>
---

# White Elephant Gift Exchange

**A Fun Randomized Gift Game**

---

## 📝 Rules {{#rules}}

1. Person 1 selects and opens a gift.
2. Each subsequent person may open a new gift or steal an opened one.
3. Gifts may only be stolen a limited number of times.
4. Continue until all gifts are opened.

{paste0(lapply(seq_along(order), function(i) {{
  name <- order[i]
  glue::glue("
---
## Person {i}

**{name}** goes now!

<div class=\'footer-link\'><a href=\'#/rules\'>Rules</a></div>
")
}}), collapse = "\\n") }
'
  )

  writeLines(qmd_content, qmd_file)

  # Render
  quarto::quarto_render(qmd_file, quiet = FALSE)

  # Open in Viewer or browser
  viewer_file <- file.path(tmpdir, "white-elephant.html")
  viewer <- getOption("viewer")
  if (!is.null(viewer)) {
    viewer(viewer_file)
  } else {
    utils::browseURL(viewer_file)
  }

  invisible(viewer_file)
}
