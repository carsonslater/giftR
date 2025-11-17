#' White Elephant Gift Exchange Presentation (Improved)
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

  # --- YAML header ---
  yaml <- "
---
title: \"White Elephant Gift Exchange\"
format:
  revealjs:
    theme: simple
    slide-number: true
    navigation-mode: linear
    preload: true
---
"

  cat(yaml, file = qmd_file)

  # --- CSS (directly in QMD) ---
  css <- c(
    "<style>",
    ".footer-link {",
    "  position: absolute;",
    "  bottom: 20px;",
    "  right: 20px;",
    "  font-size: 0.8rem;",
    "  opacity: 0.8;",
    "}",
    ".footer-link a {",
    "  color: #888;",
    "  text-decoration: none;",
    "}",
    ".footer-link a:hover {",
    "  color: #000;",
    "}",
    "</style>",
    ""
  )

  # --- Title and Rules slides ---
  slides <- c(
    "## A Fun Randomized Gift Game",
    "",
    "---",
    "\n\n## 📝 Rules {#rules}",
    "",
    "1. Person 1 selects and opens a gift.\n",
    "2. Each subsequent person may open a new gift or steal an opened one.\n",
    "3. Gifts may only be stolen a limited number of times.\n",
    "4. Continue until all gifts are opened.\n",
    ""
  )

  # writeLines(c(css, slides), qmd_file)
  cat(css, file = qmd_file, sep = "\n", append = TRUE)
  cat(slides, file = qmd_file, sep = "\n", append = TRUE)


  # --- Participant slides (improved layout) ---
  participant_slides <- sapply(seq_along(order), function(i) {
    name <- order[i]
    glue::glue(
      "---\n\n# {name}\n\n**It's your turn!**\n\n<div class='footer-link'><a href='#/rules'>Rules</a></div>\n"
    )
  })

  cat(participant_slides, file = qmd_file, sep = "\n", append = TRUE)


  # --- Render ---
  quarto::quarto_render(qmd_file, quiet = FALSE)

  viewer_file <- file.path(tmpdir, "white-elephant.html")
  viewer <- getOption("viewer")
  if (!is.null(viewer)) {
    viewer(viewer_file)
  } else {
    utils::browseURL(viewer_file)
  }

  invisible(viewer_file)
}
