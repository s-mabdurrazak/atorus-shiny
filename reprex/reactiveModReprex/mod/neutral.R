# neutral module
# reactiveModReprex

# Adjusted Neutral Module to accept a user-defined number and return a reactive result
neutral_module_server <- function(id, number) {
     moduleServer(id, function(input, output, session) {

          # Create a reactive expression for the result
          result <- reactive({
               if(id == "Toronto") {
                    number() + number()  # number, passed from page module, needs to be reactive
               } else if(id == "Niagara") {
                    number() * number()
               } else {
                    NA
               }
          })

          # Return the reactive result for use in page module
          return(result())
     })
}
