#' Make taxon from class
#'
#' @export
#'
#' @param genus Genus name, e.g., Homo (in Homo sapiens)
#' @param epithet Specific epithet, e.g., sapiens (in Homo sapiens)
#' @param authority Taxonomic authority
#' @param ... Further args.
#' @examples \dontrun{
#' (out <- make_taxon(genus="Poa"))
#' (out <- make_taxon(genus="Poa", epithet="annua", authority="L."))
#' (out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'                    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua'))
#' out$binomial
#' out$binomial$canonical
#' out$binomial$species
#' out$binomial$authority
#' out$classification
#' out$classification$family
#' out %>% pick(family) # get a single rank
#' out %>% span(kingdom, family) # get a range of ranks
#' gethier(out) # get hierarchy as data.frame
#' }

make_taxon <- function(genus="none", epithet="none", authority="none", ...){
  if(genus=='none') stop("You must supply at least genus")
  res <- binomial(genus=genus,
             epithet=epithet,
             canonical=paste(genus,epithet,collapse=" "),
             species=paste(genus,epithet,authority,collapse=" "),
             authority=authority)
  input <- list(...)
  if(length(input) > 0){
    output <- list()
    for(i in seq_along(input)){
      output[[names(input)[i]]] <- taxonref(rank=names(input[i]), name=input[[i]])
    }
  } else{
    output <- list()
  }
  all <- c(output, list(
    genus=taxonref(rank = "genus", name=genus),
    species=taxonref(rank = "species", name=paste(genus, epithet, collapse=" "))))
  hier <- do.call(classification, all)
  taxon(binomial=res, classification=hier)
}
