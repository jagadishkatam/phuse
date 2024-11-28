# install.packages('maps')
library(ggmap)
library(maps)
library(plotly)
library(tidyverse)
library(leaflet)
library(htmlwidgets)

locations <- data.frame(
  city = c('Pune, India',
           'Twickenham, United Kingdom',
           'Orlando, United States of America',
           'Frankfurt, Germany',
           'Utrecht, Netherlands',
           'Yerevan, Armenia',
           'Hyderabad, India',
           'Chennai, India',
           'Hamburg, Germany',
           'Hyderabad, India',
           'Tokyo, Japan',
           'San Diego, United States of America',
           'Bengaluru, India',
           'Boston, United States of America'),
  
  description = c("Single Day Event",
                  "Single Day Event",
                  "US Connect",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "Single Day Event",
                  "EU Connect",
                  "Single Day Event at Novartis",
                  "Single Day Event",
                  "US Conference",
                  "Single Day Event",
                  "Single Day Event"),
  
  longitude = c(73.6901,
               -0.331237,
               -81.7575,
               8.2466,
               4.8875,
               44.2969,
               78.381384,
               79.8802,
               9.997585,
               78.379903,
               139.67829,
               -117.8874,
               77.2002,
               -71.1928),
  
  latitude = c(18.6479,
                51.448003,
                28.7081,
               50.2867,
               52.1636,
               40.2525,
               17.433113,
               13.3355,
               53.570917,
               17.436074,
               35.72087,
               33.2582,
               13.2293,
               42.4080),
  
  date = c("22 Mar 2025",
           "06 Mar 2025",
           "16-19 Mar 2025",
           "13 Mar 2025",
           "17 Apr 2025",
           "02 May 2025",
           "21 Jun 2025",
           "20 Sep 2025",
           "16-19 Nov 2025",
           "12 Apr 2025",
           "07 Apr 2025",
           "1-4 Jun 2025",
           "22 Nov 2025",
           NA),
  
  conference = c("Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "Phuse",
                  "PharmaSUG",
                 "PharmaSUG",
                 "PharmaSUG",
                 "Phuse",
                 "PharmaSUG")
  ) 

popupContent <- ~paste0(
  "<div style='font-family: Arial; font-size: 12px;'>",
  "<strong style='color: darkblue;'>City:</strong> ", city, "<br>",
  "<strong style='color: darkblue;'>Date:</strong> ", date, "<br>",
  "<strong style='color: darkblue;'>Description:</strong> ", description,"<br>",
  "<strong style='color: darkblue;'>Conference:</strong> ", conference,
  "</div>"
)

mymap <- leaflet(locations) |> 
  addProviderTiles(providers$Esri.WorldStreetMap) |> 
  addCircleMarkers(
    ~longitude, ~latitude,
    popup = popupContent,
    label = ~city,
    radius = 5,
    color = ~ifelse(str_detect(conference,'Pharma'),'blue','red')
  ) |> 
  addControl(
    "<h4 style='text-align: center;'>
      <span style='color: black;'>Map of </span>
      <span style='color: red;'>PHUSE</span>
      <span style='color: black;'> and </span>
      <span style='color: blue;'>PharmaSUG</span>
      <span style='color: black;'> Conferences in the Calender Year of 2025</span>
    </h4>",
    position = "topright"
  )


saveWidget(mymap, "phuse_map_2025.html")


