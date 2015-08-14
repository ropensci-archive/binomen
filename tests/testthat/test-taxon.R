context("taxon")

bin <- binomial("Poa", "annua", authority="L.")
class <- classification(kingdom=taxonref("kingdom", "Plantae"),
                        species=taxonref("family", "Poaceae"))

test_that("taxon basic functionality works", {
  aa <- taxon(bin, class)

  expect_is(aa, "taxon")
  expect_is(aa$binomial, "binomial")
  expect_is(aa$classification, "classification")
  expect_is(aa$classification$kingdom, "taxonref")
  expect_is(aa$classification$species, "taxonref")
  expect_is(aa$classification$species$rank, "character")

  expect_equal(length(aa), 2)
  expect_equal(length(aa$binomial), 3)
  expect_equal(length(aa$classification), 2)
})

test_that("taxon fails well", {
  expect_error(taxon(),
               "argument \"binomial\" is missing, with no default")
  expect_error(taxon("34435"),
               "One or more inputs was not of class binomial")
  expect_error(taxon("34435", 55666),
               "One or more inputs was not of class binomial")
  expect_error(taxon(bin, 55666),
               "One or more inputs was not of class classification")
  expect_error(taxon(23434, class),
               "One or more inputs was not of class binomial")
})
