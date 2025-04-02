# neutral module
# modFetchDataReprex

# Adjusted Neutral Module to accept a user-defined number
neutral_module_server <- function(id, number) {
     moduleServer(id, function(input, output, session) {
          # Logic to handle the number based on the region
          result <- if(id == "Toronto") {
               number + number  # Example operation for Toronto
          } else if(id == "Niagara") {
               number * number  # Example operation for Niagara
          } else {
               NA  # Default or error handling
          }

          print(paste("Result for", id, "with number", number, ":", result))
     })
}