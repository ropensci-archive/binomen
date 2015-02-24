#' Select names
#'
#' @export
#'
#' @param .data Input, object of class taxon
#' @param ... Further unnamed args, see examples
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#' # get single name
#' out %>% select(family)
#' out %>% select(genus)
#' out %>% select(species)
#' out %>% select(species) %>% name()
#' out %>% select(species) %>% uri()
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
#' df2 %>% select(order, Fagales)
#' df2 %>% select(family, Asteraceae)
#' df2 %>% select(genus, Poa)
select <- function(.data, ...) {
  UseMethod("select")
}

#' @export
select.taxon <- function(.data, ...){
  tmp <- .data$classification
  name <- vars(...)
  tmp[[name]]
}

#' @export
select.taxondf <- function(.data, ...){
  var <- vars(...)
  if(length(var) > 2) stop("Pass in only two values", call. = FALSE)
  check_vars(var[1], names(.data))
  .data[ .data[var[1]] == var[2] , ]
}

#' @export
#' @rdname select
name <- function(.data) {
  UseMethod("name")
}

#' @export
#' @rdname select
name.taxonref <- function(.data) {
  .data$name
}

#' @export
#' @rdname select
uri <- function(.data) {
  UseMethod("uri")
}

#' @export
#' @rdname select
uri.taxonref <- function(.data) {
  .data$uri
}

# helpers ---------------------------
fill_nums <- function(x) seq(from=min(x), to=max(x), by=1)

vars <- function(...) as.character(dots(...))

dots <- function(...){
  eval(substitute(alist(...)))
}

check_vars <- function(x, y){
  if( !all(x %in% y) ) stop(sprintf("%s not a valid taxonomic rank in your dataset", paste0(x[!x %in% y], collapse = ", ")), call. = FALSE)
}
