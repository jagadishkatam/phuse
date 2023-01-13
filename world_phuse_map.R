# install.packages('maps')
library(ggmap)
library(maps)
library(plotly)
library(tidyverse)

new <- map_data('world') %>% mutate(loc=case_when(region=='USA' ~ 'USA',
                                                  region=='UK' ~ 'England',
                                                  region=='India' ~ 'India',
                                                  region=='Switzerland' ~ 'Switzerland',
                                                  region=='Japan' ~ 'Japan',
                                                  region=='China' ~ 'China',
                                                  region=='Germany' ~ 'Germany',
                                                  region=='Netherlands' ~ 'Netherlands',
                                                  region=='Denmark' ~ 'Denmark',
                                                  TRUE ~ 'zothers'),
                                                                      )
head(new)

# 2022 --------------------------------------------------------------------


phuse <- data.frame(long=c(139.8, -78.8, 8.6, 121.9, 12.5, 5.08, 77.5, -71.0, -75.3, 7.5, 80, -5.9, -84.2), 
                    lat=c(35.6, 35.7, 49.3, 30.9, 55.6, 52.1, 13, 42.2, 40.2, 47.5, 14, 54.6, 33.7), 
                    color='red', size=1, group=NA,
                    loc=c('Tokyo, Japan','Cary, NC','Heidelberg, Germany','Shanghai, China','Copenhagen, Denmark', 'Utrecht, the Netherlands','Boston, MA','Spring House, PA','Basel, Switzerland', 'Bengaluru, India', 'Chennai, India', 'Belfast, UK', 'Atlanta, USA'),
                    date=c('9 December 2022','1 December 2022','1 December 2022','4 November 2022','13 October 2022','29 September 2022','17 September 2022','23 August 2022','21 July 2022','21 June 2022', '10 December 2022','13 - 16 November 2022','01 - 04 May 2022'),
                    event=c('SDE','SDE','SDE','SDE','SDE','SDE', 'SDE', 'SDE', 'SDE', 'SDE', 'SDE','EU Connect','US Connect')
)

new2 <- new %>% arrange(loc) %>% select(loc) %>% unique()
color <- data.frame(color=c('violet','sandybrown','royalblue4','mistyrose','orange','lawngreen',"lightpink", "slateblue3",'wheat', "white"))

new3 <- bind_cols(new2,color) 

gplot1 <- ggplot2::ggplot(new, aes(x=long, y=lat, group=group)) +
  geom_polygon(data=new,aes(fill=loc), color='gray') +
  geom_point(data=phuse,aes(x=long,y=lat, group=group, text=paste('Country:',loc, '\nDate:', date,'\nEvent:',event)), color='red', size=2) +
  scale_fill_manual(values=new3$color) +
  ggtitle('PHUSE Events around the Globe 2022') +
  theme_void() +
  theme(legend.position = 'none',
        plot.title = element_text(hjust = 0.5),
        axis.line = element_line(colour = 'white'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())  +
  # labs(x='Longitude', y='Latitude') +
  guides(x = "none", y = "none") +
  labs(x = NULL, y = NULL)
  
gplot1x <- ggplotly(gplot1, tooltip = "text")

htmlwidgets::saveWidget(gplot1,'phuse_map1.html', selfcontained = TRUE)


# 2023 --------------------------------------------------------------------
new <- map_data('world') %>% mutate(loc=case_when(region=='USA' ~ 'USA',
                                                  region=='UK' ~ 'UK',
                                                  region=='India' ~ 'India',
                                                  TRUE ~ 'zothers'),
)

phuse <- data.frame(long=c(-81.6, 78.1, 72.0, 77.5, -1.1, 79.7), 
                    lat=c(28.6, 17.5, 23.2, 13, 51.8, 13.3), 
                    color='red', size=1, group=NA,
                    loc=c('Orlando , USA','Hyderabad, India','Ahmedabad, India','Bangalore, India','London, UK', 'Chennai, India'),
                    date=c('05 - 08 March 2023','18 March 2023','17 June 2023','09 September 2023','05 - 08 November 2023','02 December 2023'),
                    event=c('US Connect 2023','SDE','SDE','SDE','EU Connect 2023','SDE')
)

new2 <- new %>% arrange(loc) %>% select(loc) %>% unique()
color <- data.frame(color=c('orange','royalblue4','wheat','white'))

new3 <- bind_cols(new2,color) 

gplot2 <- ggplot2::ggplot(new, aes(x=long, y=lat, group=group)) +
  geom_polygon(data=new,aes(fill=loc), color='gray') +
  geom_point(data=phuse,aes(x=long,y=lat, group=group, text=paste('Country:',loc, '\nDate:', date,'\nEvent:',event)), color='red', size=2) +
  scale_fill_manual(values=new3$color) +
  ggtitle('PHUSE Events around the Globe 2023') +
  theme_void() +
  theme(legend.position = 'none',
        plot.title = element_text(hjust = 0.5),
        axis.line = element_line(colour = 'white'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())  +
  # labs(x='Longitude', y='Latitude') +
  guides(x = "none", y = "none") +
  labs(x = NULL, y = NULL)

gplot2x <- ggplotly(gplot2, tooltip = "text")

htmlwidgets::saveWidget(gplot2,'phuse_map2.html', selfcontained = TRUE)

# colors()

fin <- manipulateWidget::combineWidgets(title = "Location of PHUSE Global Events 2022 & 2023",
                gplot1, gplot2,
                byrow = F
 )
 
htmlwidgets::saveWidget(fin,'phuse_map.html', selfcontained = TRUE)



