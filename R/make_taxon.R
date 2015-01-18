#' Make taxon from class
#'
#' @export
#' @import methods
#'
#' @param genus Genus name, e.g., Homo (in Homo sapiens)
#' @param epithet Specific epithet, e.g., sapiens (in Homo sapiens)
#' @param authority Taxonomic authority
#' @examples
#' (out <- make_taxon(genus="Poa", epithet="annua", authority="L."))
#' (out <- make_taxon(genus="Poa", epithet="annua", authority="L.",
#'                    family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua'))
#' (out <- make_taxon(genus="Poa"))
#' make_taxon(epithet="annua") # errors
#' out@@binomial
#' out@@binomial@@canonical
#' out@@binomial@@species
#' out@@binomial@@authority
#' out@@classification
#' out@@classification@@family
#' out[['family']] # get a single rank
#' out['family','kingdom'] # get a range of ranks
#' out['variety','genus'] # get a range of ranks
#' gethier(out) # get hierarchy as data.frame

make_taxon <- function(genus="none", epithet="none", authority="none"){
  if(genus=='none') stop("You must supply at least genus")
  res <- new("binomial",
             genus=genus,
             epithet=epithet,
             canonical=paste(genus,epithet,collapse=" "),
             species=paste(genus,epithet,authority,collapse=" "),
             authority=authority)
  input <- list(...)
  hier <- new("classification",
              genus=new("taxonref", name=genus),
              species=new("taxonref", name=paste(genus,epithet,collapse=" ")))
  if(length(input) > 0){
    output <- list()
    for(i in seq_along(input)){
      slot(hier, names(input)[i]) <- new("taxonref", name=input[[i]])
    }
  }
  new("taxon", binomial=res, classification=hier)
}
