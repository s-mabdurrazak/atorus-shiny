# app/view/toggle.R

box::use(
  dplyr[filter],
  shiny[div, moduleServer, NS, reactive],
  shiny.fluent[Text, Toggle.shinyInput, fluentSalesDeals],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    class = "ms-depth-4",
    Toggle.shinyInput(ns("includeOpen"), label = "Include non affiliated")
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    filtered_deals <- reactive({
      fluentSalesDeals |> filter(
        is_closed | input$includeOpen
      )
    })
    return(filtered_deals)
  })
}