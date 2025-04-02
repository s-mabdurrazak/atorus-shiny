# fetchDataAvgWndSpd
# modFetchDataReprex

# Helper Function to fetch average wind speed from region URL
fetchDataAvgWndSpd <- function(id) {
     if (id == "Toronto"){
          url <- "https://toronto.weatherstats.ca/data/wind_speed-daily.json?refresh_count=4&browser_zone=Eastern+Daylight+Time"
          value <- wndSpdApi(url)
          return(value)
     }
     if (id == "Niagara"){
          url <- "https://niagarafalls.weatherstats.ca/data/wind_speed-daily.json?refresh_count=1&browser_zone=Eastern+Daylight+Time"
          value <- wndSpdApi(url)
          return(value)
     }

     # Below is code to uncomment if AvgWndSpd is needed for Vancouver
     # if (id == "Vancouver"){
     #      url <- "https://vancouver.weatherstats.ca/data/wind_speed-daily.json?refresh_count=1&browser_zone=Eastern+Daylight+Time"
     #      value <- wndSpdApi(url)
     #      return(value)
     # }

     # Below is code to uncomment if AvgWndSpd is needed for Winnipeg
     # if (id == "Winnipeg"){
     #      url <- "https://winnipeg.weatherstats.ca/data/wind_speed-daily.json?refresh_count=1&browser_zone=Eastern+Daylight+Time"
     #      value <- wndSpdApi(url)
     #      return(value)
     # }
}