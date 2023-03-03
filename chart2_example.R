library(ggplot2)


ggplot(data = top_series_2022_checkouts) +
  geom_point(mapping = aes(
    x = date,
    y = total_checkouts,
    color = series
  )) +
  geom_line(mapping = aes(
    x = date,
    y = total_checkouts,
    color = series
  )) + labs(
    title = "Top 3 Viz Media Series in 2022 at SPL (Excluding Pokémon)",
    x = "Month",
    y = "Total Checkouts",
    color = "Series"
  ) +
  scale_x_date(date_breaks = "1 month", date_labels = "%B") +
  theme(plot.title = element_text(hjust = 0.5))
