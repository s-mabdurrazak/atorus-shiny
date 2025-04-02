## this is the regionParam_reprex
## it is designed to be an MVP for user-input on region-specification
## the end user clicks on a button with that sends an inputID to server
## it then overwrites the reactive value for region
##

library(shiny)
library(bnlearn)

source("datasets.R")

# Define UI
ui <- fluidPage(
     titlePanel("Dynamic Region Selection for Bayesian Network"),
     sidebarLayout(
          sidebarPanel(
               actionButton("btn_niagara", "Niagara"),
               actionButton("btn_toronto", "Toronto")
          ),
          mainPanel(
               textOutput("selected_region"),
               textOutput("query_result")
          )
     )
)

# Define server logic
server <- function(input, output, session) {

     # Function to determine the increment for Max24UV
     determineMax24UVIncrement <- function(value) {
          if (value >= 0 && value <= 5.98) {
               return("[0,5.98]")
          } else if (value > 5.98 && value <= 7.1) {
               return("(5.98,7.1]")
          } else if (value > 7.1 && value <= 7.92) {
               return("(7.1,7.92]")
          } else if (value > 7.92 && value <= 12) {
               return("(7.92,12]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Example usage
     uv_dummy <- 2
     max24UV_increment <- determineMax24UVIncrement(uv_dummy)

     # Reactive value to store selected region
     selectedRegion <- reactiveVal("Niagara") # default value

     observeEvent(input$btn_niagara, {
          selectedRegion("Niagara")
     })

     observeEvent(input$btn_toronto, {
          selectedRegion("Toronto")
     })

     # Display selected region
     output$selected_region <- renderText({
          paste("Selected Region:", selectedRegion())
     })

     # Dynamic cpquery based on selected region
     output$query_result <- renderText({
          region <- selectedRegion()
          baynet <- get(paste0("mod", region)) # dynamically get the model based on selected region

          # Construct the cpquery call as a string

          cpqueryString <- paste(
               "cpquery(baynet,",
               "event = (geomean200 == 'true'),",
               "evidence = (Max24UV == ", max24UV_increment, ")",
               ")"
          )

          # This is a placeholder for the actual eval(parse(text=cpqueryString))
          # Normally, you would evaluate cpqueryString here
          paste("Query for", region, ":", cpqueryString)
     })
}

# Run the application
shinyApp(ui = ui, server = server)
