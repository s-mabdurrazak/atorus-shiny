page_ui <- function(id) {
     ns <- NS(id)
     tagList(
          mastheadNav,
          h2(paste(id, "Dashboard")),
          div(class ="container",
              div(class = "row",
                  # Left column
                  div(class = "col-6",
                      div(class = "card",
                          h3("Card Element Placeholder")
                      ),
                      # Fetched Data
                      div(class = "fetched-data",
                          # Conditionally include components based on region
                          if (id %in% c("Toronto", "Niagara", "Winnipeg", "Vancouver")) uvIndexUI(ns),
                          if (id %in% c("Toronto", "Niagara")) wndSpdUI(ns),
                          if (id %in% c("Toronto", "Niagara", "Winnipeg", "Vancouver")) airTempUI(ns),
                          if (id %in% c("Toronto", "Niagara", "Winnipeg", "Vancouver")) rainUI(ns)
                      )
                  ),
                  # Right column
                  div(class = "col-6",
                      # Environmental Data inputs based on the region
                      div(class = "environmental-data",
                          tags$h4("Environmental Data:"),
                          # Include region-specific dropdown values
                          if (id == "Toronto") torontoDropInputsUI(ns),
                          if (id == "Niagara") niagaraDropInputsUI(ns),
                          if (id == "Winnipeg") winnipegDropInputsUI(ns),
                          if (id == "Vancouver") vancouverDropInputsUI(ns),

                          bs4Dash::actionButton(ns("fetchDataBtn"), "Fetch Data"),
                          actionButton(ns("predictBtn"), "Predict")
                      )
                  )
              )
          )
     )
}
