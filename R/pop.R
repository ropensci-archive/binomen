#' Pop names out, drop them that is
#'
#' @importFrom dplyr select_
#' @export
#'
#' @param .data Input, object of class taxon
#' @param ... Further unnamed args, see examples
#' @return For \code{taxon} inputs gives back a \code{taxon} object. For \code{taxondf}
#' inputs, gives back a \code{taxondf} object.
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' ## single names
#' out %>% pop(family)
#' out %>% pop(genus)
#' out %>% pop(species)
#' ## many names
#' out %>% pop(family, genus, species)
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
#' ## pop out a single taxonomic class
#' df2 %>% pop(order)
#' df2 %>% pop(family)
#' df2 %>% pop(genus)
pop <- function(.data, ...) {
  UseMethod("pop")
}

#' @export
pop.taxon <- function(.data, ...){
  tmp <- .data$classification
  name <- vars(...)
  taxon(binomial = .data$binomial,
        classification = do.call("classification", tmp[!names(tmp) %in% name]))
}

#' @export
pop.taxondf <- function(.data, ...){
  var <- vars(...)
  check_vars(var, names(.data))
  select_(.data, paste0("-", var, collapse = ""))
}
