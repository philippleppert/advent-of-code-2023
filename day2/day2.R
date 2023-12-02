library(tidyverse)
library(stringi)

# data
data_d2 <- readLines("day2/day2.txt")

# part 1 ----

red_cubes_limit <- 12 
green_cubes_limit <- 13 
blue_cubes_limit <- 14 

# clean games
games <- 
  data_d2 %>% 
  str_remove("(Game [0-9]: |Game [0-9][0-9]: |Game [0-9][0-9][0-9]: )") %>% 
  str_split("; ") %>%
  map(.,~str_split(.x,", ")) %>%
  map(.,~map(., ~str_split(.x, " ")))

# will use tidyr for working with list
games_df <- 
  tibble(games) %>%
  mutate(game_id = row_number())
 
# unnest
games_df_mod <- 
  games_df %>%
  unnest(cols = c(games)) %>%
  unnest(cols = c(games)) %>%
  unnest_wider(games, names_repair = ~c("count", "color","game_id")) %>%
  suppressMessages() %>%
  mutate(count = as.numeric(count))

# find games that exceed cube limits 
games_df_check <- 
  games_df_mod %>% 
  filter(
    (color == "red" & count > red_cubes_limit) | 
    (color == "green" & count > green_cubes_limit)  | 
    (color == "blue" & count > blue_cubes_limit)
    )

# match ids against all games and sum
setdiff(games_df_mod$game_id, games_df_check$game_id) %>% sum

