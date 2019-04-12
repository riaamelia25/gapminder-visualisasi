library(openxlsx)
library(gganimate)
library(plotly)
library(ggplot2)
#input data 

gapminder <- read.xlsx("F://MATERI KULIAH UII//SEMESTER 6//Data Visualisasi//gapminder.xlsx", sheet = 1, startRow = 1, colNames = TRUE)
head(gapminder)

#mengambil varibel
#membuat vektor
country.vec <- gapminder [,1]

# membuat pengulangan variabel panel (replikasi)
#perulangan
country_panel <- c()
for (i in 1:170) {
  x = rep(country.vec[i], 47)
  country_panel <- append(country_panel, x)
}
head(country_panel)

#mengambil data pada variabel tahun
years_panel <- rep(1970:2016, 170)

#mengambil data pada variabel gdp
gdp_panel <- c()
for (i in 1:170) {
 x = gapminder[i,]
 x =  x[-c(1:3)]
 x = t(x)
gdp_panel <- append(gdp_panel, x)
}

#mengambil data untuk sheet populasi
gapminder1 <- read.xlsx("F://MATERI KULIAH UII//SEMESTER 6//Data Visualisasi//gapminder.xlsx", sheet = 2, startRow = 1, colNames = TRUE)

pop_panel <- c()
for (i in 1:170) {
  x = gapminder1[i,]
  x =  x[-c(1:3)]
  x = t(x)
  pop_panel <- append(pop_panel, x)
}

#mengambil data untuk sheet 3
gapminder2 <- read.xlsx("F://MATERI KULIAH UII//SEMESTER 6//Data Visualisasi//gapminder.xlsx", sheet = 3, startRow = 1, colNames = TRUE)

life_panel <- c()
for (i in 1:170) {
  x = gapminder2[i,]
  x =  x[-c(1:3)]
  x = t(x)
  life_panel <- append(life_panel, x)
}

#mengambil varialbel region
gapminder3 <- read.xlsx("F://MATERI KULIAH UII//SEMESTER 6//Data Visualisasi//gapminder.xlsx", sheet = 4, startRow = 1, colNames = TRUE)

region.vec <- gapminder3 [,6]
region.vec

region_panel <- c()
for (i in 1:170) {
  x = rep(region.vec[i], 47)
  region_panel <- append(region_panel, x)
}
View(region_panel)

#membuat data frame 
gapminder_frame <- data.frame(region_panel,country_panel, years_panel, gdp_panel, pop_panel, life_panel)
View(gapminder_frame)

#membuat visual dengan plotly
gap1 <- ggplot(gapminder_frame, aes(x = log(gdp_panel), y = life_panel)) + geom_point()
gap1
gap2 <- ggplot(gapminder_frame, aes(x = log(gdp_panel), y = life_panel)) + geom_point(aes(frame = years_panel))
ggplotly(gap2)
gap3 <- ggplot(gapminder_frame, aes(x = log(gdp_panel), y = life_panel, color = country_panel)) + geom_point(aes(frame = years_panel))
ggplotly(gap3)
gap4 <- ggplot(gapminder_frame, aes(x = log(gdp_panel), y = life_panel, color = country_panel)) + geom_point(aes(shape = region_panel,size = pop_panel,frame = years_panel))
ggplotly(gap4)

#Menyimpan Data Frame Kedalam Perangkat Laptop
colnames(gapminder)<-c("Region","Country","Years","GDP","Population","Life")
setwd("F:\\MATERI KULIAH UII\\SEMESTER 6\\Data Visualisasi")
write.csv(gapminder_frame, file="Visualisasi.Gapminder.csv", row.names = TRUE)
gapminder.simpan<-data.frame(gapminder_frame)
gapminder.simpan