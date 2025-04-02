# Niagara Module UI
niagara_ui <- function(id) {
     ns <- NS(id)
     tagList(
          h2("Niagara Dashboard"),
          actionButton(ns("process"), "Process in Niagara"),
          numericInput(ns("user_number"), "Enter a number", value = 10)
     )
}

# Adjusted Niagara Module Server to pass a user-defined number to the neutral module
niagara_server <- function(id) {
     moduleServer(id, function(input, output, session) {
          observeEvent(input$process, {
               # Use the namespaced ID to retrieve the input
               user_defined_number <- input$user_number
               print(user_defined_number)

               # Correctly call the neutral module server with the retrieved number
               neutral_module_server("neutral_module", "Niagara", user_defined_number)
          })
     })
}
