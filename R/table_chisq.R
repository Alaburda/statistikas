
test_data <- data.frame(var1 = c(rep("A",5),rep("B",5)),
           var2 = c(rep("A",5),rep("B",5)),
           var3 = c(rep("A",7),rep("B",3)),
           var4 = c(rep("A",1),rep("B",9)))

#' Title
#'
#' @param data
#' @param x
#' @param y
#'
#' @return
#' @example table_chisq(test_data, "var1", c("var2","var3","var4"))
#'
#' @examples

table_chisq <- function(data, x, y) {

  tidy_chisq <- function(data, x, y) {
    out <- chisq.test(table(data[[x]],data[[y]])) %>%
      broom::tidy() %>%
      transmute(Kintamasis = y,
                `Chi-kvadrato reikšmė` = statistic,
                lls = parameter,
                `p reikšmė` = scales::pvalue(p.value, decimal.mark = ","))

    return(out)
  }


  out <- purrr::map2_df(x, y, ~tidy_chisq(data = data, x = .x, y = .y))

  return(out)

}


