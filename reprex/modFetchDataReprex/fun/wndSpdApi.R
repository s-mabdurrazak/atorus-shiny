# wndSpdApi
# modFetchDataReprex

# Helper Function to fetch and parse avgwspd data from a JSON URL
wndSpdApi <- function(url) {
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
     value <- first_row$v[[3]]

     if (is.null(value)) {
          return("Please manually enter a value")
     } else {
          return(value)
     }
}
