# Define the UI
ui <- fluidPage(
     router_ui(
          route("/", landing_page),
          route("toronto", toronto_ui("toronto_module")),
          route("niagara", niagara_ui("niagara_module"))
     )
)
