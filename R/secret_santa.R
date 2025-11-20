#' Secret Santa Gift Exchange
#'
#' Assigns a secret santa to each participant and sends them an email with their assignment.
#'
#' @param names A character vector of participant names.
#' @param emails A character vector of participant email addresses. Must be the same length as `names`.
#' @param sender_name The name of the sender (e.g., "Secret Santa Organizer").
#' @param sender_email The email address to send from.
#' @param subject The subject line of the email.
#' @param smtp_password_env_var The name of the environment variable containing the SMTP password. Defaults to "SMTP_PASSWORD".
#' @param smtp_provider The SMTP provider. Defaults to "gmail".
#' @param ... Additional arguments passed to `blastula::smtp_send()`.
#'
#' @return Invisible NULL. Prints a message upon completion.
#' @export
#' @importFrom blastula compose_email smtp_send creds_envvar
#' @importFrom glue glue
secret_santa <- function(names, emails, sender_name = "Secret Santa Bot", sender_email, subject = "Your Secret Santa Assignment", smtp_password_env_var = "SMTP_PASSWORD", smtp_provider = "gmail", ...) {
  
  if (length(names) != length(emails)) {
    stop("The number of names and emails must be the same.")
  }
  
  if (length(names) < 2) {
    stop("You need at least 2 participants for a Secret Santa exchange.")
  }
  
  # Derangement: Shuffle until no one is assigned themselves
  receivers <- names
  while (any(names == receivers)) {
    receivers <- sample(names)
  }
  
  # Send emails
  for (i in seq_along(names)) {
    giver_name <- names[i]
    giver_email <- emails[i]
    receiver_name <- receivers[i]
    
    email_body <- blastula::compose_email(
      body = blastula::md(glue::glue(
        "Hello {giver_name},
        
        You are the Secret Santa for **{receiver_name}**!
        
        Shhh... keep it a secret!
        
        Happy Holidays!"
      ))
    )
    
    blastula::smtp_send(
      email = email_body,
      to = giver_email,
      from = sender_email,
      subject = subject,
      credentials = blastula::creds_envvar(
        user = sender_email,
        pass_envvar = smtp_password_env_var,
        provider = smtp_provider
      ),
      ...
    )
    
    message(glue::glue("Sent email to {giver_name} ({giver_email})"))
  }
  
  message("All Secret Santa assignments have been sent!")
  invisible(NULL)
}
