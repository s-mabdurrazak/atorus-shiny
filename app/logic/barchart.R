# app/logic/barchart.R

box::use(
  ggplot2[aes, element_text, geom_bar, ggplot, labs, theme, theme_light],
)

#' @export
generate_barchart <- function(filtered_data) {
  ggplot(filtered_data, aes(x = rep_name, y = deal_amount, fill = rep_name)) +
    geom_bar(stat = "identity") +
    labs(x = "Scientist Group Study", y = "Collection Amount", fill ="Lab") +
    theme_light() +
    theme(axis.text.x = element_text(angle = 60, hjust = 1))
}