server <- function(input, output, session) {
     router_server()

     # Initialize Toronto and Niagara module server logic
     toronto_server("toronto_module")
     niagara_server("niagara_module")
}
