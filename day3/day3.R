library(tidyverse)

# data
data_d3 <- readLines("day3/day3.txt")

# part 1 ----

# symbols example
str_locate_all(data_d3[8], "\\*|&|#|%|\\+|\\$|\\-|\\/|=")

# all symbols 
symbols <- 
  data_d3 %>%
  map(., ~str_locate_all(.x, "\\*|&|#|%|\\+|\\$|\\-|\\/|=")) 

symbols_mod <- 
  map(
    symbols, 
    ~unlist(.x) %>% tibble(sym_location= .) %>% distinct
    )

symbols_mod2 <- 
  tibble(symbols_mod) %>%
  hoist(., "symbols_mod", "sym_location") %>%
  mutate(row = row_number()) 

# numbers
str_locate_all(data_d3[1], "[0-9]")

# all numbers 
numbers <- 
  data_d3 %>%
  map(., ~str_locate_all(.x, "[0-9]"))

numbers_mod <- 
  map(
    numbers, 
    ~unlist(.x) %>% tibble(num_location= .) %>% distinct
  )

numbers_mod2 <- 
  tibble(numbers_mod) %>%
  hoist(., "numbers_mod", "num_location") %>%
  mutate(row = row_number()) 

# join
final <- inner_join(
  numbers_mod2, symbols_mod2, by = "row"
)

# don't know how to proceed yet
