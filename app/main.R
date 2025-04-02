# app/main.R
box::use(
  shiny[a, div, h1, icon, moduleServer, NS, span, tags],
  shiny.fluent[fluentPage, Stack, Text],
  shiny.router[router_ui, router_server, route, route_link],
  shinyjs[useShinyjs],
)

box::use(
  app/view/datatable,
  app/view/toggle,
  app/view/plot,
  app/view/niagara, # NOTE: RENAME REPURPOSED FILE TO documentation.R
  app/view/bnlearn,
  app/static/homebody,
  app/static/masthead[mastheadNav],
)

#' @export
ui <- function(id){
  ns <- NS(id)
  useShinyjs()
  
  fluentPage(
    mastheadNav,
    router_ui(
      route("/", homebody$ui(ns("home"))),
      route("niagara", bnlearn$ui(ns("Niagara"))),
      route("toronto", bnlearn$ui(ns("Toronto"))),
      route("vancouver", bnlearn$ui(ns("Vancouver"))),
      route("winnipeg", bnlearn$ui(ns("Winnipeg"))),
      route("documentation", niagara$ui(ns("Documentation")))
    )
  )
}

#' @export
server <- function(id){
  moduleServer(id, function(input, output, session) {
    router_server("/")

    bnlearn$server("Niagara")
    bnlearn$server("Toronto")
    bnlearn$server("Vancouver")
    bnlearn$server("Winnipeg")
    niagara$server("Documentation")
  })
}