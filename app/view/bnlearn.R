#app/view/bnlearn

box::use(
  shiny[
    NS, actionButton, column, div, eventReactive, fluidPage, fluidRow,
    icon, moduleServer, numericInput, observeEvent, plotOutput, reactive, reactiveValues,
    renderPlot, renderText, renderUI, req, selectInput, updateSelectInput, span, tagList,
    tags, textOutput, uiOutput, updateNumericInput
  ],
  shinyjs[
    hide, show, toggle, disable, enable, useShinyjs
  ],
  shinycssloaders[
    showPageSpinner, hidePageSpinner
  ],
  leaflet[
    leaflet, setView, addTiles, addCircles, renderLeaflet, leafletOutput
  ],
  DT[
    datatable, DTOutput, renderDT
  ],
  ggplot2[
    ggplot, aes_string, geom_point, geom_line,
    ggtitle, theme_classic, theme, element_text
  ],
  jsonlite[fromJSON],
  bnlearn[cpquery],
  bs4Dash[box],
  plotly[ggplotly, renderPlotly, plotlyOutput]
)

box::use(
  app/logic/datasets[BeachEcoli, BeachLocation, AllWeather, modNiagara]
)

#' @export
ui <- function(id){
  ns <- NS(id)
  
  if (id == "app-Winnipeg") {
    pageName <- "Winnipeg"
    selectedBeachID <- "Gimli"
  } else if (id == "app-Toronto") {
    pageName <- "Toronto"
    selectedBeachID <- "Cherry"
  } else if (id == "app-Niagara") {
    pageName <- "Niagara"
    selectedBeachID <- "Bay"
  } else if (id == "app-Vancouver") {
    pageName <- "Vancouver"
    selectedBeachID <- "Sunset"
  } else {
    pageName <- ""
  }
  
  fluidPage(
    useShinyjs(),
    div(
      # Niagara Predictions
      div(
        fluidRow(
          bs4Dash::box(id = ns("cardHeaderNiagara"),
              title = paste("Predictions for", pageName," Beaches. Enter today's (", format(Sys.Date(), "%B %d, %Y"),") environmental data to create a prediction"),
              background = "info",
              solidHeader = TRUE,
              width = 12,
              collapsible = FALSE,
              closable = FALSE
          )
        ),
        fluidRow(
          # First column for the result text and fetched data
          column(width = 6,
                 uiOutput(ns("resultBox")),
                 # Hidden div for displaying fetched data
                 bs4Dash::box(
                   id = ns("fetchedDataBox"),
                   width = 12,
                   collapsible = FALSE,
                   closable = FALSE,
                   div(id = ns("fetchedDataDiv"), style = "display: none;",
                       tags$h4("Fetched Environmental Data:"),
                       
                       #maxUV
                       div(id = ns("maxUV24Display"), textOutput(ns("maxUV24"))),
                       div(id = ns("maxUV24Edit"),
                           style = "display: none;",
                           numericInput(ns("maxUV24Input"), label = NULL, value = 0)),
                       actionButton(ns("editMaxUV24"), "Edit UV Index", icon = icon("edit"), class = "btn-sm"),
                       actionButton(ns("saveMaxUV24"), "Save UV Index", icon = icon("floppy-disk"), class = "btn-sm save-btn", style = "display: none;"),
                       
                       #avgwspd
                       div(id = ns("avgwspdDisplay"), textOutput(ns("avgwspd"))),
                       div(id = ns("avgwspdEdit"),
                           style = "display: none;",
                           numericInput(ns("avgwspdInput"), label = NULL, value = 0)),
                       actionButton(ns("editAvgwspd"), "Edit Wind Speed", icon = icon("edit"), class = "btn-sm"),
                       actionButton(ns("saveAvgwspd"), "Save Wind Speed", icon = icon("floppy-disk"), class = "btn-sm save-btn", style = "display: none;"),
                       
                       
                       #rain48
                       div(id = ns("rain48Display"), textOutput(ns("rain48"))),
                       div(id = ns("rain48Edit"),
                           style = "display: none;",
                           numericInput(ns("rain48Input"), label = NULL, value = 0)),
                       actionButton(ns("editRain48"), "Edit Rainfall", icon = icon("edit"), class = "btn-sm"),
                       actionButton(ns("saveRain48"), "Save Rainfall", icon = icon("floppy-disk"), class = "btn-sm save-btn", style = "display: none;"),
                       
                       #meantemp24
                       div(id = ns("meantemp24Display"), textOutput(ns("meantemp24"))),
                       div(id = ns("meantemp24Edit"),
                           style = "display: none;",
                           numericInput(ns("meantemp24Input"), label = NULL, value = 0)),
                       actionButton(ns("editMeantemp24"), "Edit Temperature", icon = icon("edit"), class = "btn-sm"),
                       actionButton(ns("saveMeantemp24"), "Save Temperature", icon = icon("floppy-disk"), class = "btn-sm save-btn", style = "display: none;")
                   )
                 )
          ),
          # Second column for the user inputted data
          column(width = 6,
                 bs4Dash::box(id =ns("cardNiagaraUserInput"),
                     width = 12,
                     collapsible = FALSE,
                     closable = FALSE,
                     tags$h4("Environmental Data:"),
                     selectInput(inputId = ns("WaveHeight"), label = "Wave Height", choices = c("0 - 5.00", "5.01 - 10.00", "10.01 - 60")),
                     selectInput(inputId = ns("Geomean24"), label = "Yesterday's geomean e. coli", choices = c("1 - 50.00", "50.01 - 100.00", "100.01 - 200.00", "200.01 - 2072.7")),
                     selectInput(inputId = ns("WaterTemp"), label = "Water Temperature (°C)", choices = c("0 - 15.00", "15.01 - 23.44", "23.45 - 30")),
                     selectInput(inputId = ns("Turbidity"), label = "Turbidity", choices = c("0 - 5.00", "5.01 - 10.00", "10.01 - 713")),
                     actionButton(ns("fetchDataBtn"), "Fetch Data"),
                     actionButton(ns("predictBtn"), "Predict")
                 )
          )
        )
      ),
      
      # Niagara
      div(
        fluidRow(
          bs4Dash::box(id=ns("cardHeaderNiagara"),
              title ="Historical Water Quality and Environmental Data (available from 2011 to 2019)",
              width = 12,
              background = "info",
              solidHeader = TRUE,
              collapsible = FALSE,
              closable = FALSE
          )
        ),
        # Beach location dropdown
        fluidRow(
          column(width = 6, offset = 6,
                 selectInput(ns("ecoliyVar"),
                             label = "Specify a Beach:",
                             choices = setdiff(names(BeachEcoli), "Year"),
                             selected = selectedBeachID)
          )
        ),
        # E.coli plot and Leaflet
        fluidRow(
          column(6,
                 leafletOutput(ns("leafletmap"))
          ),
          column(6,
                 plotlyOutput(ns("ecoliplot"))
                 
          )
        ),
        # Table for E. coli concentrations
        fluidRow(
          style = "margin-top: 3rem;",
          bs4Dash::box(id=ns("cardHeaderNiagara"),
              title = paste("E. coli concentrations at", pageName, "beaches (CFU/100ml)"),
              width = 12,
              background = "info",
              solidHeader = TRUE,
              collapsible = FALSE,
              closable = FALSE
          ),
          column(12,
                 DTOutput(ns("beachTable"))
          )
        ),
        # Weather plot placeholder
        fluidRow(
          style = "margin-top: 3rem;",
          bs4Dash::box(id=ns("cardHeaderNiagara"),
              title = "Seasonal Environmental Data Visualization",
              width = 12,
              background = "info",
              solidHeader = TRUE,
              collapsible = FALSE,
              closable = FALSE
          ),
          column(12,
              selectInput(ns("weatheryVar"),
                          label = "Specify an Environmental Variable:",
                          choices = setdiff(names(AllWeather), "Year"),
                          selected = "Rainfall"),
              plotlyOutput(ns("weatherplot"))
          )
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
  ns <- session$ns
  
  # NOTE: NEED TO MOVE ALL HELPER FUNCTIONS BELOW TO /logic AND @export THEN box::use()
  
  # Set values based on session id
  if (id == "Toronto") {
    longitude <- -79.3
    latitude <- 43.7
    datID <- BeachLocation[9:19, ]
  } else if (id == "Niagara") {
    longitude <- -79.1
    latitude <- 42.8
    datID <- BeachLocation[1:8, ]
  } else if (id == "Winnipeg") {
    longitude <- -96.6
    latitude <- 50.5
    datID <- BeachLocation[35:37, ]
  } else if (id == "Vancouver") {
    longitude <- -123.1
    latitude <- 49.3
    datID <- BeachLocation[20:34, ]
  } else {
    # fallback
    longitude <- -79.3
    latitude <- 43.7
    datID <- BeachLocation[2:9, ]
  }
  
  # Define reactive values
  values <- reactiveValues(maxUV24 = NULL,
                           avgwspd = NULL,
                           rain48 = NULL,
                           meantemp24 = NULL,
                           predictionResult = NULL)
  
  # Helper Function to fetch and parse maxUV data from a JSON URL
  fetchDataMaxUV <- function(url) {
    data <- jsonlite::fromJSON(url)
    first_row <- data$rows$c[[1]]
    value <- first_row$v[[2]]
    return(value)
  }
    
  # Helper Function to fetch and parse avgwspd data from a JSON URL
  fetchDataAvgwspd <- function(url) {
    data <- jsonlite::fromJSON(url)
    first_row <- data$rows$c[[1]]
    value <- first_row$v[[3]]
    return(value)
  }
    
  # Helper Function to fetch and parse rain48 data from a JSON URL
  fetchDataRain48 <- function(url) {
    data <- jsonlite::fromJSON(url)
    first_row <- data$rows$c[[1]]
    second_row <- data$rows$c[[2]]
    value <- first_row$v[[2]] + second_row$v[[2]]
    
    # Check if either of the values is NULL
    if (is.null(first_row$v[[2]]) || is.null(second_row$v[[2]])) {
      return("Please manually enter a value")
    } else {
      value <- first_row$v[[2]] + second_row$v[[2]]
      return(value)
    }
  }
    
  # Helper Function to fetch and parse data from a JSON URL
  fetchDataMeantemp <- function(url) {
    data <- jsonlite::fromJSON(url)
    first_row <- data$rows$c[[1]]
    value <- first_row$v[[3]]
    return(value)
  }
    
  # Helper function to extract numeric range from input string
  getNumericRange <- function(inputString) {
    # Assuming the input format is "min - max"
    rangeParts <- strsplit(inputString, " - ")[[1]]
    return(as.numeric(rangeParts[1])) # Returns the lower bound of the range
  }
    
  # Reactive expression to determine the box color
  boxColour <- reactive({
    if (!is.null(values$predictionResult) && !is.na(values$predictionResult)) {
      percentage <- values$predictionResult
      if (percentage <= 30) {
        return("success")
      } else if (percentage <= 65) {
        return("warning")
      } else {
        return("danger")
      }
    } else {
      return("gray-dark")  # Default color when app starts or if predictionResult is not valid
    }
  })
    
    
  # Function to determine the increment for Max24UV
  determineMax24UVIncrement <- function(value) {
    if (value >= 0 && value <= 5.98) {
      return("[0,5.98]")
    } else if (value > 5.98 && value <= 7.1) {
      return("(5.98,7.1]")
    } else if (value > 7.1 && value <= 7.92) {
      return("(7.1,7.92]")
    } else if (value > 7.92 && value <= 12) {
      return("(7.92,12]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
  
  # Function to determine the increment for Rainfall
  determineRain48Increment <- function(value) {
    if (is.na(value) || !is.numeric(value)) {
      return(NA)
    } else if (value >= 0 && value <= 2.5) {
      return("[0,2.5]")
    } else if (value > 2.5 && value <= 7.6) {
      return("(2.5,7.6]")
    } else if (value > 7.6 && value <= 240) {
      return("(7.6,240]")
    } else {
      return(NA)  # Handle out-of-range values
    }
  }
    
  # Function to determine the increment for meantemp24
  determineMeantemp24Increment <- function(value) {
    if (value >= 7.3 && value <= 17.2) {
      return("[7.3,17.2]")
    } else if (value > 17.2 && value <= 24) {
      return("(17.2,24]")
    } else if (value > 24 && value <= 32.1) {
      return("(24,32.1]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
  
  # Function to determine the increment for waveheight
  determineWaveHeightIncrement <- function(value) {
    if (value >= 0 && value <= 5) {
      return("[0,5]")
    } else if (value > 5 && value <= 10) {
      return("(5,10]")
    } else if (value > 10 && value <= 60) {
      return("(10,60]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
    
  # Function to determine the increment for geomean24
  determineGeomean24Increment <- function(value) {
    if (value >= 1 && value <= 50) {
      return("[1,50]")
    } else if (value > 50 && value <= 100) {
      return("(50,100]")
    } else if (value > 100 && value <= 200) {
      return("(100,200]")
    } else if (value > 200 && value <= 2072.7) {
      return("(200,2072.7]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
  
  # Function to determine the increment for watertemp
  determineWaterTempIncrement <- function(value) {
    if (value >= 0 && value <= 15) {
      return("[0,15]")
    } else if (value > 15 && value <= 23.4) {
      return("(15,23.4]")
    } else if (value > 23.4 && value <= 30) {
      return("(23.4,30]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
    
  # Function to determine the increment for turbidity
  determineTurbidityIncrement <- function(value) {
    if (value >= 0 && value <= 5) {
      return("[0,5]")
    } else if (value > 5 && value <= 10) {
      return("(5,10]")
    } else if (value > 10 && value <= 713) {
      return("(10,713]")
    } else {
      return(NA) # or handle out-of-range values as needed
    }
  }
    
  # Initially hide the fetchedDataBox
  shinyjs::hide("fetchedDataBox")
  
  # Initially disable the Predict button
  shinyjs::disable("predictBtn")
    
  # Observer for the "Fetch Data" button
  observeEvent(input$fetchDataBtn, {
    showPageSpinner()
    
    message("automative data button press")
    # Fetch data for each metric
    
    maxUV24_value <- fetchDataMaxUV("https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=1&browser_zone=Eastern+Standard+Time") 
    
    # NOTE: NEED TO ADD avgvhwh24
    
    # NOTE: BELOW NEEDS TO BE MODULARIZED ONCE DATA SOURCES CONFIRMED
    
    avgwspd_value <- fetchDataAvgwspd("https://niagarafalls.weatherstats.ca/data/wind_speed-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time")
    rain48_value <- fetchDataRain48("https://toronto.weatherstats.ca/data/rain-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time") # NOTE: THIS IS TORONTO AND NEEDS TO BE CHANGED TO A NIAGARA DATA SOURCE
    meantemp24_value <- fetchDataMeantemp("https://niagarafalls.weatherstats.ca/data/temperature-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time")
    
    # Update reactive values
    values$maxUV24 <- maxUV24_value
    values$avgwspd <- avgwspd_value
    values$rain48 <- rain48_value
    values$meantemp24 <- meantemp24_value
    
    # Update UI with fetched data
    output$maxUV24 <- renderText({ paste("Yesterday's UV Index:", maxUV24_value) })
    output$avgwspd <- renderText({ paste("Average Wind Speed (km/h):", avgwspd_value) })
    output$rain48 <- renderText({ paste("Rainfall across 48h (mm):", rain48_value) })
    output$meantemp24 <- renderText({ paste("Average Temperature (°C):", meantemp24_value) })
    
    # Set initial values for edit inputs
    updateNumericInput(session, "maxUV24Input", value = maxUV24_value)
    updateNumericInput(session, "avgwspdInput", value = avgwspd_value)
    updateNumericInput(session, "rain48Input", value = rain48_value)
    updateNumericInput(session, "meantemp24Input", value = meantemp24_value)
    
    # Make the box and div visible
    shinyjs::show("fetchedDataBox")
    shinyjs::show("fetchedDataDiv")
    
    # Enable the Predict button once data is fetched
    shinyjs::enable("predictBtn")
    
    Sys.sleep(1)
    hidePageSpinner()
  })
    
  # Toggle edit/display for maxUV24
  observeEvent(input$editMaxUV24, {
    shinyjs::toggle("maxUV24Display")
    shinyjs::toggle("maxUV24Edit")
    shinyjs::toggle("editMaxUV24")
    shinyjs::toggle("saveMaxUV24")
  })
    
  # Save new value for maxUV24
  observeEvent(input$saveMaxUV24, {
    shinyjs::toggle("maxUV24Display")
    shinyjs::toggle("maxUV24Edit")
    shinyjs::toggle("editMaxUV24")
    shinyjs::toggle("saveMaxUV24")
    
    # Update reactive value
    values$maxUV24 <- input$maxUV24Input
    output$maxUV24 <- renderText({ paste("Yesterday's UV Index:", values$maxUV24) })
  })
    
  # Toggle edit/display for avgwspd
  observeEvent(input$editAvgwspd, {
    shinyjs::toggle("avgwspdDisplay")
    shinyjs::toggle("avgwspdEdit")
    shinyjs::toggle("editAvgwspd")
    shinyjs::toggle("saveAvgwspd")
  })
    
  # Save new value for avgwspd
  observeEvent(input$saveAvgwspd, {
    shinyjs::toggle("avgwspdDisplay")
    shinyjs::toggle("avgwspdEdit")
    shinyjs::toggle("editAvgwspd")
    shinyjs::toggle("saveAvgwspd")
    
    # Update reactive value
    values$avgwspd <- input$avgwspdInput
    output$avgwspd <- renderText({ paste("Average Wind Speed (km/h):", values$avgwspd) })
  })
  
  # Toggle edit/display for rain48
  observeEvent(input$editRain48, {
    shinyjs::toggle("rain48Display")
    shinyjs::toggle("rain48Edit")
    shinyjs::toggle("editRain48")
    shinyjs::toggle("saveRain48")
  })
    
  # Save new value for rain48
  observeEvent(input$saveRain48, {
    shinyjs::toggle("rain48Display")
    shinyjs::toggle("rain48Edit")
    shinyjs::toggle("editRain48")
    shinyjs::toggle("saveRain48")
    
    # Update reactive value
    values$rain48 <- input$rain48Input
    output$rain48 <- renderText({ paste("Rainfall across 48h (mm):", values$rain48) })
  })
  
  # Toggle edit/display for meantemp24
  observeEvent(input$editMeantemp24, {
    shinyjs::toggle("meantemp24Display")
    shinyjs::toggle("meantemp24Edit")
    shinyjs::toggle("editMeantemp24")
    shinyjs::toggle("saveMeantemp24")
  })
    
  # Save new value for meantemp24
  observeEvent(input$saveMeantemp24, {
    shinyjs::toggle("meantemp24Display")
    shinyjs::toggle("meantemp24Edit")
    shinyjs::toggle("editMeantemp24")
    shinyjs::toggle("saveMeantemp24")
    
    # Update reactive value
    values$meantemp24 <- input$meantemp24Input
    output$meantemp24 <- renderText({ paste("Average Temperature (°C):", values$meantemp24) })
  })
    
  # Process inputs and return increments
  processedInputs <- eventReactive(input$predictBtn, {
    print("processing")
    # Fetch the values from inputs
    waveHeightInput <- input$WaveHeight
    geomean24Input <- input$Geomean24
    waterTempInput <- input$WaterTemp
    turbidityInput <- input$Turbidity
    
    # Use the reactive value
    maxUV24Value <- values$maxUV24
    rain48Value <- values$rain48
    message("maxUV24Increment:", maxUV24Value)
    message("rain48Increment:", rain48Value)
    message("waveHeightIncrement:", waveHeightInput)
    message("geomean24Increment:", geomean24Input)
    message("waterTempIncrement:", waterTempInput)
    message("turbidityIncrement:", turbidityInput)
    
    list(
      # Process the inputs through the respective functions
      waveHeightIncrement = determineWaveHeightIncrement(getNumericRange(waveHeightInput)),
      geomean24Increment = determineGeomean24Increment(getNumericRange(geomean24Input)),
      waterTempIncrement = determineWaterTempIncrement(getNumericRange(waterTempInput)),
      turbidityIncrement = determineTurbidityIncrement(getNumericRange(turbidityInput)),
      maxUV24Increment = determineMax24UVIncrement(maxUV24Value),
      rain48Increment = determineRain48Increment(rain48Value)
      
    )
    
  })
    
  # Use processed inputs in cpquery
  observeEvent(input$predictBtn, {
    req(processedInputs())
    print("observing") # NOTE: REMOVE ALL CONSOLE MESSAGES ONCE DEPLOYED IN PRODUCTION 
    
    # Use the increments in cpquery
    increments <- processedInputs()
    #print(increments) # this prints the correct thing
    
    # Construct the evidence string
    evidenceString <- paste0(
      "(Max24UV == '", increments$maxUV24Increment, "' & ",
      "rain48 == '", increments$rain48Increment, "' & ",
      "waveheight == '", increments$waveHeightIncrement, "' & ",
      "geomean24 == '", increments$geomean24Increment, "' & ",
      "watertemp == '", increments$waterTempIncrement, "' & ",
      "turbidity == '", increments$turbidityIncrement, "')"
    )
    
    message(evidenceString)
    
    # Construct the cpquery call as a string
    cpqueryString <- paste(
      "cpquery(modNiagara,",
      "event = (geomean200 == 'true'),",
      "evidence = ", evidenceString,
      ")"
    )
    
    # Evaluate the cpquery string
    predictionResult <- eval(parse(text = cpqueryString))
    
    predictionResultPercentage <- round(predictionResult * 100, 2)
    message("Result:", predictionResultPercentage)
    values$predictionResult <- predictionResultPercentage
    
    #Update the UI with the prediction result
    output$result_text <- renderText({
      if (!is.null(values$predictionResult)) {
        paste0(values$predictionResult, " %")
      } else {
        ""  # Default text when app starts or if predictionResult is not available
      }
    })
    
    
    
  })
    
    output$resultBox <- renderUI({
      bs4Dash::box(id = "cardNiagaraProb",
          title = "",
          background = boxColour(),
          solidHeader = TRUE,
          width = 12,
          collapsible = FALSE,
          closable = FALSE,
          tags$h4("The probability (%) of E. coli exceeding the 200CFU/100mL guideline is:"),
          textOutput(ns("result_text"))
      )
    })
    
    
    output$ecoliplot <- renderPlotly({
      p <- ggplot(BeachEcoli, aes_string(x = "Year", y = input$ecoliyVar)) +
        geom_point(size = 3) +
        geom_line() +
        ggtitle("Seasonal Mean E.coli") +
        theme_classic() +
        theme(text = element_text(size = 20))
      
      ggplotly(p)
    })
    
  output$leafletmap <- renderLeaflet({
    leaflet() |>
      setView(lng = longitude, lat = latitude, zoom = 9)  |>
      addTiles() |>
      addCircles(data = BeachLocation, lat = ~Lat_DD, lng = ~Long_DD, weight = 10, radius = 1000,
                 label = ~as.character(paste0(Beach_Name)), color = "blue", fillOpacity = 0.5)
  })
  
  output$beachTable <- renderDT({
    dt <- datID
    names(dt) <- sub("^X(\\d{4})$", "\\1", names(dt))
    DT::datatable(dt,
                  options = list(
                    paging = TRUE, # Enable pagination
                    searching = FALSE, # Disable search box
                    dom = 't'
                  ))
  })
    
  output$weatherplot <- renderPlotly({
    p <- ggplot(AllWeather, aes_string(x = "Year", y = input$weatheryVar)) +
      geom_point(size = 4) +
      geom_line() +
      ggtitle(paste(input$weatheryVar, "over Years")) +
      theme_classic() +
      theme(text = element_text(size = 20))
    
    ggplotly(p)
  })
  
  })
}