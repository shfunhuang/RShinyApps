### Programming by Shfun Huang 2014.12.15
### Download: ODBC Driver 11 for SQL Server
rm(list=ls())
library("RODBC")

#################################################
### Loading Data from SQL Server: IMDB
#imdb <- odbcConnect("imdb", uid="SHFUNHUANG-PC")
#imdb <- odbcConnect("imdb", uid="BIGDATA-PC")
imdb_complete <- odbcConnect("imdb_complete", uid="BIGDATA-PC")

boxLevel <- sqlQuery(imdb_complete, 
'SELECT b.pkno, b.title, bd.budget, b.currency4wg, b.weekendgross, b.date, t.TotalGross, b.screens, bl.boxLevel
FROM boxoffice b, budget bd, boxLevelSix bl, 
  									                    (SELECT b.pkno, sum(weekendgross) "TotalGross"
										                     FROM boxoffice b
							                           GROUP by b.pkno, b.title
				                                 HAVING sum(weekendgross) >= 300000) t
WHERE b.pkno = t.pkno 
AND b.pkno = bd.pkno
AND b.pkno = bl.pkno
AND weekend = 1
AND CONVERT(char(4),b.date) >= 2004
ORDER by CONVERT(char(4),b.date)')

filmingLocations <- sqlQuery(imdb_complete, 
'SELECT b.pkno, b.title, bd.budget, b.currency4wg, b.weekendgross, b.date, t.TotalGross, b.screens, bl.boxLevel, l.state, l.country , l.numerator, l.denominator, l.fraction
FROM boxoffice b, budget bd, locations l, boxLevelSix bl,
  									(SELECT b.pkno, sum(weekendgross) "TotalGross"
										FROM boxoffice b
										GROUP by b.pkno, b.title
										HAVING sum(weekendgross) >= 300000) t
WHERE b.pkno = t.pkno 
AND b.pkno = bd.pkno
AND b.pkno = bl.pkno
AND b.pkno = l.pkno
AND weekend = 1
AND CONVERT(char(4),b.date) >= 2004')

#imgList <- sqlQuery(imdb_complete,
#                    'SELECT *
#                     FROM movie_list')

close(imdb_complete)

#saveRDS(boxLevel, "boxLevel.rds", ascii = TRUE)
#saveRDS(filmingLocations, "filmingLocations.rds", ascii = TRUE)
#saveRDS(imgList, "imgLink.rds", ascii = TRUE)
#write.table(boxLevel, "boxLevel.txt", row.names=F)
