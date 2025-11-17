# Facilitate a White Elephant Gift Exchange

Creates a Quarto reveal.js presentation showing:

- Title slide (occasion + date)

- Rules slide

- One slide per participant in randomized order Each slide includes a
  bottom-right link back to the rules slide.

## Usage

``` r
white_elephant(names, occasion = "White Elephant Gift Exchange")
```

## Arguments

- names:

  Character vector of participant names.

- occasion:

  Optional title for the event.

## Value

Invisibly returns the randomized order of participants.
