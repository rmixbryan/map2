tmp <- tempfile()
download.file("http://colby.edu/~mgimond/Spatial/Data/Income_schooling.zip", destfile = tmp)
unzip(tmp, exdir = ".")

download.file("http://colby.edu/~mgimond/Spatial/Data/TX.gpkg", destfile = "./TX.gpkg", mode="wb")

library(rgdal)
s1 <- readOGR(".", "Income_schooling")
summary(s1)
spplot(s1, z="Income")
spplot(s1, z="NoSchool")

library(classInt)
library(RColorBrewer)

# Generate breaks
brks <-  classIntervals(s1$Income, n = 4, style = "quantile")$brks
brks[length(brks)] <- brks[length(brks)] + 1

# Define color swatches
pal  <- brewer.pal(4, "Greens")

# Generate the map
spplot(s1, z="Income", at = brks, col.regions=pal)

library(tmap)
qtm(s1, fill="Income", fill.style="quantile", 
    fill.n=8 ,fill.palette="Greens")

library(tmap)
qtm(s1, fill="Income", fill.style="quantile", 
    fill.n=8 ,fill.palette="Greens")

qtm(s1, fill="Income", fill.style="fixed", 
    fill.breaks=c(0,23000 ,27000,100000 ), 
    fill.labels=c("under $23,000", "$23,000 to $27,000", "above $27,000"),
    fill.palette="Greens",
    legend.text.size = 0.5,
    layout.legend.position = c("right", "bottom"))

tm_shape(s1) + 
  tm_fill("Income", style="fixed", breaks=c(0,23000 ,27000,100000 ),
          labels=c("under $23,000", "$23,000 to $27,000", "above $27,000"),
          palette="Greens")  +
  tm_borders("grey") +
  tm_legend(outside = TRUE, text.size = .8) +
  tm_layout(frame = FALSE)
