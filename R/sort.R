#' Sort taxon or taxondf objects by one or more choices
#'
#' @import lazyeval
#' @export
#' @param .data Input, object of class taxon
#' @param ... Comma separated list of unquoted expressions. You can treat variable names
#' like they are positions. Use positive values to select variables; use negative values
#' to drop variables.
#' @param .dots Use sort_() to do standard evaluation
#' @examples
#' # operating on taxonomic data.frames
#' df <- data.frame(class=c('Magnoliopsida','Magnoliopsida','Magnoliopsida',
#'                          'Magnoliopsida','Magnoliopsida','Magnoliopsida'),
#'          order=c('Asterales','Asterales','Fagales','Poales','Poales','Poales'),
#'          family=c('Asteraceae','Asteraceae','Fagaceae','Poaceae','Poaceae','Poaceae'),
#'          genus=c('Helianthus','Helianthus','Quercus','Poa','Festuca','Holodiscus'),
#'          stringsAsFactors = FALSE)
#' (df2 <- taxon_df(df))
#'
#' ## sort the taxonomic data.frame
#' df2 %>% sort(order)
#' df2 %>% sort(family)
#' df2 %>% sort(genus)
#' df2 %>% sort(genus, order)
sort <- function(.data, ...) {
  sort_(.data, .dots = lazyeval::lazy_dots(...))
}

#' @export
#' @rdname sort
sort_ <- function(.data, ..., .dots) {
  UseMethod("sort_")
}

#' @export
#' @rdname sort
sort_.taxondf <- function(.data, ..., .dots) {
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  as.data.frame(arrange_impl(.data, dots))
}

arrange_impl <- function (data, dots) {
  .Call("dplyr_arrange_impl", PACKAGE = "dplyr", data, dots)
}
