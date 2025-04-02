# ui.R

## Define the UI
ui <- fluidPage(
     router_ui(
          route("/", landing_page),
          route("toronto", page_ui("Toronto")),
          route("niagara", page_ui("Niagara"))
     )
)
