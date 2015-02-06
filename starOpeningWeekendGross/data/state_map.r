#rm(list=ls())
library(maps)
library(ggplot2)

#setwd("D:/Dropbox/III/movie/starOpeningWeekendGross")
boxLevel <- readRDS("data/boxLevel.rds")
boxLevel <- boxLevel[order(boxLevel$title),] # order by title
head(boxLevel)

state.key <- readRDS("./data/state.key.rds")
head(state.key)

filmingLocations <- readRDS("./data/filmingLocations.rds")
head(filmingLocations)
dim(filmingLocations) #7457 14

filmingUSA <- subset(filmingLocations, filmingLocations$country == "USA")
dim(filmingUSA) #3906 14

filmingUSA <- data.frame(states = tolower(filmingUSA$state), filmingUSA)
dim(filmingUSA) #3906 15

filmingUSA <- subset(filmingUSA, filmingUSA$states != 99999)
head(filmingUSA)
dim(filmingUSA) #3838 15

#table(filmingUSA$states)
#table(crimes$state)

### Argo fuck yourself, USA Map Test
movieTitle <- paste("Argo")
setTitle <- subset(filmingUSA, filmingUSA$title == movieTitle)
nrow(setTitle)
#moviePkno <- paste("tt1024648")
#setTitle <- subset(filmingUSA, filmingUSA$pkno == moviePkno)

#moviePkno <- paste("tt0472043")
#setTitle <- subset(filmingLocations, filmingLocations$pkno == moviePkno)

### united state maps data
states_map <- map_data("state")

ggplot(setTitle, aes(map_id = states)) +
  geom_map(aes(fill = fraction), map = states_map) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  scale_fill_continuous(low="white", high="#FED200", limits=c(min(setTitle$fraction), max(setTitle$fraction))) + 
  #scale_colour_gradient(low = "white", high = "red", limits=c(min(setTitle$denominator), max(setTitle$denominator))) + 
  coord_map(projection = "polyconic", xlim=c(-120,-71)) +
  labs(title="Filming Location Map of America")


### Minimal Choropleth Example
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)

states_map <- map_data("state")

ggplot(crimes, aes(map_id = state)) +
  geom_map(aes(fill = Murder, colour = 1), map = states_map) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  scale_fill_continuous(low="white", high="#FED200", limits=c(0,20)) + 
  scale_colour_gradient(low = "black", high = "black") + 
  theme(legend.position="none") +
  coord_map(projection = "polyconic", xlim=c(-120,-71)) +
  labs(title="Filming Location Map of America")

#ggsave("./data/map2.png", width=12.5, height=8.25, dpi=72) 


