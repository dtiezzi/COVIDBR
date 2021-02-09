#' Load IBGE data
#'
#' The function downloads IBGE information from Brazil
#' @return A sorted data frame with IBGE codes, location names and and estimated population
#'

#' @importFrom utils read.csv download.file
#' @export

#' @examples
#' ibge <- load.ibgeinfo()

load.ibgeinfo <- function() {
  download.file('http://200.144.244.198:5000/get-csv/db_ids.csv', './ibge')
  tmp <- read.csv('ibge')
  tmp <- tmp[, -1]
  tmp <- tmp[order(tmp$id, tmp$population), ]
  rownames(tmp) <- seq(1:nrow(tmp))
  return(tmp)
}
