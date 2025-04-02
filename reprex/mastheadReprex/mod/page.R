# page UI
page_ui <- function(id) {
     ns <- NS(id)
     tagList(
          h2(paste(id, "Dashboard")),
          actionButton(ns("process"), paste("Process in", id)),
          numericInput(ns("user_number"), "Enter a number", value = 10)
     )
}

# page server
page_server <- function(id) {
     moduleServer(id, function(input, output, session) {
          # Suppose there's an input in Toronto's UI where the user defines a number
          # For example, numericInput("user_number", "Enter a number", value = 10)

          # When 'process' button is clicked, pass the user-defined number to the neutral module
          observeEvent(input$process, {
               # Assuming 'user_number' is an input in Toronto module's UI
               user_defined_number <- input$user_number

               # Call neutral module server with Toronto as the context and pass the user-defined number
               neutral_module_server(id, user_defined_number)
          })
     })
}