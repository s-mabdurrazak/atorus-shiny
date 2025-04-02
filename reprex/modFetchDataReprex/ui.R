# ui.R
# modFetchDataReprex

## Define the UI
ui <- fluidPage(
     useShinyjs(),
     router_ui(
          route("/", landing_page),
          route("toronto", page_ui("Toronto")),
          route("niagara", page_ui("Niagara")),
          route("vancouver", page_ui("Vancouver")),
          route("winnipeg", page_ui("Winnipeg"))
     )
)
