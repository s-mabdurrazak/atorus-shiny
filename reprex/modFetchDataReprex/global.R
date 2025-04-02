# global.R
# modFetchDataReprex

## remotes::install_github("Appsilon/shiny.router")
library(shiny)
library(shiny.router)
library(shinyjs)
library(bs4Dash)
library(jsonlite)
library(htmltools)

source("fun/masthead.R")
source("fun/homeBody.R")

source("mod/page.R")
source("mod/neutral.R")
source("mod/landing.R")

source("datasets.R")

source("fun/variableCard.R")

source("fun/fetchDataMaxUV.R")
source("fun/maxUVapi.R")
source("fun/fetchDataAvgWndSpd.R")
source("fun/wndSpdApi.R")
source("fun/fetchDataAirTemp.R")
source("fun/airTempApi.R")
source("fun/fetchDataRain.R")
source("fun/rainApi.R")
source("fun/rainApi_Niagara.R") #required due to different data source
source("fun/uiFunctions.R")