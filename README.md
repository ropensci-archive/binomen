binomen
=======



[![Build Status](https://api.travis-ci.org/ropensci/binomen.png)](https://travis-ci.org/ropensci/binomen)
[![codecov.io](http://codecov.io/github/ropensci/binomen/coverage.svg?branch=master)](http://codecov.io/github/ropensci/binomen?branch=master)

`binomen` provides various taxonomic classes for defining a single taxon, multiple taxa, and a taxonomic data.frame

It is sort of a companion to [taxize](https://github.com/ropensci/taxize), where you can get taxonomic data on taxonomic names from the web.

The classes (S3):

* `taxon`
* `taxonref`
* `taxonrefs`
* `binomial`
* `classification`

The verbs:

* `gethier()` - get hierarchy from a `taxon` class
* `scatter()` - make each row in taxonomic data.frame (`taxondf`) a separate `taxon` object within a single `taxa` object
* `assemble()` - make a `taxa` object into a `taxondf` data.frame
* `pick()` - pick out one or more taxonomic groups
* `pop()` - pop out (drop) one or more taxonomic groups
* `span()` - pick a range between two taxonomic groups (inclusive)
* `sort()` - sort by columns, similar to `dplyr::arrange`
* `name()` - get the taxon name for each `taxonref` object
* `uri()` - get the reference uri for each `taxonref` object
* `rank()` - get the taxonomic rank for each `taxonref` object
* `id()` - get the reference uri for each `taxonref` object

## Installation


```r
install.packages("devtools")
devtools::install_github("ropensci/binomen")
```


```r
library('binomen')
```

## Make a taxon

Make a taxon object


```r
(obj <- make_taxon(genus="Poa", epithet="annua", authority="L.",
                   family='Poaceae', clazz='Poales', kingdom='Plantae', variety='annua'))
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     kingdom: Plantae
#>     clazz: Poales
#>     family: Poaceae
#>     genus: Poa
#>     species: Poa annua
#>     variety: annua
```

Index to various parts of the object

The binomial


```r
obj$binomial
#> <binomial>
#>   genus: Poa
#>   epithet: annua
#>   canonical: Poa annua
#>   species: Poa annua L.
#>   authority: L.
```

The authority


```r
obj$binomial$authority
#> [1] "L."
```

The classification


```r
obj$classification
#> <classification>
#>   kingdom: Plantae
#>   clazz: Poales
#>   family: Poaceae
#>   genus: Poa
#>   species: Poa annua
#>   variety: annua
```

The family


```r
obj$classification$family
#> <taxonref>
#>   rank: family
#>   name: Poaceae
#>   id: none
#>   uri: none
```

## Subset taxon objects

Get one or more ranks via `pick()`


```r
obj %>% pick(family)
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     family: Poaceae
obj %>% pick(family, genus)
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     family: Poaceae
#>     genus: Poa
```

Drop one or more ranks via `pop()`


```r
obj %>% pop(family)
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     kingdom: Plantae
#>     clazz: Poales
#>     genus: Poa
#>     species: Poa annua
#>     variety: annua
obj %>% pop(family, genus)
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     kingdom: Plantae
#>     clazz: Poales
#>     species: Poa annua
#>     variety: annua
```

Get a range of ranks via `span()`


```r
obj %>% span(kingdom, family)
#> <taxon>
#>   binomial: Poa annua
#>   classification: 
#>     kingdom: Plantae
#>     clazz: Poales
#>     family: Poaceae
```

Extract classification as a `data.frame`


```r
gethier(obj)
#>      rank      name
#> 1 kingdom   Plantae
#> 2   clazz    Poales
#> 3  family   Poaceae
#> 4   genus       Poa
#> 5 species Poa annua
#> 6 variety     annua
```

## Taxonomic data.frame's

Make one


```r
df <- data.frame(order=c('Asterales','Asterales','Fagales','Poales','Poales','Poales'),
                family=c('Asteraceae','Asteraceae','Fagaceae','Poaceae','Poaceae','Poaceae'),
                genus=c('Helianthus','Helianthus','Quercus','Poa','Festuca','Holodiscus'),
                stringsAsFactors = FALSE)
(df2 <- taxon_df(df))
#>       order     family      genus
#> 1 Asterales Asteraceae Helianthus
#> 2 Asterales Asteraceae Helianthus
#> 3   Fagales   Fagaceae    Quercus
#> 4    Poales    Poaceae        Poa
#> 5    Poales    Poaceae    Festuca
#> 6    Poales    Poaceae Holodiscus
```

Parse - get rank order via `pick()`


```r
df2 %>% pick(order)
#>       order
#> 1 Asterales
#> 2 Asterales
#> 3   Fagales
#> 4    Poales
#> 5    Poales
#> 6    Poales
```

get ranks order, family, and genus via `pick()`


```r
df2 %>% pick(order, family, genus)
#>       order     family      genus
#> 1 Asterales Asteraceae Helianthus
#> 2 Asterales Asteraceae Helianthus
#> 3   Fagales   Fagaceae    Quercus
#> 4    Poales    Poaceae        Poa
#> 5    Poales    Poaceae    Festuca
#> 6    Poales    Poaceae Holodiscus
```

get range of names via `span()`, from rank `X` to rank `Y`


```r
df2 %>% span(family, genus)
#>       family      genus
#> 1 Asteraceae Helianthus
#> 2 Asteraceae Helianthus
#> 3   Fagaceae    Quercus
#> 4    Poaceae        Poa
#> 5    Poaceae    Festuca
#> 6    Poaceae Holodiscus
```

Separate each row into a `taxon` class (many `taxon` objects are a `taxa` class)


```r
scatter(df2)
#> [[1]]
#> <taxon>
#>   binomial: Helianthus none
#>   classification: 
#>     order: Asterales
#>     family: Asteraceae
#>     genus: Helianthus
#>     species: Helianthus none
#> 
#> [[2]]
#> <taxon>
#>   binomial: Helianthus none
#>   classification: 
#>     order: Asterales
#>     family: Asteraceae
#>     genus: Helianthus
#>     species: Helianthus none
#> 
#> [[3]]
#> <taxon>
#>   binomial: Quercus none
#>   classification: 
#>     order: Fagales
#>     family: Fagaceae
#>     genus: Quercus
#>     species: Quercus none
#> 
#> [[4]]
#> <taxon>
#>   binomial: Poa none
#>   classification: 
#>     order: Poales
#>     family: Poaceae
#>     genus: Poa
#>     species: Poa none
#> 
#> [[5]]
#> <taxon>
#>   binomial: Festuca none
#>   classification: 
#>     order: Poales
#>     family: Poaceae
#>     genus: Festuca
#>     species: Festuca none
#> 
#> [[6]]
#> <taxon>
#>   binomial: Holodiscus none
#>   classification: 
#>     order: Poales
#>     family: Poaceae
#>     genus: Holodiscus
#>     species: Holodiscus none
#> 
#> attr(,"class")
#> [1] "taxa"
```

And you can re-assemble a data.frame from the output of `scatter()` with `assemble()`


```r
out <- scatter(df2)
assemble(out)
#>       order     family      genus         species
#> 1 Asterales Asteraceae Helianthus Helianthus none
#> 2 Asterales Asteraceae Helianthus Helianthus none
#> 3   Fagales   Fagaceae    Quercus    Quercus none
#> 4    Poales    Poaceae        Poa        Poa none
#> 5    Poales    Poaceae    Festuca    Festuca none
#> 6    Poales    Poaceae Holodiscus Holodiscus none
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/binomen/issues).
* License: MIT
* Get citation information for `binomen` in R doing `citation(package = 'binomen')`

[![ropensci](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
