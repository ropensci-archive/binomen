#' Get hierarchy as a data.frame
#'
#' @export
#'
#' @param x An object of class taxon
#' @examples \dontrun{
#' (out <- taxon(genus="Poa", epithet="annua", authority="L.",
#'              family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua'))
#' # get hierarchy as data.frame
#' gethier(out)
#' }

gethier <- function(x){
  tmp <- x$grouping
  nn <- names(tmp)
  vals <- unname(pluck(tmp, "name", "character"))
  data.frame(rank=nn, name=vals, stringsAsFactors = FALSE)
}
