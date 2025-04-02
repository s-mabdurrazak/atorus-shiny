# page UI
# reactiveModReprex

page_ui <- function(id) {
     ns <- NS(id)
     tagList(
          h2(paste(id, "Dashboard")),
          actionButton(ns("process"), paste("Process in", id)),
          numericInput(ns("user_number"), "Enter a number", value = 10),
          h2(textOutput(ns("result_output")))
     )
}


# page server
page_server <- function(id) {
     moduleServer(id, function(input, output, session) {

          # Create a reactive value to store the result
          result_val <- reactiveVal()
          user_defined_number <- reactive({input$user_number})

          observeEvent(input$process, {

               # neutral_module_server must store the result in a reactiveVal or similar
               result <- neutral_module_server(id, user_defined_number)
               result_val(result)  # Update the reactive value with the result
          })

          # Construct and display the dynamic sentence including the reactive values
          output$result_output <- renderText({
               paste("The result for", id, "with number", isolate(user_defined_number()), "is:", result_val())
          })
     })
}
