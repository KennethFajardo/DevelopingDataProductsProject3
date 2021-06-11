Interactive COVID Timeline
========================================================
author: Kenneth Fajardo
date: 2021-06-09
autosize: true
css: custom.css

Overview
========================================================
<span class="overview">This project demos a simple web app created in R. The app features a timeline of the COVID transmission and deaths for all countries as of *2021-06-09*. The data is download from </span>*Our World in Data's* [repository]("https://covid.ourworldindata.org/data/owid-covid-data.csv").
<img class="owid" src="owid.png">

COVID Data Summary
========================================================


```r
covid <- read.csv("./covid/covid.csv")
covid <- covid[,c("location", "date", "total_cases", "total_deaths")]
str(covid)
```

```
'data.frame':	94642 obs. of  4 variables:
 $ location    : Factor w/ 229 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ date        : Factor w/ 526 levels "2020-01-01","2020-01-02",..: 55 56 57 58 59 60 61 62 63 64 ...
 $ total_cases : num  1 1 1 1 1 1 1 1 2 4 ...
 $ total_deaths: num  NA NA NA NA NA NA NA NA NA NA ...
```

Geodata Summary
========================================================


```r
library(maps)
data(world.cities)
str(world.cities)
```

```
'data.frame':	43645 obs. of  6 variables:
 $ name       : chr  "'Abasan al-Jadidah" "'Abasan al-Kabirah" "'Abdul Hakim" "'Abdullah-as-Salam" ...
 $ country.etc: chr  "Palestine" "Palestine" "Pakistan" "Kuwait" ...
 $ pop        : int  5629 18999 47788 21817 2456 3434 9198 5492 22706 41731 ...
 $ lat        : num  31.3 31.3 30.6 29.4 32 ...
 $ long       : num  34.3 34.4 72.1 48 35.1 ...
 $ capital    : int  0 0 0 0 0 0 0 0 0 0 ...
```

Shiny Web App
========================================================
The app has only two parts - a slider input and a leaflet widget. The slider is used to select the date of the data collection for total cases and total deaths. The app can be accessed [here]("https://kennethfajardo.shinyapps.io/covid/").
<img class="app" src="./app.png">

