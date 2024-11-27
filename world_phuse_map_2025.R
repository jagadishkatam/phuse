# install.packages('maps')
library(ggmap)
library(maps)
library(plotly)
library(tidyverse)
library(leaflet)
library(htmlwidgets)

locations <- data.frame(
  city = c('Pune',
           'Twickenham',
           'Orlando',
           'Frankfurt',
           'Utrecht',
           'Yerevan',
           'Hyderabad',
           'Chennai',
           'Hamburg',
           'Hyderabad'),
  
  description = c("Single Day Event",
                  "Single Day Event",
                  "US Connect",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "EU Connect",
                  "Single Day Event at Novartis"),
  
  country = c('India',
              'United Kingdom',
              'United States of America',
              'Germany',
              "Netherlands",
              'Armenia',
              'India',
              'India',
              "Germany",
              "India"),
  
  longitude = c(73.6901,
               -0.331237,
               -81.7575,
               8.2466,
               4.8875,
               44.2969,
               78.381384,
               79.8802,
               9.997585,
               78.379903),
  
  latitude = c(18.6479,
                51.448003,
                28.7081,
               50.2867,
               52.1636,
               40.2525,
               17.433113,
               13.3355,
               53.570917,
               17.436074),
  
  date = c("22 Mar 2025",
           "06 Mar 2025",
           "16-19 Mar 2025",
           "13 Mar 2025",
           "17 Apr 2025",
           "02 May 2025",
           "21 Jun 2025",
           "20 Sep 2025",
           "16-19 Nov 2025",
           "12 Apr 2025"),
  
  conference = c("Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "PharmaSUG")
  ) 

popupContent <- ~paste0(
  "<div style='font-family: Arial; font-size: 12px;'>",
  "<strong style='color: darkblue;'>City:</strong> ", city, "<br>",
  "<strong style='color: darkgreen;'>Date:</strong> ", date, "<br>",
  "<em>Description:</em> ", description,
  "<em>Conference:</em> ", conference,
  "</div>"
)

mymap <- leaflet(locations) %>%
  addProviderTiles(providers$Esri.WorldStreetMap) %>%
  addCircleMarkers(
    ~longitude, ~latitude,
    popup = popupContent,
    label = ~city,
    radius = 5,
    color = ~ifelse(str_detect(conference,'Pharma'),'blue','red')
  )


saveWidget(mymap, "phuse_map_2025.html")


