library(tidyverse)

# data
data_d4 <- readLines("day4/day4.txt")

# part 1 ----
nums <- str_split(data_d4, ": ", simplify = T)[,2] %>% trimws()

## winning numbers
nums_win <- str_remove(string = nums, pattern = " \\| (.*)")
nums_win <- nums_win[nzchar(nums_win)]

## test numbers
nums_test <- str_extract(string = nums, pattern = "\\| (.*)") %>%
  str_remove("\\| ")

# make df
df <- bind_cols(
  nums_win %>% tibble("nums_win" = .),
  nums_test %>% tibble("nums_test" = .)
  )

test <-
  df %>%
  mutate(
    # transform strings to vectors to compare later on
    nums_win = map(
      nums_win, 
      ~str_split(.x, " ", simplify = T) %>% 
        as.vector %>%
        discard(~!nzchar(.x))),
    nums_test = map(
      nums_test, 
      ~str_split(.x, " ", simplify = T) %>% 
        as.vector %>%
        discard(~!nzchar(.x))),
    # nums_win found in nums_test?
    test = map2(nums_win, nums_test, ~.x %in% .y ),
    # count matches
    sum_matches = map_int(test, ~sum(.x == T)),
    # set score for each card
    points = case_when(
      sum_matches > 1 ~ 2^(sum_matches-1), 
      sum_matches == 1 ~ 1,
      sum_matches == 0 ~ 0)
    )

# sum
test %>%
  summarise( sum_points = sum(points))


