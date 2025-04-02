# uiFunctions
# modFetchDataReprex

# maxUV UI component
uvIndexUI <- function(ns) {
     tagList(
          h3(id = ns("uvIndexDisplay"),
             textOutput(ns("uvIndex"))
          ),
          div(id = ns("uvIndexEditArea"),
             style = "display: none;",
             numericInput(ns("uvIndexNewInput"),
                           label = NULL,
                           value = 0)
          ),
          actionButton(ns("uvIndexEditButton"),
                       "",
                       class = "btn-sm"),
          actionButton(ns("uvIndexSaveButton"),
                       "Save UV Index",
                       class = "btn-sm save-btn",
                       style = "display: none;"
          )
     )
}

# wndSpd UI component
wndSpdUI <- function(ns) {
     tagList(
          h3(id = ns("wndSpdDisplay"),
             textOutput(ns("wndSpd"))
          ),
          div(id = ns("wndSpdEditArea"),
              style = "display: none;",
              numericInput(ns("wndSpdNewInput"),
                           label = NULL,
                           value = 0)
          ),
          actionButton(ns("wndSpdEditButton"),
                       "Edit Average Wind Speed",
                       class = "btn-sm"),
          actionButton(ns("wndSpdSaveButton"),
                       "Save Average Wind Speed",
                       class = "btn-sm save-btn",
                       style = "display: none;"
          )
     )
}

# airTemp UI component
airTempUI <- function(ns) {
     tagList(
          h3(id = ns("airTempDisplay"),
             textOutput(ns("airTemp"))
          ),
          div(id = ns("airTempEditArea"),
              style = "display: none;",
              numericInput(ns("airTempNewInput"),
                           label = NULL,
                           value = 0)
          ),
          actionButton(ns("airTempEditButton"),
                       "Edit Air Temperature",
                       class = "btn-sm"),
          actionButton(ns("airTempSaveButton"),
                       "Save Air Temperature",
                       class = "btn-sm save-btn",
                       style = "display: none;"
          )
     )
}

# rain UI component
rainUI <- function(ns) {
     tagList(
          h3(id = ns("rainDisplay"),
             textOutput(ns("rain"))
          ),
          div(id = ns("rainEditArea"),
              style = "display: none;",
              numericInput(ns("rainNewInput"),
                           label = NULL,
                           value = 0)),
          actionButton(ns("rainEditButton"),
                       "Edit Rainfall",
                       class = "btn-sm"
          ),
          actionButton(ns("rainSaveButton"),
                       "Save Rainfall",
                       class = "btn-sm save-btn",
                       style = "display: none;"
          )
     )
}

# Toronto Dropdown Inputs
torontoDropInputsUI <- function(ns) {
     tagList(
          selectInput(ns("eColi"),
                      "Previous day E. coli",
                      choices = c("1 - 50",
                                  "50.01 - 100",
                                  "100.01 - 200",
                                  "200.01 - 500")
          ),
          selectInput(ns("turbidity"),
                      "Turbidity",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 50")
          ),
          selectInput(ns("streamDischarge"),
                      "Stream Discharge",
                      choices = c("0 - 10",
                                  "10.01 - 20",
                                  "20.01 - 30")
          ),
          selectInput(ns("waterFowlCount"),
                      "Water Fowl Count",
                      choices = c("0 - 10",
                                  "10.01 - 20",
                                  "20.01 - 30")
          )
     )
}

# Niagara Dropdown Inputs
niagaraDropInputsUI <- function(ns) {
     tagList(
          selectInput(ns("eColi"),
                      "Previous day E. coli",
                      choices = c("1 - 50",
                                  "50.01 - 100",
                                  "100.01 - 200",
                                  "200.01 - 500")
          ),
          selectInput(ns("turbidity"),
                      "Turbidity",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 50")
          ),
          selectInput(ns("waveHeight"),
                      "Shore Wave Height",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 50")
          ),
          selectInput(ns("waterTemp"),
                      "Water Temperature",
                      choices = c("0 - 15",
                                  "15.01 - 20",
                                  "20.01 - 25")
          )
     )
}

# Winnipeg Dropdown Inputs
winnipegDropInputsUI <- function(ns) {
     tagList(
          selectInput(ns("eColi"),
                      "Previous day E. coli",
                      choices = c("1 - 50",
                                  "50.01 - 100",
                                  "100.01 - 200",
                                  "200.01 - 500")
          ),
          selectInput(ns("daysSinceRain"),
                      "Days Since Last Rain",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 15")
          )
     )
}

# Vancouver Dropdown Inputs
vancouverDropInputsUI <- function(ns) {
     tagList(
          selectInput(ns("salinity"),
                      "Mean Salinity",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 50")
          ),
          selectInput(ns("waveHeight"),
                      "Previous Wave Height",
                      choices = c("0 - 5",
                                  "5.01 - 10",
                                  "10.01 - 50")
          )
     )
}