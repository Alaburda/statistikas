#' Plot count data as
#'
#' @param data a dataframe
#' @param x categorical variable to count
#' @param fill
#' @param xlab
#' @param ylab
#' @param bylab
#' @param nlab
#' @param flip
#'
#' @return
#' @export
#'
#' @examples

plot_counts <- function(data,
                        x,
                        by,
                        xlab = "",
                        ylab = "",
                        bylab = "",
                        nlab = "",
                        flip = FALSE) {

  out <- data %>%
    group_by({{ x }}, {{ fill }}, .drop = FALSE) %>%
    summarise(Count = n()) %>%
    ggplot2::ggplot(ggplot2::aes(x = {{ x }}, y = Count, fill = {{ fill }}, label = Count)) +
    ggplot2::geom_bar(stat = "identity", color = "black", position = position_dodge2(preserve = "single")) +
    ggplot2::theme(text = element_text(size = 18)) +
    ggplot2::labs(x = xlab, y = ylab, fill = bylab) +
    ggplot2::theme_classic() +
    theme(text = element_text(family="serif"),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12))

  if (flip == FALSE) {
    out <- out + geom_text(colour = "black",
                       family = "serif",
                       size = 4.5,
                       position = position_dodge(width = 0.9),
                       vjust = -0.4)
    return(out)
  } else {
    out <- out + coord_flip() + geom_text(colour = "black",
                                      family = "serif",
                                      size = 4.5,
                                      position = position_dodge(width = 0.9),
                                      hjust = -0.4)
    return(out)
  }

}
