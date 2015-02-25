#' Taxon data.frame
#'
#' @export
#' @param x A data.frame of taxa
#' @examples
#' # subset data.frame using taxonomy
#' df <- data.frame(family=c('Asteraceae','Asteraceae','Asteraceae','Poaceae','Poaceae','Poaceae'),
#'                  tribe=c('Helianthi','Helianthi','Helianthi','Poaeae','Festuci','Poaeae'),
#'                  genus=c('Helianthus','Helianthus','Madia','Poa','Festuca','Holodiscus'),
#'                  stringsAsFactors = FALSE)
#' df2 <- taxon_df(df)
#' df2 %>% pick(family, Asteraceae)
#' df2 %>% pick(genus, Madia)
#' df2 %>% pick(tribe, Helianthi)

taxon_df <- function(x){
  structure(x, class=c('taxondf','data.frame'))
}

# setClass("taxonDataFrame", slots = c(data = 'data.frame'))
# setMethod("[", "taxonDataFrame", function(x, i, j, ...){
#   tmp <- x@data
#   tmp[ tmp[[i]] %in% j, ]
# })
