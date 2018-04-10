library(rvest)
library(magrittr)
library(lubridate)


# basic url - Hungarian breweries
url <- "https://www.ratebeer.com/breweries/hungary/0/94/"

# only the active breweries
tmp <- read_html(url)

# get tables
tmp_table <- tmp %>% html_table(., fill = TRUE)

# data preprocessing with piping
tmp_table <- tmp_table %>%
  lapply(., function(x) dim(x)[1]) %>%
  unlist(.) %>%
  which.max(.) %>%
  tmp_table[[.]]

# delete My Count column - there is no data
tmp_table <- tmp_table[, -4]


# Pécs Szalon beer url
pecs_beer <- read_html("https://www.ratebeer.com/brewers/pecsi-sorfozde-ottakringer/2242/")
# get table
pecs_beer_tbl <- pecs_beer %>% html_table(., fill = TRUE)
# select the right table from the list
pecs_beer_tbl <- pecs_beer_tbl[[1]]
# change data class
pecs_beer_tbl$ABV <- as.numeric(pecs_beer_tbl$ABV)
pecs_beer_tbl$Added <- lubridate::mdy(pecs_beer_tbl$Added)
# add nice colnames to the data.frame
colnames(pecs_beer_tbl) <- c("Name", # name of the beer
                             "ABV", # alchol by volume
                             "Added", # date appearence
                             "rated", # if you want to rate the given beer
                             "Score", # weighted score, 5 is the best
                             "Style", # beer style percentile
                             "user_rated", # number of user reviews
                             "val2") # empty column
# delete the last column
pecs_beer_tbl <- pecs_beer_tbl[, -8]
plot(pecs_beer_tbl$ABV, pecs_beer_tbl$Score,
     main = "Alcohol by Volume - Score",
     xlab = "Alcohol by Volume",
     ylab = "Score, 5 is the best")
