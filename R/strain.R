#' Parse taxon or taxondf objects by a range of names
#'
#' @export
#' @param .data Input, object of class taxon
#' @param ... Logical predicates. Multiple conditions are combined with &.
#' See Details.
#' @return A single or list of \code{taxon} class objects
#' @details Example predicates:
#' \itemize{
#'  \item . > family = Get all taxa greater than family
#'  \item . < family = Get all taxa less than family
#'  \item . == family = Get all taxa equal to family
#'  \item . != family = Get all taxa not equal to family
#'  \item genus < order = Get all taxa between genus and order
#'  \item genus .. family = Get all taxa between genus and order
#' }
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' out %>% va_rs(. < genus)
#'
#' # operating on taxonomic data.frames
#' df <- data.frame(class=c('Magnoliopsida','Magnoliopsida','Magnoliopsida',
#'                          'Magnoliopsida','Magnoliopsida','Magnoliopsida'),
#'          order=c('Asterales','Asterales','Fagales','Poales','Poales','Poales'),
#'          family=c('Asteraceae','Asteraceae','Fagaceae','Poaceae','Poaceae','Poaceae'),
#'          genus=c('Helianthus','Helianthus','Quercus','Poa','Festuca','Holodiscus'),
#'          stringsAsFactors = FALSE)
#' (df2 <- taxon_df(df))
strain <- function(.data, ...) {
  UseMethod("strain")
}

#' @export
strain.taxon <- function(.data, ...) {
  va_rs(.data, .dots = lazyeval::lazy_dots(...))
  # taxonparse(.data, var)
}

va_rs <- function(.data, ...) {
  va_rs_(.data, .dots = lazyeval::lazy_dots(...))
  # taxonparse(.data, var)
}

va_rs_ <- function(.data, ..., .dots) {
  tmp <- lazyeval::all_dots(.dots, ...)
  taxonparse(w = .data, vars = tmp)
}

#' @export
strain.taxa <- function(.data, ...) {
  lapply(.data, span, ...)
}

#' @export
strain.taxondf <- function(.data, ...) {
  var <- vars(...)
  check_vars(var, names(.data))
  matches <- sapply(var, grep, x = names(.data))
  .data[fill_nums(matches)]
}

taxonparse <- function(w, vars){
  tmp <- w$grouping
  vars2 <- make_vars(vars)
  matches <- sapply(vars, grep, x = names(tmp))
  w$grouping <- do.call("grouping", tmp[fill_nums(matches)])
  return(w)
}

make_vars <- function(x) {
  lapply(x, function(z) {
    as.list(setNames(strsplit(deparse(z$expr), "\\s+")[[1]],
             c('lower', 'operator', 'upper')))
  })
}


# poss_ranks <- unique(do.call(c, sapply(rank_ref$ranks, strsplit, split=",", USE.NAMES = FALSE)))
# downto <- match.arg(downto, choices = poss_ranks)
# torank <- sapply(rank_ref[grep(downto, rank_ref$ranks),"ranks"],
#                  function(x) strsplit(x, ",")[[1]][[1]], USE.NAMES=FALSE)
