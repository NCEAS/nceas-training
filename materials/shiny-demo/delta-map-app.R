library(shiny)
library(contentid)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(shinythemes)
library(sf)
library(leaflet)
library(snakecase)

# read in the data from EDI
sha1 <- 'hash://sha1/317d7f840e598f5f3be732ab0e04f00a8051c6d0'
delta.file <- contentid::resolve(sha1, registries=c("dataone"), store = TRUE)

# fix the sample date format, and filter for species of interest
delta_data <- read.csv(delta.file) %>% 
    mutate(SampleDate = mdy(SampleDate))  %>% 
    filter(grepl("Salmon|Striped Bass|Smelt|Sturgeon", CommonName)) %>% 
    rename(DissolvedOxygen = DO,
           Ph = pH,
           SpecificConductivity = SpCnd)

cols <- names(delta_data)

sites <- delta_data %>% 
    distinct(StationCode, Latitude, Longitude) %>% 
    drop_na() %>% 
    st_as_sf(coords = c('Longitude','Latitude'), crs = 4269,  remove = FALSE)



# Define UI for application
ui <- fluidPage(
    navbarPage(theme = shinytheme("flatly"), 
               collapsible = TRUE,
               HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">Sacramento River Floodplain Data</a>'), 
               id="nav",
               windowTitle = "Sacramento River floodplain fish and water quality data",
               
               tabPanel("Data Sources",
                        verticalLayout(
                            # Application title and data  source
                            titlePanel("Sacramento River floodplain fish and water quality data"),
                            p("Data for this application are from: "),
                            tags$ul(
                                tags$li("Interagency Ecological Program: Fish catch and water quality data from the Sacramento River floodplain and tidal slough, collected by the Yolo Bypass Fish Monitoring Program, 1998-2018.",
                                        tags$a("doi:10.6073/pasta/b0b15aef7f3b52d2c5adc10004c05a6f", href="http://doi.org/10.6073/pasta/b0b15aef7f3b52d2c5adc10004c05a6f")
                                )
                            ),
                            tags$br(),
                            tags$hr(),
                            p("Map of sampling locations"),
                            mainPanel(leafletOutput("map"))
                        )
               ),
               
               tabPanel(
                   "Explore",
                   verticalLayout(
                       mainPanel(
                           plotOutput("distPlot"),
                           width =  12,
                           absolutePanel(id = "controls",
                                         class = "panel panel-default",
                                         top = 175, left = 75, width = 300, fixed=TRUE,
                                         draggable = TRUE, height = "auto",
                                         sliderInput("date",
                                                     "Date:",
                                                     min = as.Date("1998-01-01"),
                                                     max = as.Date("2020-01-01"),
                                                     value = c(as.Date("1998-01-01"), as.Date("2020-01-01")))
                           )
                       ),
                       
                       tags$hr(),
                       
                       sidebarLayout(
                           sidebarPanel(
                               selectInput("x_variable", "X Variable", cols, selected = "SampleDate"),
                               selectInput("y_variable", "Y Variable", cols, selected = "Count"),
                               selectInput("color_variable", "Color", cols, selected = "CommonName")
                           ),
                           
                           # Show a plot with configurable axes
                           mainPanel(
                               plotOutput("varPlot")
                           )
                       ),
                       tags$hr()
                   )
               )
    )
)

# Define server logic required to draw the two plots
server <- function(input, output) {
    
    output$map <- renderLeaflet({leaflet(sites) %>% 
            addTiles() %>% 
            addCircleMarkers(data = sites,
                             lat = ~Latitude,
                             lng = ~Longitude,
                             radius = 10, # arbitrary scaling
                             fillColor = "gray",
                             fillOpacity = 1,
                             weight = 0.25,
                             color = "black",
                             label = ~StationCode)
    })
    
    #  turbidity plot
    output$distPlot <- renderPlot({
        
        ggplot(delta_data, mapping = aes(SampleDate, Secchi)) +
            geom_point(colour="salmon", size=4) +
            xlim(c(input$date[1],input$date[2])) +
            labs(x = "Sample Date", y = "Secchi Depth (m)") +
            theme_light()
    })
    
    # mix and  match plot
    output$varPlot <- renderPlot({
        ggplot(delta_data, mapping = aes(x = .data[[input$x_variable]],
                                         y = .data[[input$y_variable]],
                                         color = .data[[input$color_variable]])) +
            labs(x = to_any_case(input$x_variable, case = "title"),
                 y = to_any_case(input$y_variable, case = "title"),
                 color = to_any_case(input$color_variable, case = "title")) +
            geom_point(size=4) +
            theme_light()
    })
}


# Run the application 
shinyApp(ui = ui, server = server)
