library(dplyr)
library(stringr)

checkouts <- read.csv("C:/Users/robbo/UW/22win/info201/assignments/datasets/viz-media-SPL.csv", stringsAsFactors = FALSE)

# Add new date column
checkouts <- checkouts %>%
  mutate(date = paste(CheckoutYear, CheckoutMonth, "01", sep = "-"))

checkouts$date <- as.Date(checkouts$date, "%Y-%m-%d")

# Add shorten titles column
checkouts <- checkouts %>%
  mutate(shorten_title = str_extract(Title, "^[^/]+"))

# Add series column
checkouts <- checkouts %>%
  mutate(series = str_extract(shorten_title, "^[^.]+")) %>%
  mutate(series = str_remove(series, " \\[videorecording\\]")) %>%
  mutate(series = str_remove(series, "(?i)(?<=Pokémon|Pokemon|Naruto).*")) %>%
  mutate(series = str_replace(series, "Pokemon", "Pokémon"))

# Earliest eBook data entry
checkouts_earliest_ebook_date <- checkouts %>%
  filter(MaterialType == "EBOOK") %>%
  filter(date == min(date, na.rm = TRUE)) %>%
  pull(date)

# Checkouts per month for books, eBooks & video discs
checkouts_per_month <- checkouts %>%
  filter(MaterialType == "BOOK" | MaterialType == "VIDEODISC" | MaterialType == "EBOOK") %>%
  filter(date >= checkouts_earliest_ebook_date) %>%
  group_by(date, MaterialType) %>%
  select(date, MaterialType, Checkouts) %>%
  mutate(checkouts = sum(Checkouts, na.rm = TRUE))

# Popular series of all time
top_series <- checkouts %>%
  group_by(series) %>%
  summarize(total_checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  arrange(-total_checkouts) %>%
  head(10)

# Popular Series of 2022
top_series_2022 <- checkouts %>%
  filter(date >= "2022-01-01" & date <= "2022-12-01") %>%
  group_by(series) %>%
  summarize(total_checkouts = sum(Checkouts, na.rm = TRUE))

# Top 10 Series of 2022
top_10_series_2022 <- top_series_2022 %>%
  arrange(-total_checkouts) %>%
  head(10)

# Top 3 Series of 2022
top_series_2022_titles <- top_series_2022 %>%
  filter(!series == "Pokémon") %>%
  arrange(-total_checkouts) %>%
  head(3) %>%
  pull(series)

# Top 10 Series of 2022 Checkouts over Time
top_series_2022_checkouts <- checkouts %>%
  filter(date >= "2022-01-01" & date <= "2022-12-01") %>%
  filter(series %in% top_series_2022_titles) %>%
  group_by(date, series) %>%
  mutate(total_checkouts = sum(Checkouts, na.rm = TRUE)) %>%
  select(date, series, total_checkouts)