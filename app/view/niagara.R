# app/view/niagara.R
box::use(
  shiny[a, div, h1, h2, icon, moduleServer, NS, span, tags],
  shiny.fluent[fluentPage, Stack, Text],
  shiny.router[router_ui, router_server, route, route_link],
)

box::use(
  app/view/datatable,
  app/view/toggle,
  app/view/plot,
  app/static/masthead[mastheadNav]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    fluentPage(
      div(id ="documentPage",
          class = "documentDiv",
        div(
          tags$h1("Welcome to the E. coli Weather Effects Probability Dashboard"),
          tags$p("This interactive dashboard provides historical data and predictive models for beach water quality across the Niagara region. Utilize this tool to explore trends, patterns, and forecasts that can help in making informed decisions about water safety and quality."),
          tags$p("Features of this dashboard include:"),
          tags$ul(
            tags$li("Historical Water Quality Data: Visualize the historical E. coli concentrations and other environmental data collected from various beaches."),
            tags$li("Predictive Models: Access predictive models that estimate the probability of water quality guidelines being exceeded, based on environmental factors."),
            tags$li("Customizable Visualizations: Interact with the data by selecting different parameters to customize the visualizations according to your needs.")
          ),
          tags$p("To get started:"),
          tags$ol(
            tags$li("Use the sidebar to navigate between different sections of the dashboard."),
            tags$li("Select 'Niagara' to view data visualizations or predictive models specific to the Niagara region."),
            tags$li("Interact with the visualizations by choosing different beaches, date ranges, or environmental parameters."),
            tags$li("Utilize the predictive models by inputting today's environmental data to receive forecasts on water quality.")
          ),
          tags$p("Please note that the data available ranges from 2011 to 2019, providing a comprehensive overview of the water quality during this period."),
          tags$p("If you have any questions or require further assistance, please refer to the help section or contact the support team.")
        ),
        div(class ="documentDiv",
          Text("Public Science List", variant = "xxLarge"),
          Text("All data submissions from the public science sector", variant = "large"),
          toggle$ui(ns("toggle")),
          Stack(
            horizontal = TRUE,
            tokens = list(padding = 20, childrenGap = 10),
            span(class = "ms-depth-8", datatable$ui(ns("datatable"))),
            span(class = "ms-depth-8", plot$ui(ns("plot")))
          )
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <-toggle$server("toggle")
    datatable$server("datatable", data)
    plot$server("plot", data)
  })
}