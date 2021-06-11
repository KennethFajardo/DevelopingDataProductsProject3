library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Interactive COVID Timeline"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            div("Move the slider to set the date in which you want to observe the number of total
                COVID cases and deaths per country."),
            br(),
            sliderInput("slide",
                        "Date:",
                        min = as.Date("2020-01-22"),
                        max = as.Date("2021-06-09"),
                        value=as.Date("2021-06-09"),
                        timeFormat="%Y-%m-%d")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            leafletOutput("map")
        )
    )
))
