# page UI
# modFetchDataReprex

page_ui <- function(id) {
     ns <- NS(id)
     tagList(
          mastheadNav,
          h2(paste(id, "Dashboard")),
          div(class="container-fluid",
              div(class="row",
                  # Left column with Environmental Data now on the left
                  div(class="col-md-4",
                      div(class="environmental-data card",
                          tags$h4("Environmental Data:"),
                          if (id == "Toronto") torontoDropInputsUI(ns),
                          if (id == "Niagara") niagaraDropInputsUI(ns),
                          if (id == "Winnipeg") winnipegDropInputsUI(ns),
                          if (id == "Vancouver") vancouverDropInputsUI(ns),
                          div(class="btn-group", style="width: 100%; padding: 20px;",
                              bs4Dash::actionButton(ns("fetchDataBtn"), "Fetch Data", class="btn button-submit", style="width: 25%; margin-right: 5%;"),
                              actionButton(ns("predictBtn"), "Predict", class="btn button-submit", style="width: 25%;")
                          ),
                          style="border: 1px solid black; padding: 10px;"
                      )
                  ),
                  # Right column for display of fetched data and graphs
                  div(class="col-md-8",
                      # Top row for variables as individual cards
                      div(class="row",
                          div(class="col-md-3 card",
                              tags$h4("UV Index"),
                              uvIndexUI(ns),
                              a(class="btn-edit", id=ns("uvIndexEditButton")),
                              style="border: 1px solid black; padding: 10px; margin-right: 5px;"
                          ),
                          div(class="col-md-3 card",
                              tags$h4("Avg Wind Speed"),
                              wndSpdUI(ns),
                              a(icon("edit"), class="btn-edit", id=ns("wndSpdEditButton")),
                              style="border: 1px solid black; padding: 10px; margin-right: 5px;"
                          ),
                          div(class="col-md-3 card",
                              tags$h4("Air Temp"),
                              airTempUI(ns),
                              a(icon("edit"), class="btn-edit", id=ns("airTempEditButton")),
                              style="border: 1px solid black; padding: 10px; margin-right: 5px;"
                          ),
                          div(class="col-md-3 card",
                              tags$h4("Rainfall"),
                              rainUI(ns),
                              a(icon("edit"), class="btn-edit", id=ns("rainEditButton")),
                              style="border: 1px solid black; padding: 10px;"
                          )
                      ),
                      # Bottom row for graphs
                      div(class="row",
                          div(class="col-md-6",
                              div(class="graph-placeholder",
                                  tags$h4("Graph 1 Placeholder"),
                                  style="border: 1px solid black; height: 300px;"
                              )
                          ),
                          div(class="col-md-6",
                              div(class="graph-placeholder",
                                  tags$h4("Graph 2 Placeholder"),
                                  style="border: 1px solid black; height: 300px;"
                              )
                          )
                      )
                  )
              )
          )
     )
}

# page server
page_server <- function(id) {
     moduleServer(id, function(input, output, session) {

          # Create a reactive value to store the fetched variables
          values <- reactiveValues(uvIndex = NULL,
                                   wndSpd = NULL,
                                   airTemp = NULL,
                                   rain = NULL)

          observeEvent(input$fetchDataBtn, {
               print(id)

          # maxUV
               uvIndex_value <- fetchDataMaxUV(id)
               values$uvIndex <- uvIndex_value

               # Update UI with fetched data
               output$uvIndex <- renderText({ paste("Yesterday's UV Index:", uvIndex_value) })

               # Set initial values for edit inputs
               updateNumericInput(session, "uvIndexNewInput", value = uvIndex_value)

          # avgwspd
               wndSpd_value <- fetchDataAvgWndSpd(id)
               values$wndSpd <- wndSpd_value

               # Update UI with fetched data
               output$wndSpd <- renderText({ paste("Yesterday's Average Wind Speed:", wndSpd_value) })

               # Set initial values for edit inputs
               updateNumericInput(session, "wndSpdNewInput", value = wndSpd_value)

          # airTemp
               airTemp_value <- fetchDataAirTemp(id)
               values$airTemp <- airTemp_value
               output$airTemp <- renderText({ paste("Yesterday's Air Temperature:", airTemp_value) })
               updateNumericInput(session, "airTempNewInput", value = airTemp_value)

          # rain
               rain_value <- fetchDataRain(id)
               values$rain <- rain_value
               output$rain <- renderText({ paste("Yesterday's Rainfall:", rain_value) })
               updateNumericInput(session, "rainNewInput", value = rain_value)
               })

          # maxUV
          # Toggle edit/display for uvIndex
          observeEvent(input$uvIndexEditButton, {
               shinyjs::toggle("uvIndexDisplay")
               shinyjs::toggle("uvIndexEditArea")
               shinyjs::toggle("uvIndexEditButton")
               shinyjs::toggle("uvIndexSaveButton")
          })

          # Save new value for uvIndex
          observeEvent(input$uvIndexSaveButton, {
               shinyjs::toggle("uvIndexDisplay")
               shinyjs::toggle("uvIndexEditArea")
               shinyjs::toggle("uvIndexEditButton")
               shinyjs::toggle("uvIndexSaveButton")

               # Update reactive value
               values$uvIndex <- input$uvIndexNewInput
               output$uvIndex <- renderText({ paste("Yesterday's UV Index:", values$uvIndex) })
          })

          # wndSpd
          # Toggle edit/display for wndSpd
          observeEvent(input$wndSpdEditButton, {
               shinyjs::toggle("wndSpdDisplay")
               shinyjs::toggle("wndSpdEditArea")
               shinyjs::toggle("wndSpdEditButton")
               shinyjs::toggle("wndSpdSaveButton")
          })

          # Save new value for wndSpd
          observeEvent(input$wndSpdSaveButton, {
               shinyjs::toggle("wndSpdDisplay")
               shinyjs::toggle("wndSpdEditArea")
               shinyjs::toggle("wndSpdEditButton")
               shinyjs::toggle("wndSpdSaveButton")

               # Update reactive value
               values$wndSpd <- input$wndSpdNewInput
               output$wndSpd <- renderText({ paste("Yesterday's Average Wind Speed:", values$wndSpd) })
          })

          # airTemp
          observeEvent(input$airTempEditButton, {
               shinyjs::toggle("airTempDisplay")
               shinyjs::toggle("airTempEditArea")
               shinyjs::toggle("airTempEditButton")
               shinyjs::toggle("airTempSaveButton")
          })

          observeEvent(input$airTempSaveButton, {
               shinyjs::toggle("airTempDisplay")
               shinyjs::toggle("airTempEditArea")
               shinyjs::toggle("airTempEditButton")
               shinyjs::toggle("airTempSaveButton")
               values$airTemp <- input$airTempNewInput
               output$airTemp <- renderText({ paste("Yesterday's Air Temperature:", values$airTemp) })
          })

          # rain
          observeEvent(input$rainEditButton, {
               shinyjs::toggle("rainDisplay")
               shinyjs::toggle("rainEditArea")
               shinyjs::toggle("rainEditButton")
               shinyjs::toggle("rainSaveButton")
          })

          observeEvent(input$rainSaveButton, {
               shinyjs::toggle("rainDisplay")
               shinyjs::toggle("rainEditArea")
               shinyjs::toggle("rainEditButton")
               shinyjs::toggle("rainSaveButton")
               values$rain <- input$rainNewInput
               output$rain <- renderText({ paste("Yesterday's Rainfall:", values$rain) })
          })

     })
}