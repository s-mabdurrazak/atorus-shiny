# fetchDataAirTemp
# modFetchDataReprex

# Helper Function to fetch air temp from region URL
fetchDataAirTemp <- function(id) {
     if (id == "Toronto"){
          url <- "https://toronto.weatherstats.ca/data/temperature-daily.json?refresh_count=0&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
     if (id == "Niagara"){
          url <- "https://niagarafalls.weatherstats.ca/data/temperature-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- rainApi_Niagara(url)
          return(value)
     }
     if (id == "Vancouver"){
          url <- "https://vancouver.weatherstats.ca/data/temperature-daily.json?refresh_count=2&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
     if (id == "Winnipeg"){
          url <- "https://winnipeg.weatherstats.ca/data/temperature-daily.json?refresh_count=1&browser_zone=Eastern+Daylight+Time"
          value <- rainApi(url)
          return(value)
     }
}