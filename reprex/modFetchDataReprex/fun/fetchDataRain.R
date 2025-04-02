# fetchDataRain
# modFetchDataReprex

# Helper Function to fetch rainfall from region URL
fetchDataRain <- function(id) {
     if (id == "Toronto"){
          url <- "https://toronto.weatherstats.ca/data/rain-daily.json?refresh_count=0&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
     if (id == "Niagara"){
          url <- "https://api.weather.com/v2/pws/observations/current?apiKey=e1f10a1e78da46f5b10a1e78da96f525&units=e&stationId=ISTCATHA12&format=json"
          value <- rainApi_Niagara(url)
          return(value)
     }
     if (id == "Vancouver"){
          url <- "https://vancouver.weatherstats.ca/data/rain-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
     if (id == "Winnipeg"){
          url <- "https://winnipeg.weatherstats.ca/data/rain-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
}