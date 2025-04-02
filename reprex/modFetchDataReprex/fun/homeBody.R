# Home body with cards for Toronto, Niagara, Vancouver, and Winnepeg
# modFetchDataReprex

homeBody <- div(
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
                   span(class = "arrow-btn", "Go to Toronto")
               )
             )
         ),
         div(class = "col-12 col-md-3",
             a(class = "card-page-link", href = route_link("niagara"),
               div(class = "card",
                   h3("Niagara"),
                   span(class = "arrow-btn", "Go to Niagara")
               )
             )
         ),
         div(class = "col-12 col-md-3",
             a(class = "card-page-link", href = route_link("vancouver"),
               div(class = "card",
                   h3("Vancouver"),
                   span(class = "arrow-btn", "Go to Vancouver")
               )
             )
         ),
         div(class = "col-12 col-md-3",
             a(class = "card-page-link", href = route_link("winnipeg"),
               div(class = "card",
                   h3("Winnipeg"),
                   span(class = "arrow-btn", "Go to Winnipeg")
               )
             )
         )
     )
)