#' Brazil COVID19  map - new cases
#'
#' The function creates line chart displaying the number of new COVID19 cases (7-days mean incidence) in Brazil
#' @return A plotly map from Brazil with covid19 incidence per state

#' @param x a data frame with COVID19 information from load.covid()
#' @param perhab boolean (default = FALSE). True displays the incidence per 1 million people.
#'

#' @importFrom plotly plot_ly add_trace colorbar layout
#' @importFrom magrittr %>%
#' @importFrom utils data
#' @export

#' @examples
#' covid <- load.covidBr()
#' mymap <- view.cases.map(covid)
#'

view.cases.map <- function(x, perhab = FALSE) {
  brgeojson <- covidBR::brgeojson
  ibge <- covidBR::ibge
  df <- subset(x, x$date == max(x$date) & x$id < 76)
  df <- merge(df, ibge, by = 'id')
  if (perhab) {
    df$sumcases <- round((df$sumcases * 1000000) / df$population,1)
    cbtit = 'Cases/1M'
    figtit = paste("COVID19 - Cases per Million in Brazil (", max(df$date), ")", sep = '')
  } else {
    cbtit = 'Total cases'
    figtit = paste("COVID19 - Total cases in Brazil (", max(df$date), ")", sep = '')
  }
  fig <- plot_ly()
  fig <- fig %>% add_trace(
    type="choroplethmapbox",
    geojson=brgeojson,
    locations=df$uf,
    z=df$sumcases,
    colorscale="Viridis",
    featureidkey='properties.sigla',
    marker=list(line=list(
      width=0, opacity=0.5)
    )
  )
  fig <- fig %>% colorbar(title = cbtit)
  fig <- fig %>% layout(
    title = figtit,
    mapbox=list(
      style="carto-positron",
      zoom =2,
      center=list(lon= -55, lat=-14))
    )
  return(fig)
}
