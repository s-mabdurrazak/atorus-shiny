# Masthead HTML structure
mastheadNav <- tags$html(
     tags$head(
          tags$title(
               "Workarea"
          ),
          tags$link(
               rel = "stylesheet",
               href = "https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          ),
          tags$link(
               rel = "stylesheet",
               href = "stylesheet.css"
          )
     ),
     tags$header(
     id = "masthead",
     div(class = "container",
         div(class = "row justify-content-between align-items-center",
             div(class = "col-12 col-md-6",
                 img(src = "tmu-logo.png", width = "150", height = "50"),
                 h1("Landing Page Reprex")),
             div(class = "col-12 col-md-3 text-right",
                 a(href = "/", class = "text-link", "Return Home"),
                 a(href = "/documentation", class = "btn btn-outline-light", "Read Documentation")))
     )
)
)