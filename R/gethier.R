#' Get hierarchy as a data.frame
#'
#' @export
#' @param x An object of class taxon
#' @examples
#' bin <- binomial("Poa", "annua", authority="L.")
#' class <- grouping(kingdom=taxonref("kingdom", "Plantae"),
#'    species=taxonref("family", "Poaceae"))
#' out <- taxon(bin, class)
#' # get hierarchy as data.frame
#' gethier(out)

gethier <- function(x) {
  UseMethod("gethier")
}

#' @export
gethier.grouping <- function(x) {
  make_df(x)
}

#' @export
gethier.taxon <- function(x) {
  make_df(x$grouping)
}

make_df <- function(x) {
  nn <- names(x)
  vals <- unname(pluck(x, "name", "character"))
  data.frame(rank = nn, name = vals, stringsAsFactors = FALSE)
}
