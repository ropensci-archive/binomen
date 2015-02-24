#' Parse taxon or taxondf objects by a range of names
#'
#' @export
#' @param .data Input, object of class taxon
#' @param ... Further unnamed args, see examples
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' out %>% span(kingdom, genus)
#'
#' # operating on taxonomic data.frames
#' df <- data.frame(class=c('Magnoliopsida','Magnoliopsida','Magnoliopsida',
#'                          'Magnoliopsida','Magnoliopsida','Magnoliopsida'),
#'          order=c('Asterales','Asterales','Fagales','Poales','Poales','Poales'),
#'          family=c('Asteraceae','Asteraceae','Fagaceae','Poaceae','Poaceae','Poaceae'),
#'          genus=c('Helianthus','Helianthus','Quercus','Poa','Festuca','Holodiscus'),
#'          stringsAsFactors = FALSE)
#' (df2 <- taxon_df(df))
#'
#' ## filter to get a range of classes
#' df2 %>% span(order, genus)
#' df2 %>% span(family, genus)
span <- function(.data, ...) {
  UseMethod("span")
}

#' @export
span.taxon <- function(.data, ...) {
  tmp <- .data$classification
  var <- vars(...)
  if(length(var) > 2) stop("Pass in only two rank names", call. = FALSE)
  check_vars(var, names(tmp))
  matches <- sapply(var, grep, x=names(tmp))
  tmp[fill_nums(matches)]
}

#' @export
span.taxondf <- function(.data, ...) {
  var <- vars(...)
  if(length(var) > 2) stop("Pass in only two rank names", call. = FALSE)
  check_vars(var, names(.data))
  matches <- sapply(var, grep, x=names(.data))
  .data[fill_nums(matches)]
}
