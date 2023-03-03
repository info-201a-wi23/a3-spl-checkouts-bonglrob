library(dplyr)
source("analysis.R")

# Summary stats

summary_info <- list()

summary_info$most_checkouts <- checkouts %>%
  group_by(date) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>%
  pull(checkouts)

summary_info$date_most_checkouts <- checkouts %>%
  group_by(date) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>%
  pull(date)

summary_info$least_checkouts <- checkouts %>%
  group_by(date) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == min(checkouts, na.rm = TRUE)) %>%
  pull(checkouts)

summary_info$date_least_checkouts <- checkouts %>%
  group_by(date) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == min(checkouts, na.rm = TRUE)) %>%
  pull(date)

summary_info$most_popular_title <- checkouts %>%
  group_by(Title) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>%
  pull(Title)

summary_info$most_popular_disc <- checkouts %>%
  filter(MaterialType == "VIDEODISC") %>%
  group_by(shorten_title) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>%
  pull(shorten_title)

summary_info$most_popular_creator <- checkouts %>%
  filter(!Creator == "") %>%
  group_by(Creator) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  filter(checkouts == max(checkouts, na.rm = TRUE)) %>%
  pull(Creator)
