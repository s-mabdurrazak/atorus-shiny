# rainApi_Niagara
# modFetchDataReprex

rainApi_Niagara <- function(url) {
     data <- tryCatch({
          jsonlite::fromJSON(url)
     }, error = function(e) {
          message("Error fetching data: ", e)
          return(NULL)
     })

     if (is.null(data)) {
          return("Please manually enter a value")
     }

     first_row <- data$observations
     value <- first_row$imperial$precipTotal

     if (is.null(value)) {
          return("Please manually enter a value")
     } else {
          return(value)
     }
}
