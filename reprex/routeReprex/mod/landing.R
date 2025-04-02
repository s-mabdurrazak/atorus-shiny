# Define the landing page UI
landing_page <- fluidPage(
     titlePanel("Landing Page"),
     div(
          h1("Welcome to Our Shiny App"),
          tags$a(href = route_link("toronto"), tags$button("Go to Toronto", type = "button", class = "btn btn-primary")),
          tags$a(href = route_link("niagara"), tags$button("Go to Niagara", type = "button", class = "btn btn-success"))

     )
)
