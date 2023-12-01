library(tidyverse)
library(stringi)

# data
data_d1 <- readLines("day1/day1.txt")

# digits
first_digit <- stri_extract_first_regex(data_d1, "\\d{1}")
last_digit <- stri_extract_last_regex(data_d1, "\\d{1}")

# combine and sum
str_c(first_digit, last_digit) %>% as.numeric %>% sum
