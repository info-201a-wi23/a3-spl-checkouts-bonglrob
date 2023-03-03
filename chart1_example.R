library(ggplot2)

ggplot(data = checkouts_per_month) +
  geom_point(mapping = aes(
    x = date,
    y = checkouts,
    color = MaterialType
  )) +
  geom_line(aes(
    x = date,
    y = checkouts,
    color = MaterialType
  )) +
  scale_x_date(limit=c(as.Date("2017-04-01"), as.Date("2023-02-01")), date_breaks = "1 year", date_labels = "%b %Y") +
  labs(
    title = "Viz Media Checkouts at SPL (Apr 2017 - Feb 2023)",
    x = "Date",
    y = "Number of Checkouts (per Month)",
    color = "Media Type"
  ) +
  theme(plot.title = element_text(hjust = 0.5))
