#' Taxon data.frame
#'
#' @export
#'
#' @param data A data.frame of taxa
#' @examples \dontrun{
#' # subset data.frame using taxonomy
#' df <- data.frame(family=c('Asteraceae','Asteraceae','Asteraceae','Poaceae','Poaceae','Poaceae'),
#'                  tribe=c('Helianthi','Helianthi','Helianthi','Poaeae','Festuci','Poaeae'),
#'                  genus=c('Helianthus','Helianthus','Madia','Poa','Festuca','Holodiscus'),
#'                  stringsAsFactors = FALSE)
#' df2 <- taxon_df(df)
#' df2['family','Asteraceae']
#' df2['genus','Madia']
#' df2['tribe','Helianthi']
#' }

taxon_df <- function(data) new('taxonDataFrame', data=data)

setClass("taxonDataFrame", slots = c(data = 'data.frame'))
setMethod("[", "taxonDataFrame", function(x, i, j, ...){
  tmp <- x@data
  tmp[ tmp[[i]] %in% j, ]
})
