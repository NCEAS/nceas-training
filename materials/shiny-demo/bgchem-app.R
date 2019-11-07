library(shiny)
library(ggplot2)

# Load our data from http://doi.org/10.18739/A25T3FZ8X, and download the first csv file 
# called "BGchem2008data.csv". The data URL is: 
data_url <- "https://arcticdata.io/metacat/d1/mn/v2/object/urn%3Auuid%3A35ad7624-b159-4e29-a700-0c0770419941"
bg_chem <- read.csv(data_url, stringsAsFactors = FALSE)
#bg_chem <- read.csv(url(data_url, method = "libcurl"), stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Water biogeochemistry"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("depth", "Depth:", min = 0, max = 500, value = c(0,100))
        ),

        # Show a plot of the generated scatterplot
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic for rendering a scatterplot
server <- function(input, output) {

    output$distPlot <- renderPlot({

        ggplot(bg_chem, mapping = aes(CTD_Depth, CTD_Salinity)) +
            geom_point(colour="red", size=4) +
            xlim(input$depth[1],input$depth[2]) +
            theme_light()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
