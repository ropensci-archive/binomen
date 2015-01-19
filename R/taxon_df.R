#' Taxon data.frame
#'
#' BEWARE: doesn't work yet
#'
#' @export
#'
#' @param x A data.frame of taxa
#' @examples \dontrun{
#' # subset data.frame using taxonomy
#' df <- data.frame(family=c('Asteraceae','Asteraceae','Asteraceae','Poaceae','Poaceae','Poaceae'),
#'                  tribe=c('Helianthi','Helianthi','Helianthi','Poaeae','Festuci','Poaeae'),
#'                  genus=c('Helianthus','Helianthus','Madia','Poa','Festuca','Holodiscus'),
#'                  stringsAsFactors = FALSE)
#' df2 <- taxon_df(df)
#' df2 %>% select(family, Asteraceae)
#' df2 %>% select(genus, Madia)
#' df2 %>% select(tribe, Helianthi)
#' }

taxon_df <- function(x){
  structure(x, class=c('taxonDataFrame','data.frame'))
}

# setClass("taxonDataFrame", slots = c(data = 'data.frame'))
# setMethod("[", "taxonDataFrame", function(x, i, j, ...){
#   tmp <- x@data
#   tmp[ tmp[[i]] %in% j, ]
# })
