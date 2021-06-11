
# Load libraries
library(shiny)
library(leaflet)
library(dplyr) 
library(RColorBrewer)
library(maps)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    # Load data
    covid <- read.csv("./covid.csv", stringsAsFactors = F) # c. 2021-06-09
    covid <- covid[,grep("total|location|date", names(covid))]
    data(world.cities) # geocoordinates
    
    # Merge covid data and geocoordinates
    world.cities <- world.cities %>% filter(capital==1) %>% 
        select(country=country.etc,lat,long)
    
    # Homogenize names
    world.cities$country <- gsub("USA", "United States", world.cities$country)
    world.cities$country <- gsub("UK", "United Kingdom", world.cities$country)
    
    # Remove NA dates
    covid <- covid[!is.na(covid$date),]
    
    # Assign inputs and filter data based on selected date
    data <- reactive({
        slideDate <- as.Date(input$slide)
        data <- covid %>% 
            select(country=location, date, total_cases, total_deaths) %>%
            left_join(world.cities, ., by="country") %>% 
            arrange(date, country) %>%
            filter(date == slideDate, !is.na(date))  
    })
    
    # Render leaflet
    output$map <- renderLeaflet({
        # Set palette for map
        pal <- colorNumeric(
            palette = colorRamp(c("#FF5555", "#FF2222"), interpolate="linear"),
            domain = data()$total_deaths)
        
        # Set labels
        labels <- sprintf(
            "<strong>%s</strong> <br/>%s Total Cases <br/>%s Total Deaths <sup></sup>",
            data()$country, format(data()$total_cases, 
                        scientific = FALSE, big.mark = ","), 
                format(data()$total_deaths, scientific = FALSE, 
                        big.mark = ",")) %>%
                lapply(htmltools::HTML)
        
        # Generate map
        data() %>% leaflet() %>% addTiles() %>% 
            addCircleMarkers(
                lat = ~ lat, 
                lng = ~ long,
                radius = ~log10(total_cases)*2,
                label = labels,
                fillColor = ~pal(sqrt(total_deaths)),
                weight = 0
            ) %>%
            fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
    })
})
