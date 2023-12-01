library(tidyverse)
library(stringi)

# data
data_d1 <- readLines("day1/day1.txt")

# part 1 ----

# digits
first_digit <- stri_extract_first_regex(data_d1, "\\d{1}")
last_digit <- stri_extract_last_regex(data_d1, "\\d{1}")

# combine and sum
str_c(first_digit, last_digit) %>% as.numeric %>% sum

# part 2 ----
digits_as_string <- set_names(
  {1:9 %>% as.character}, 
  c("on", "tw", "thre", "four",
    "fiv", "six", "seve", "eigh", "nin")
  )

data_d1_mod <- data_d1  %>% str_replace_all(digits_as_string)

# digits
first_digit <- stri_extract_first_regex(data_d1_mod, "\\d{1}")
last_digit <- stri_extract_last_regex(data_d1_mod, "\\d{1}")

# combine and sum
str_c(first_digit, last_digit) %>% as.numeric %>% sum

# need to fix eightwo and similar cases
data_d1[748]
data_d1_mod[748]
data_d1_mod[748]