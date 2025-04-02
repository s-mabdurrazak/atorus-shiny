# fetchDataMaxUV
# modFetchDataReprex

# Helper Function to fetch maxUV from region URL
fetchDataMaxUV <- function(id) {
     if (id == "Toronto"){
          url <- "https://toronto.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=1&browser_zone=Eastern+Daylight+Time"
          value <- maxUVapi(url)
          return(value)
     }
     if (id == "Niagara"){
          url <- "https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=1&browser_zone=Eastern+Standard+Time"
          value <- maxUVapi(url)
          return(value)
     }
     if (id == "Vancouver"){
          url <- "https://vancouver.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- maxUVapi(url)
          return(value)
     }
     if (id == "Winnipeg"){
          url <- "https://winnipeg.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- maxUVapi(url)
          return(value)
     }
}