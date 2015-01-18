#' Taxonomic S4 class methods
#'
#' @name taxon_classes
#' @details
#' The taxonomic classes:
#'
#' \itemize{
#'  \item binomial adfafasfasdf
#' }
NULL

#' An S4 class to represent a taxonomic binomial
#'
#' @export
#' @slot genus A genus name
#' @slot epithet A specific epithet name
#' @slot canonical Canonical name
#' @slot species Species, genus plus epithet
#' @slot authority Authority name
setClass("binomial", slots = c(genus="character", epithet="character", canonical="character", species="character", authority="character"))

#' An S4 class to represent a taxonomic reference
#'
#' @rdname export
#' @slot rank Taxonomic rank
#' @slot name A name
#' @slot id Identifier
#' @slot source Source of name
setClass("taxonref", slots = c(rank='character', name='character', id='numeric', source='character'),
         prototype = prototype(rank='none', name='none', id=NaN, source='none'))

#' An S4 class to represent a list of taxonomic names
#'
#' @export
#' @slot names Names
setClass("ListOfTaxonRefs", slots = c(names="character"), contains="list")

setAs("character", "taxonref", function(from) new("taxonref", name=from))

# setMethod("combinetaxonref", "ListOfTaxonRefs", function(...){
#   input <- list(...)
#   assert_that(all(sapply(input, is, "ListOfTaxonRefs")))
#
# })

# new("ListOfTaxonRefs", lapply(list(kingdom="adfa", family="adf"), as, "taxonref"))


#' An S4 class to represent a taxonomic binomial
#'
#' @export
#' @slot kingdom A kingdom name
#' @slot subkingdom A subkingdom name
#' @slot infrakingdom A infrakingdom name
#' @slot division A division name
#' @slot phylum A phylum name
#' @slot subdivision A subdivision name
#' @slot infradavision A infradavision name
#' @slot superclass A superclass name
#' @slot clazz A clazz name
#' @slot subclass A subclass name
#' @slot infraclass A infraclass name
#' @slot superorder A superorder name
#' @slot order A order name
#' @slot suborder A suborder name
#' @slot infraorder A infraorder name
#' @slot superfamily A superfamily name
#' @slot family A family name
#' @slot subfamily A subfamily name
#' @slot tribe A tribe name
#' @slot subtribe A subtribe name
#' @slot genus A genus name
#' @slot subgenus A subgenus name
#' @slot section A section name
#' @slot subsection A subsection name
#' @slot species A species name
#' @slot subspecies A subspecies name
#' @slot variety A variety name
#' @slot race A race name
#' @slot subvariety A subvariety name
#' @slot stirp A stirp name
#' @slot morph A morph name
#' @slot form A form name
#' @slot aberration A aberration name
#' @slot subform A subform name
#' @slot unspecified A unspecified name
setClass("classification", slots = c(
  kingdom="taxonref",
  subkingdom="taxonref",
  infrakingdom="taxonref",
  division="taxonref",
  phylum="taxonref",
  subdivision="taxonref",
  infradavision="taxonref",
  superclass="taxonref",
  clazz="taxonref",
  subclass="taxonref",
  infraclass="taxonref",
  superorder="taxonref",
  order="taxonref",
  suborder="taxonref",
  infraorder="taxonref",
  superfamily="taxonref",
  family="taxonref",
  subfamily="taxonref",
  tribe="taxonref",
  subtribe="taxonref",
  genus="taxonref",
  subgenus="taxonref",
  section="taxonref",
  subsection="taxonref",
  species="taxonref",
  subspecies="taxonref",
  variety="taxonref",
  race="taxonref",
  subvariety="taxonref",
  stirp="taxonref",
  morph="taxonref",
  form="taxonref",
  aberration="taxonref",
  subform="taxonref",
  unspecified="taxonref"
), contains = "list")

#' An S4 class to represent a taxonomic binomial
#'
#' @export
#' @slot binomial A binomial name
#' @slot classification A classification object
setClass("taxon", slots = c(binomial = 'binomial', classification = 'classification'))

#' An S4 class to represent a taxonomic binomial
#'
#' @export
#' @slot taxon An object of class taxon
setClass("ListOfTaxa", slots = c(taxon = 'taxon'), prototype = prototype(list()), contains = 'list')
#
# new('ListOfTaxa', taxon=out)
# out2 <- list(make_taxon(genus="Poa", epithet="annua", authority="L."),
#              make_taxon(genus="Helianthus", epithet="annuus", authority="Baker"))
# gg <- new('ListOfTaxa', lapply(out2, as, "taxon"))
# class(gg)
# length(gg@.Data)

setMethod("[[", "taxon", function(x, i, ...){
  tmp <- x@classification
  slot(tmp, i)@name
})

setMethod("[", "taxon", function(x, i, j, ...){
  tmp <- x@classification
  nn <- slotNames(tmp)
  from <- match(j, nn)
  to <- match(i, nn)
  vapply(nn[to:from], function(g) slot(tmp, g)@name, "")
})
