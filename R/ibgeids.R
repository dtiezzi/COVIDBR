#' Find IBGE code
#'
#' The function returns the IBGE code based on state (ex: 'SP', 'MG' ...) or the city name (ex: 'Rio de Janeiro', São Paulo'...)
#' @return A single line data frame with IBGE code, location name and the estimated population

#' @param location string (state or city/county name)
#' @importFrom utils data
#' @export

#' @examples
#' myId <- ibge.id('SP')
#'

ibge.id <- function(location) {
  ibge <- covidBR::ibge
  tmp <- subset(ibge, ibge$name == location, -4)
  return(tmp)
}
