plot_proportions <- function(data, x, by) {

  out <- data %>%
    mutate({{ x }} := as.factor({{ x }})) %>%
    count({{ x }}, {{ by }}) %>%
    ggplot(aes(x = {{ x }}, fill = {{ by }}, weight = n, by = {{ x }})) +
    geom_bar(position = "fill") +
    geom_text(stat = "prop", position = position_fill(.5), aes(family = "serif")) +
    ggplot2::theme_classic() +
    theme(text = element_text(family="serif"),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12))

  return(out)


}
