# rainApi
# modFetchDataReprex

# Helper Function to fetch and parse rain48 data from a JSON URL
rainApi <- function(url) {
     data <- tryCatch({
          jsonlite::fromJSON(url)
     }, error = function(e) {
          message("Error fetching data: ", e)
          return(NULL)
     })

     if (is.null(data)) {
          return("Please manually enter a value")
     }

     first_row <- data$rows$c[[1]]
     second_row <- data$rows$c[[2]]

     if (is.null(first_row$v[[2]]) || is.null(second_row$v[[2]])) {
          return("Please manually enter a value")
     } else {
          value <- first_row$v[[2]] + second_row$v[[2]]
          return(value)
     }
}
