#' Convert to JSON-LD
#'
#' @export
#' @param input Input object
#' @examples \dontrun{
#' out <- taxon(genus="Poa", epithet="annua", authority="L.")
#' x <- new("taxonref", rank="species", name="Homo sapiens", id=3454, uri="http://things.com")
#' as.jsonld(x)
#' }

as.jsonld <- function(input, ...){
  jsonlite::toJSON(input, auto_unbox = TRUE, ...)
}
