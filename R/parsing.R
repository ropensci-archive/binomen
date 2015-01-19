#' Select, parse, etc. taxanomic names
#'
#' @name parsing
#' @import magrittr
#'
#' @param .data Input, object of class taxon
#' @param ... Further unnamed args, see examples
#' @examples
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' # get single name
#' out %>% select(family)
#' out %>% select(genus)
#' out %>% select(species)
#' out %>% select(species) %>% name()
#' out %>% select(species) %>% uri()
#' # get range of names
#' out %>% range(kingdom, genus)
#'
#' @examples \dontrun{
#' out %>% range(kingdom, adfadf)
#' }

#' @export
#' @rdname parsing
select <- function(.data, ...){
  tmp <- .data$classification
  name <- vars(...)
  tmp[[name]]
}

#' @export
#' @rdname parsing
range <- function(.data, ...){
  tmp <- .data$classification
  var <- vars(...)
  if(length(var) > 2) stop("Pass in only two rank names", call. = FALSE)
  check_vars(var, names(tmp))
  matches <- sapply(var, grep, x=names(tmp))
  tmp[fill_nums(matches)]
}

#' @export
#' @rdname parsing
name <- function(.data) .data$name

#' @export
#' @rdname parsing
uri <- function(.data) .data$uri

fill_nums <- function(x) seq(from=min(x), to=max(x), by=1)

vars <- function(...) as.character(dots(...))

dots <- function(...){
  eval(substitute(alist(...)))
}

check_vars <- function(x, y){
  if( !all(x %in% y) ) stop(sprintf("%s not a valid taxonomic rank", paste0(x[!x %in% y], collapse = ", ")), call. = FALSE)
}
