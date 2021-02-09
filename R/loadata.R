#' Load COVID19 data
#'
#' The function downloads the updated COVID19 information from Brazil
#' @return A data frame with covid19 information

#' @importFrom utils read.csv download.file
#' @export

#' @examples
#' covid <- load.covid()
#' head(covid)


load.covidBr <- function() {
  download.file('http://200.144.244.198:5000/get-csv/db_BR_updated_data.csv', './cov')
  tmp <- read.csv('cov')
  tmp <- tmp[, -1]
  tmp$date <- as.Date(tmp$date, format = "%Y-%m-%d")
  tmp <- tmp[order(tmp$id, tmp$date), ]
  rownames(tmp) <- seq(1:nrow(tmp))
  return(tmp)
}
