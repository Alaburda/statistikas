#' Title
#'
#' @param data
#' @param x
#' @param fill
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom ggplot2 ggplot aes theme

plot_proportions <- function(data, x, fill, labels, ylab = "Procentinė dalis") {

  var_x <- names(dplyr::select(data, {{ x }}))
  var_fill <- names(dplyr::select(data, {{ fill }}))

  out <- data %>%
    filter(!is.na({{ x }})) %>%
    mutate({{ x }} := as.factor({{ x }})) %>%
    count({{ x }}, {{ fill }}) %>%
    ggplot(aes(x = {{ x }}, fill = {{ fill }}, weight = n, by = {{ x }})) +
    geom_bar(position = "fill") +
    geom_text(stat = "prop", position = position_fill(.5), aes(family = "serif")) +
    ggplot2::theme_classic() +
    theme(text = element_text(family="serif"),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12)) +
    labs(x = labels[[var_x]],
         fill = labels[[var_fill]],
         y = ylab)

  return(out)


}
