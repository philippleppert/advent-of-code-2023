library(tidyverse)
library(stringi)
data_d1 <- readLines("day1.txt") %>% tibble(elves = .)


first <- stri_extract_first_regex(data_d1$elves, "\\d{1}")
last <- stri_extract_last_regex(data_d1$elves, "\\d{1}")

str_c(first, last) %>% as.numeric() %>% sum
