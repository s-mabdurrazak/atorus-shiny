#app/static/masthead

box::use(
  shiny[a, div, h1, img, tags],
)

#' @export
mastheadNav <- tags$html(
  tags$head(
    tags$title(
      "Atorus Shiny Demo"
    ),
    tags$link(
      rel = "stylesheet",
      href = "https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
    ),
    tags$link(
      rel = "stylesheet",
      href = "main.scss"
    ),
    tags$link(
      rel="stylesheet",
      type="text/css",
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    )
  ),
  tags$header(
    id = "masthead",
    div(class = "container",
        div(class = "row justify-content-between align-items-center",
            div(style = "display: flex; align-items: center; gap: 1rem;",
                a(href ="/",
                  img(src = "static/images/bacterium.png", width = "75", height = "75", style = "cursor: pointer;")
                ),
                h1("E. coli Weather Effects Probability", style = "margin: 0")),
            div(class = "col-12 col-md-3 text-right",
                a(href = "#!/documentation", class = "btn btn-outline-light", "Documentation")))
    )
  )
)