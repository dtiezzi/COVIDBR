#' Plot COVID19 new cases
#'
#' The function creates line chart displaying the number of new COVID19 cases (7-days mean incidence) in Brazil
#' @return A line chart with covid19 incidence in function of time

#' @param x a data frame with COVID19 information from load.covid()
#' @param ibge a data frame (default = NA, all Brazil data) from ibge.id()
#' @param top5 boolean (default = FALSE). True if id == NA. If True, displays the top5 states in total number of cases
#'

#' @importFrom ggplot2 ggplot geom_line geom_bar theme_minimal ylab ggtitle aes scale_colour_viridis_d scale_colour_brewer
#' @export

#' @examples
#' covid <- load.covid()
#' ibge <- load.ibgeinfo()
#' myid <- ibge.id(ibge, 'SP')
#' mychart <- plot.covid.newcases(covid, myid)
#'

view.covid.newcases <- function(x, ibge = NA, top5 = FALSE) {
  if (top5) {
    dt <- subset(x, x$date == max(x$date) & x$id < 100)
    t5 <- dt[order(dt$sumcases, decreasing = TRUE), ][2:6, 1]
    df <- subset(x, x$id %in% t5)
    ibgetmp <- load.ibgeinfo()
    sts <- ibgetmp$name[ibgetmp$id %in% t5]
    print(sts)
    df$id <- as.factor(df$id)
    tit = 'COVID19 - New Cases per day - Top 8 States in Brazil'
    p <- ggplot(data = df, aes(x = date, y = newav, color = id)) + geom_line(size = 1.1) + ylab("Total number") + ggtitle(tit) + theme_minimal() + scale_colour_viridis_d('State', labels = sts, option = "plasma")
    return(p)
  } else if (nrow(ibge) == 0) {
    df <- subset(x, x$id == 76)
    tit = 'COVID19 - New Cases per day - Brazil'
  } else {
    df <- subset(x, x$id == ibge$id[1])
    tit = paste('COVID19 - New Cases per day -', ibge$name[1], sep = ' ')
  }
  p <- ggplot(data = df) + geom_bar(aes(x = date, y = newcases), stat="identity", fill="#5ab4ac", colour="#0a0a0a") + geom_line(aes(x = date, y = newav), colour = 'red', size = 2) + ylab("Total number") + ggtitle(tit) + theme_minimal()
  return(p)
}