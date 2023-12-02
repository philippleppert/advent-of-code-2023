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

## patterns to look for
pattern <- "[0-9]|(on(?=e))|(tw(?=o))|(thre(?=e))|(four)|(fiv(?=e))|(six)|(seve(?=n))|(eigh(?=t))|(nin(?=e))"

## dict
digits_as_string <- set_names(
  {1:9 %>% as.character}, 
  c("on", "tw", "thre", "four",
    "fiv", "six", "seve", "eigh", "nin")
  )

## modify
data_d1_mod <- 
  data_d1 %>% 
  str_extract_all(pattern) %>% 
  map(., ~str_replace_all(.x, digits_as_string)) %>%
  map_chr(., ~str_c(.x, collapse = ""))

# digits
first_digit <- stri_extract_first_regex(data_d1_mod, "\\d{1}")
last_digit <- stri_extract_last_regex(data_d1_mod, "\\d{1}")

# combine and sum
str_c(first_digit, last_digit) %>% as.numeric %>% sum
