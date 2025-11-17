#' Facilitate a White Elephant Gift Exchange
#'
#' This function takes a vector of participant names and prints instructions
#' to the RStudio/Positron preview panel for running a white elephant gift exchange.
#'
#' @param names A character vector of participant names.
#'
#' @return Invisibly returns the participant order.
#'
#' @examples
#' white_elephant(c("Alice", "Bob", "Charlie"))
#'
#' @export
white_elephant <- function(names) {
  if (!is.character(names) || length(names) < 2) {
    stop("`names` must be a character vector of length >= 2.")
  }

  order <- sample(names)
  instructions <- paste0(
    "# White Elephant Gift Exchange\n\n",
    "Participant order:\n",
    paste0(seq_along(order), ". ", order, collapse = "\n"), "\n\n",
    "Rules:\n",
    "1. Person 1 selects and opens a gift.\n",
    "2. Each subsequent person may choose to open a new gift or steal an opened one.\n",
    "3. Gifts may only be stolen a limited number of times (set your own house rule).\n",
    "4. Continue until all gifts are opened.\n"
  )

  html_file <- tempfile(fileext = ".html")
  writeLines(
    paste0("<pre style='font-size:16px;'>", instructions, "</pre>"),
    con = html_file
  )

  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    rstudioapi::viewer(html_file)
  } else {
    message("Preview:\n", instructions)
  }

  invisible(order)
}
