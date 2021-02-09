#' Find IBGE code
#'
#' The function returns the IBGE code based on state (ex: 'SP', 'MG' ...) or the city name (ex: 'Rio de Janeiro', São Paulo'...)
#' @return A single line data frame with IBGE code, location name and the estimated population

#' @param x ibge data frame
#' @param location string (state or city/county name)
#'
#' @export

#' @examples
#' ibge <- load.ibgeinfo()
#' myId <- ibge.id(ibge, location = 'SP')
#'

ibge.id <- function(x, location) {
  tmp <- subset(x, x$name == location, -4)
  return(tmp)
}
