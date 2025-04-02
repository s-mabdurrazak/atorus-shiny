# # Niagara Module UI
## initially had two modules, Toronto and Niagara.
## But I renamed Toronto to Page, and made it so that the landing page sends an id
## into the router. That id would then be used with print(paste()) to change
## aspects of the UI. For instance print(paste(`id`, "Dashboard")) would display
## Toronto Dashboard. Observers on the page module would need to send the id to the
## outsource modular functions as well. For instance, from the page module, it sends
## the id to the neutral module. Within there, we can have logic that reacts differently
## based on the id value. For instance if id == Toronto do this, if == Niagara do this.
## With these changes, niagara.R is no longer used.

# niagara_ui <- function(id) {
#      ns <- NS(id)
#      tagList(
#           h2("Niagara Dashboard"),
#           actionButton(ns("process"), "Process in Niagara"),
#           numericInput(ns("user_number"), "Enter a number", value = 10)
#      )
# }
#
# # Adjusted Niagara Module Server to pass a user-defined number to the neutral module
# niagara_server <- function(id) {
#      moduleServer(id, function(input, output, session) {
#           observeEvent(input$process, {
#                # Use the namespaced ID to retrieve the input
#                user_defined_number <- input$user_number
#                print(user_defined_number)
#
#                # Correctly call the neutral module server with the retrieved number
#                neutral_module_server("neutral_module", "Niagara", user_defined_number)
#           })
#      })
# }
