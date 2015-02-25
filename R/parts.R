#' Pick names
#'
#' @name parts
#'
#' @param .data Input, object of class taxon
#' @return For \code{taxon} inputs, gives back a \code{taxonref} object. For \code{taxondf}
#' inputs, gives back \code{taxondf}.
#' @examples
#' # operating on `taxon` objects
#' out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua')
#'
#' out %>% name()
#' out %>% uri()
#' out %>% rank()
#' out %>% id()

#' @export
#' @rdname parts
name <- function(.data) {
  UseMethod("name")
}

#' @export
#' @rdname parts
name.taxon <- function(.data) {
  pluck(.data$classification, "name", "")
}

#' @export
#' @rdname parts
name.taxonref <- function(.data) {
  .data$name
}


#' @export
#' @rdname parts
uri <- function(.data) {
  UseMethod("uri")
}

#' @export
#' @rdname parts
uri.taxon <- function(.data) {
  pluck(.data$classification, "uri", "")
}

#' @export
#' @rdname parts
uri.taxonref <- function(.data) {
  .data$uri
}


#' @export
#' @rdname parts
rank <- function(.data) {
  UseMethod("rank")
}

#' @export
#' @rdname parts
rank.taxon <- function(.data) {
  pluck(.data$classification, "rank", "")
}

#' @export
#' @rdname parts
rank.taxonref <- function(.data) {
  .data$uri
}


#' @export
#' @rdname parts
id <- function(.data) {
  UseMethod("id")
}

#' @export
#' @rdname parts
id.taxon <- function(.data) {
  pluck(.data$classification, "id", "")
}

#' @export
#' @rdname parts
id.taxonref <- function(.data) {
  .data$uri
}
