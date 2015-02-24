#' Scatter each taxon in a taxondf to a taxon object
#'
#' @export
#' @param x A taxonomic data.frame
#' @param ... Further args, ignored for now
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
#' ## scatter each taxon into a taxon class
#' df2 %>% scatter(order)
scatter <- function(x, ...) {
  UseMethod("scatter")
}

#' @export
scatter.taxondf <- function(x, ...) {
  x <- class2clazz(x)
  unname(apply(x, 1, function(y){
    do.call("make_taxon", as.list(y))
  }))
}

class2clazz <- function(x){
  if("class" %in% names(x)){
    names(x)[which(names(x) == "class")] <- "clazz"
    x
  } else {
    x
  }
}
