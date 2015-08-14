context("classification")

test_that("classification basic functionality works", {
  aa <- classification(kingdom=taxonref("kingdom", "Animalia"),
                       species=taxonref("species", "Homo sapiens"))

  expect_is(aa, "classification")
  expect_is(aa$kingdom, "taxonref")
  expect_is(aa$species, "taxonref")

  expect_named(aa, c("kingdom", "species"))
  expect_named(aa$kingdom, c("rank", "name", "id", "uri"))

  expect_equal(aa$kingdom$rank, "kingdom")
  expect_equal(aa$species$name, "Homo sapiens")
  expect_equal(length(aa), 2)
  expect_equal(length(aa$kingdom), 4)
})

test_that("classification fails well", {
  expect_equal(length(classification()), 0)
  expect_error(classification(stuff = 5), "unused argument")
  expect_error(classification(kingdom = "stuff"),
               "One or more inputs was not of class taxonref")
  expect_error(classification(division = "stuff"),
               "One or more inputs was not of class taxonref")
})
