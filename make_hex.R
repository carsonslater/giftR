# Install packages if needed
# install.packages("hexSticker")

library("hexSticker")
library("magick")

img <- image_read("gift.png")
img <- image_transparent(img, "white")  # Remove white background
image_write(img, "gift_transparent.png")

sticker(
  "gift.png",
  package = "giftR",
  p_size = 22,
  p_y = 1.4,
  p_color = "#2D2D2D",
  p_family = "sans",
  p_fontface = "bold",
  s_x = 1,
  s_y = 0.75,
  s_width = 0.5,
  s_height = 0.5,
  h_fill = "#FDF5E6",
  h_color = "#2D2D2D",
  h_size = 1.5,
  filename = "giftR_hex.png",
  dpi = 300
)
