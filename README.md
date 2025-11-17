# giftR

> A White Elephant Gift Exchange Facilitator

The `white_elephant()` function generates a **reveal.js presentation** to run a White Elephant gift exchange. It’s perfect for holiday parties, office events, or any gathering where you want to randomly reveal participants’ turns in a fun, interactive way.

---

## Features

- Automatically creates a **title slide** and **rules slide**.
- Randomizes the **order of participants**.
- Generates **one slide per participant** with a “It’s your turn!” prompt.
- Includes a **footer link to the rules** on every slide.
- Renders a **reveal.js presentation** viewable in your RStudio Viewer or web browser.

---

## Installation

Make sure you have the required packages:

```r
install.packages(c("quarto", "glue"))
````

---

## Example Usage

```r
library(YourPackageName)  # replace with your package name

names <- c("John", "Aidan", "Clara", "Jimmy", "Theo",
           "Meredith", "Caleb", "Samantha", "Sharon")

# Generate the White Elephant reveal.js presentation
white_elephant(names)
```

Running this function will open a **fully interactive slide deck** in your viewer or default browser. Participants can follow the slides to take turns opening or stealing gifts, and the rules are always accessible via the footer link. The presentation should have a rules slide that looks like this:

![Rules Slide](man/figures/example1.png)
![Example Slide](man/figures/example2.png)
