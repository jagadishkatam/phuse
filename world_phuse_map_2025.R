
library(ggmap)
library(maps)
library(plotly)
library(tidyverse)
library(leaflet)
library(htmlwidgets)
library(googlesheets4)

gs4_deauth()
locations <- read_sheet("https://docs.google.com/spreadsheets/d/1y71M3LsU5HjdUetBFO1Rhy9Ws3rVfPHgA0AMmNb2KmQ/edit?usp=sharing")


popupContent <- ~paste0(
  "<div style='font-family: Arial; font-size: 12px;'>",
  "<strong style='color: darkblue;'>City:</strong> ", city, "<br>",
  "<strong style='color: darkblue;'>Date:</strong> ", date, "<br>",
  "<strong style='color: darkblue;'>Description:</strong> ", description,"<br>",
  "<strong style='color: darkblue;'>Conference:</strong> ", conference,
  "</div>"
) 

mymap <- leaflet(locations) |> 
  addTiles(options = tileOptions(noWrap = TRUE)) |> 
  # fitBounds(lng1 = -180, lat1 = -90, lng2 = 180, lat2 = 90) |> 
  addProviderTiles(providers$Esri.WorldStreetMap, options = tileOptions(noWrap = TRUE)) |>
  setView(lng = 0, lat = 20, zoom = 2) |> 
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

# save the map in html format 
saveWidget(mymap, "phuse_map_2025.html")



