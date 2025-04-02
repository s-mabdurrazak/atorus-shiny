#app/static/homebody

box::use(
  shiny[a, div, h2, h3, HTML, moduleServer, NS,  span],
  shiny.fluent[Stack, Text, DefaultButton],
  shiny.router[change_page, route_link]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  div(
    id = "homebody",
    class = "container",
    div(class = "row",
        div(class = "col-12",
            h2(class = "section-title", "Choose Your Region")
        )
    ),
    div(class = "row",
        div(class = "col-12 col-md-3",
            a(class = "card-page-link", href = route_link("toronto"),
              div(class = "card",
                  h3("Toronto"),
                  div(class = "card-bg-image-toronto")
                  # span(class = "arrow-btn", "Go to Toronto")
              )
            )
        ),
        div(class = "col-12 col-md-3",
            a(class = "card-page-link", href = route_link("niagara"),
              div(class = "card",
                  h3("Niagara"),
                  div(class = "card-bg-image-niagara")
                  #span(class = "arrow-btn", "Go to Niagara")
              )
            )
        ),
        div(class = "col-12 col-md-3",
            a(class = "card-page-link", href = route_link("vancouver"),
              div(class = "card",
                  h3("Vancouver"),
                  div(class = "card-bg-image-vancouver")
                  #span(class = "arrow-btn", "Go to Vancouver")
              )
            )
        ),
        div(class = "col-12 col-md-3",
            a(class = "card-page-link", href = route_link("winnipeg"),
              div(class = "card",
                  h3("Winnipeg"),
                  div(class = "card-bg-image-winnipeg")
                  #span(class = "arrow-btn", "Go to Winnipeg")
              )
            )
        )
    )
  )
}


