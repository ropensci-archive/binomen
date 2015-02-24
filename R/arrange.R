#' Arrange taxon or taxondf objects by one or more choices
#'
#' @import lazyeval
#' @export
#' @param .data Input, object of class taxon
#' @param ... Further unnamed args, see examples
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
#' ## arrange the taxonomic data.frame
#' df2 %>% arrange(order)
#' df2 %>% arrange(family)
#' df2 %>% arrange(genus)
#' df2 %>% arrange(genus, order)
arrange <- function(.data, ...) {
  arrange_(.data, .dots = lazyeval::lazy_dots(...))
}

#' @export
arrange_ <- function(.data, ..., .dots) {
  UseMethod("arrange_")
}

#' @export
arrange_.taxondf <- function(.data, ..., .dots) {
  dots <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
  as.data.frame(arrange_impl(.data, dots))
#   var <- vars(...)
#   if(length(var) > 2) stop("Pass in only two rank names", call. = FALSE)
#   check_vars(var, names(.data))
#   matches <- sapply(var, grep, x=names(.data))
#   .data[fill_nums(matches)]
}

arrange_impl <- function (data, dots) {
  .Call("dplyr_arrange_impl", PACKAGE = "dplyr", data, dots)
}
