library(ggplot2)
library(maps)
#load us map data
map.world <- map_data("world")
str(map.world)
#write.table(levels(factor(world$region)), "./data/region.txt", row.names=F, col.names=F)

#setwd("D:/Dropbox/III/movie/starOpeningWeekendGross")
filmingLocations <- readRDS("./data/filmingLocations.rds")
#write.table(levels(filmingLocations$country), "./data/country.txt", row.names=F, col.names=F)

nousa <- subset(filmingLocations, filmingLocations$country != "USA")

movieTitle <- paste("Star Wars: Episode III - Revenge of the Sith")
setTitle <- subset(filmingLocations, filmingLocations$title == movieTitle) 

map.world <- map_data("world") 
country <- subset(map.world, region %in% setTitle$country)
country2 <- subset(map.world, !(region %in% setTitle$country))
#country2 <- data.frame(region2 = subset(map.world, !(region %in% setTitle$country))$region, country)


#plot all states with ggplot
#country <- subset(map.world, region %in% c("Canada", "China"))
ggplot() + 
  geom_polygon(data=country, aes(x=long, y=lat, group=group, fill=region, colour=region)) + # fill areas
  #geom_polygon(data=country2, aes(x=long, y=lat, group=group, fill=NA, colour=NA)) + # colour areas
  borders("world", colour="gray50") +
  expand_limits(x=country$long, y=country$lat) +
  coord_equal()
  #coord_map(projection = "ortho", orientation=c(mean(country$long), mean(country$lat), 0))

# color full world map by map.world
p3 <- ggplot(map.world, aes(x = long, y = lat, group = group, fill = region))
p3 <- p3 + geom_polygon() # fill areas
p3 <- p3 + theme(legend.position="none") # remove legend with fill colours
p3 <- p3 + labs(title = "World, filled regions")
print(p3)


