#' Taxonomic class specification and parsing methods
#'
#' @name binomen-package
#' @aliases binomen
#' @docType package
#' @title Taxonomic class specification and parsing methods
#' @keywords package
#'
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' # get single name
#' out %>% pick(family)
#' out %>% pick(genus)
#' out %>% pick(species)
#' out %>% pick(species) %>% name()
#' out %>% pick(species) %>% uri()
#' # get range of names
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
#' ## select single taxonomic class
#' df2 %>% pick(order, Fagales)
#' df2 %>% pick(family, Asteraceae)
#' df2 %>% pick(genus, Poa)
#'
#' ## filter to get a range of classes
#' df2 %>% span(order, genus)
#' df2 %>% span(family, genus)
#'
#' ## combine them
#'  df2 %>%
#'    span(family, genus) %>%
#'    pick(family, Asteraceae)
NULL
