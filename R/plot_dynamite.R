#' @example plot_dynamite(iris, Species, Sepal.Length, bylab = "Laipsnis")

plot_dynamite <- function(data, x, by, xlab = "", ylab = "", bylab = "") {

  out <- data %>%
    group_by({{ by }}) %>%
    summarise(Vidurkis = round(mean({{ x }}, na.rm = TRUE),2),
              SD = round(sd({{ x }}, na.rm = TRUE),2)) %>%
    ggplot(aes(x = {{ by }}, y = Vidurkis, fill = {{ by }}, ymin = Vidurkis-SD, ymax = Vidurkis+SD)) +
    geom_bar(stat = "identity", color = "black") +
    theme(text = element_text(size = 18)) +
    labs(x = xlab, y = ylab, fill = bylab) +
    geom_errorbar(width = 0.2) +
    theme_classic()

  return(out)

}

