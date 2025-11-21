# Secret Santa Gift Exchange

Assigns a secret santa to each participant and sends them an email with
their assignment.

## Usage

``` r
secret_santa(
  names,
  emails,
  sender_name = "Secret Santa Bot",
  sender_email,
  subject = "Your Secret Santa Assignment",
  smtp_password_env_var = "SMTP_PASSWORD",
  smtp_provider = "gmail",
  ...
)
```

## Arguments

- names:

  A character vector of participant names.

- emails:

  A character vector of participant email addresses. Must be the same
  length as `names`.

- sender_name:

  The name of the sender (e.g., "Secret Santa Organizer").

- sender_email:

  The email address to send from.

- subject:

  The subject line of the email.

- smtp_password_env_var:

  The name of the environment variable containing the SMTP password.
  Defaults to "SMTP_PASSWORD".

- smtp_provider:

  The SMTP provider. Defaults to "gmail".

- ...:

  Additional arguments passed to
  [`blastula::smtp_send()`](https://rstudio.github.io/blastula/reference/smtp_send.html).

## Value

Invisible NULL. Prints a message upon completion.
