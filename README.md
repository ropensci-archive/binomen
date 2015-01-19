binomia
=======



`binomia` provides a taxonomic class for defining a taxon and multiple taxa.

It is meant to work with [taxize](https://github.com/ropensci/taxize), where you can get data on taxonomic names.


## Installation


```r
install.packages("devtools")
devtools::install_github("ropensci/binomia")
```


```r
library('binomia')
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
#>     kingdom: Plantae
#>     clazz: Poales
#>     family: Poaceae
#>     genus: Poa
#>     species: Poa annua
#>     variety: annua
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

Get a single rank


```r
obj %>% select(family)
#> <taxonref>
#>   rank: family
#>   name: Poaceae
#>   id: none
#>   uri: none
```

Get a range of ranks


```r
obj %>% range(kingdom, family)
#> $kingdom
#> <taxonref>
#>   rank: kingdom
#>   name: Plantae
#>   id: none
#>   uri: none
#> 
#> $clazz
#> <taxonref>
#>   rank: clazz
#>   name: Poales
#>   id: none
#>   uri: none
#> 
#> $family
#> <taxonref>
#>   rank: family
#>   name: Poaceae
#>   id: none
#>   uri: none
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

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/binomia/issues).
* License: MIT
* Get citation information for `binomia` in R doing `citation(package = 'binomia')`

[![ropensci](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
