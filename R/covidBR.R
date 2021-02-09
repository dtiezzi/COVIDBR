#' \code{covidBR} package
#'
#' COVID19 Brazil R API
#'
#' See the README on
#' \href{https://github.com/dtiezzi/COVIDBR#readme}{GitHub}
#'
#' @docType package
#' @name covidBR
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c('deathav', 'id', 'newdeaths', 'newav', 'id', 'newcases'))
