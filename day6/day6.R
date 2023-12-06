library(tidyverse)

# part 1 ----
# data 
times <- c(40, 82, 91, 66)
record_distances <- c(277, 1338, 1349, 1063)

# make list with vector of times
times_list <- map(times, ~0:.x)

# function to determine total distance 
total_dist <- function(x){
  (max(x)-x)*x
}

# map over times_list vectors and calcualte total distance
total_distance_list <- map(1:4, ~{times_list[[.x]] %>% total_dist()})

# map over total_distance_list and compare with record_distance for each element
compare_list <- map(1:4, ~which(total_distance_list[[.x]] > record_distances[.x]))

# obtain product
map(compare_list, ~length(.x)) %>% unlist %>% prod()

# part 2 ----
times_kerning <- 0:str_c(times, collapse = "") %>% as.numeric
record_distances_kerning <- str_c(record_distances, collapse = "") %>% as.numeric

# distance
kerning_dist <- total_dist(times_kerning)

# ways to beat the record in this one much longer race
which(kerning_dist > record_distances_kerning) %>% length
