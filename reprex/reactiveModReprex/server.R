server <- function(input, output, session) {
     router_server()

     # Initialize Toronto and Niagara module server logic
     page_server("Toronto")
     page_server("Niagara")
}
