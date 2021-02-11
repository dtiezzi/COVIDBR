#' Plot COVID19 deaths
#'
#' The function creates line chart displaying the number of COVID19 deaths (7-days mean) in Brazil
#' @return A line chart with covid19 deaths in function of time

#' @param x a data frame with COVID19 information from load.covid()
#' @param ibgeinfo a data frame (default = NA, all Brazil data) from ibge.id()
#' @param top5 boolean (default = FALSE). True if id == NA. If True, displays the top5 states in total number of cases
#'

#' @importFrom ggplot2 ggplot geom_line geom_bar theme_minimal ylab ggtitle aes scale_colour_viridis_d
#' @importFrom utils data
#' @export

#' @examples
#' covid <- load.covidBr()
#' myid <- ibge.id('SP')
#' mychart <- view.covid.deaths(covid, myid)
#'

view.covid.deaths <- function(x, ibgeinfo = NA, top5 = FALSE) {
  if (top5) {
    dt <- subset(x, x$date == max(x$date) & x$id < 76)
    t5 <- dt[order(dt$sumcases, decreasing = TRUE), ][1:5, 1]
    df <- subset(x, x$id %in% t5)
    ibge <- covidBR::ibge
    sts <- ibge[ibge$id %in% t5, c(2,3)]
    rownames(sts) <- sts$id
    df$id <- as.factor(df$id)
    sts <- sts[levels(df$id), ]
    tit = 'COVID19 - New Cases per day - Top 5 States in Brazil'
    p <- ggplot(data = df, aes(x = date, y = deathav, color = id)) + geom_line(size = 1.27) + ylab("Total number") + ggtitle(tit) + theme_minimal() + scale_colour_viridis_d('state', labels = sts, option = "plasma")
    return(p)
  } else if (is.na(ibgeinfo)) {
    df <- subset(x, x$id == 76)
    tit = 'COVID19 - Deaths per day - Brazil'
  } else {
    df <- subset(x, x$id == ibgeinfo$id[1])
    tit = paste('COVID19 - Deaths per day -', ibgeinfo$name[1], sep = ' ')
  }
  p <- ggplot(data = df) + geom_bar(aes(x = date, y = newdeaths), stat="identity", fill="#5ab4ac", colour="#0a0a0a") + geom_line(aes(x = date, y = deathav), colour = 'red', size = 2) + ylab("Total number") + ggtitle(tit) + theme_minimal()
  return(p)
}
