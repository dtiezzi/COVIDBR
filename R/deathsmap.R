#' Brazil COVID19  map - deaths
#'
#' The function creates a interactive map displaying the total number number of COVID19 deaths in Brazil
#' @return A plotly map from Brazil with covid19 deaths per state

#' @param x a data frame with COVID19 information from load.covid()
#' @param perhab boolean (default = FALSE). True displays the number of deaths per million people.
#'

#' @importFrom plotly plot_ly add_trace colorbar layout
#' @importFrom magrittr %>%
#' @importFrom utils data
#' @export

#' @examples
#' covid <- load.covidBr()
#' mymap <- view.deaths.map(covid)
#'

view.deaths.map <- function(x, perhab = FALSE) {
  brgeojson <- covidBR::brgeojson
  ibge <- covidBR::ibge
  df <- subset(x, x$date == max(x$date) & x$id < 76)
  df <- merge(df, ibge, by = 'id')
  if (perhab) {
    df$sumdeaths <- round((df$sumdeaths * 1000000) / df$population,1)
    cbtit = 'Deaths/1M'
    figtit = paste("COVID19 - Deaths per Million in Brazil (", max(df$date), ")", sep = '')
  } else {
    cbtit = 'Total deaths'
    figtit = paste("COVID19 - Number of deaths in Brazil (", max(df$date), ")", sep = '')
  }
  fig <- plot_ly()
  fig <- fig %>% add_trace(
    type="choroplethmapbox",
    geojson=brgeojson,
    locations=df$uf,
    z=df$sumdeaths,
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

