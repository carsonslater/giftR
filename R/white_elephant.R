#' Facilitate a White Elephant Gift Exchange
#'
#' Creates a Quarto reveal.js presentation showing:
#' - Title slide (occasion + date)
#' - Rules slide
#' - One slide per participant in randomized order
#' Each slide includes a bottom-right link back to the rules slide.
#'
#' @param names Character vector of participant names.
#' @param occasion Optional title for the event.
#'
#' @return Invisibly returns the randomized order of participants.
#' @export
white_elephant <- function(names, occasion = "White Elephant Gift Exchange") {
  if (!is.character(names) || length(names) < 2) {
    stop("`names` must be a character vector of length >= 2.")
  }

  if (!requireNamespace("rstudioapi", quietly = TRUE)) {
    stop("This function requires rstudioapi to display the presentation.")
  }

  # Randomized order
  order <- sample(names)

  # Temp directory & files
  tmp_dir <- tempdir()
  qmd_path <- file.path(tmp_dir, "white_elephant.qmd")
  html_path <- file.path(tmp_dir, "white_elephant.html")

  # Build slide content
  slides <- c()

  ## Title slide ----
  slides <- c(
    slides,
    glue::glue(
      "---\n",
      'title: "{occasion}"\n',
      "format:\n",
      "  revealjs:\n",
      "    theme: [manhattan]\n",
      "    slide-number: true\n",
      "    controls: true\n",
      "---\n\n",
      "# {occasion}\n",
      "### {format(Sys.Date())}\n",
      "\n---\n"
    )
  )

  ## Rules slide ----
  slides <- c(
    slides,
    "## Rules {#rules}\n\n",
    "1. Person 1 selects and opens a gift.\n",
    "2. Each subsequent person may open a new gift or steal a previously opened one.\n",
    "3. Gifts may only be stolen a limited number of times (set your own house rule).\n",
    "4. Continue until all gifts are opened.\n",
    "\n---\n"
  )

  ## Participant slides ----
  for (i in seq_along(order)) {
    person <- order[i]
    slides <- c(
      slides,
      glue::glue(
        "## Person {i}\n\n",
        "### {person}\n\n",
        "<div style='position: absolute; bottom: 20px; right: 20px;'>",
        "<a href='#/rules'>Rules</a>",
        "</div>\n",
        "\n---\n"
      )
    )
  }

  # Write .qmd file
  writeLines(slides, qmd_path)

  # Render the QMD → HTML
  quarto::quarto_render(qmd_path, output_file = html_path)

  # Display in RStudio/Positron viewer
  rstudioapi::viewer(html_path)

  invisible(order)
}
