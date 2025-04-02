#app/view/landing
box::use(
  shiny.fluent[fluentPage]
)

box::use(
  app/static/masthead[mastheadNav],
  app/static/homebody[homeBody]
)

#' @export
landing_page <- fluentPage(
  mastheadNav,
  homeBody
)