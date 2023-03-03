library(ggplot2)
library(scales)

ggplot(data = top_series) +
  geom_bar(
    stat = "identity",
    mapping = aes(
    x = reorder(series, +total_checkouts),
    y = total_checkouts,
    fill = reorder(series, +total_checkouts)
  )) +
  coord_flip() +
  labs(
    title = "Viz Media: Top 10 Series of All Time at SPL (2005-2023)",
    x = "Series",
    y = "Total Checkouts (in Thousands)",
    fill = "Series"
  ) +
  scale_y_continuous(labels = unit_format(unit = "T", scale = 1e-3)) +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data = top_10_series_2022) +
  geom_bar(
    stat = "identity",
    mapping = aes(
    x = reorder(series, +total_checkouts),
    y = total_checkouts,
    fill = reorder(series, +total_checkouts)
  )) +
  coord_flip() +
  labs(
    title = "Viz Media: Top 10 Series in 2022 at SPL",
    x = "Series",
    y = "Total Checkouts (in Thousands)",
    fill = "Series"
  ) +
  scale_y_continuous(labels = unit_format(unit = "T", scale = 1e-3)) +
  theme(plot.title = element_text(hjust = 0.5))
