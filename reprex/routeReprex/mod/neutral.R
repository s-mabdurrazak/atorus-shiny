neutral_module_ui <- function(id) {
     ns <- NS(id)
}

# Adjusted Neutral Module to accept a user-defined number
neutral_module_server <- function(id, region, number) {
     print(number)
     moduleServer(id, function(input, output, session) {
          # Logic to handle the number based on the region
          result <- if(region == "Toronto") {
               number + number  # Example operation for Toronto
          } else if(region == "Niagara") {
               number * number  # Example operation for Niagara
          } else {
               NA  # Default or error handling
          }

          print(paste("Result for", region, "with number", number, ":", result))
     })
}