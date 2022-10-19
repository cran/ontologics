## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(knitr)

## ----setup--------------------------------------------------------------------
library(ontologics)
library(dplyr, warn.conflicts = FALSE)

## ----concept matches----------------------------------------------------------
# already existing ontology for some project about crops
crops <- load_ontology(path = system.file("extdata", "crops.rds", package = "ontologics"))

# where we have to set the external dataset as new source
crops <- new_source(name = "externalDataset",
                    version = "0.0.1",
                    description = "a vocabulary",
                    homepage = "https://www.something.net",
                    license = "CC-BY-4.0",
                    ontology = crops)

# new concepts that occur in the external dataset, which should be harmonised with the ontology
newConcepts <- tibble(label = c("Wheat", "NUTS", "Avocado"))

## ----get_concepts missing-----------------------------------------------------
missingConcepts <- get_concept(x = newConcepts, ontology = crops)
kable(missingConcepts)

## ----set_concept--------------------------------------------------------------
broaderConcepts <- get_concept(x = tibble(label = c("Wheat", "Tropical and subtropical Fruit")), 
                               ontology = crops)

crops <- new_concept(new = c("wheat", "avocado"),
                     broader = broaderConcepts,
                     class = "crop",
                     ontology = crops)

## ----set_mapping--------------------------------------------------------------
toMap <- get_concept(x = tibble(label = c("wheat", "NUTS", "avocado")),
                     ontology = crops)

crops <- new_mapping(new = newConcepts %>% pull(label),
                     target = toMap,
                     match = c("close", "close", "close"),
                     source = "externalDataset",
                     certainty = 3,
                     ontology = crops)

## -----------------------------------------------------------------------------
broaderConcepts <- get_concept(x = tibble(label = c("wheat", "wheat")),
                               ontology = crops)

# for (some of) these concepts we do not know the class ...
crops <- new_concept(new = c("wheat1", "wheat2"),
                     broader = broaderConcepts,
                     class = NA_character_,
                     ontology = crops)

get_concept(x = tibble(label = "Wheat"), tree = TRUE, ontology = crops)[,1:6] %>% 
  kable()
# ... ok, then let's specify that class and re-run new_concept
crops <- new_class(new = "cultivar", target = "crop", 
                   description = "type of plant that people have bred for desired traits", 
                   ontology = crops)

crops <- new_concept(new = c("wheat1", "wheat2"),
                     broader = broaderConcepts,
                     class = "cultivar",
                     ontology = crops)

## ----new ontology-------------------------------------------------------------
get_concept(x = tibble(label = "Wheat"), tree = TRUE, ontology = crops)[,1:6] %>% 
  kable()

get_concept(x = tibble(label = "NUTS"), tree = TRUE, ontology = crops)[,1:6] %>% 
  kable()

get_concept(x = tibble(label = "FRUIT"), tree = TRUE, ontology = crops)[,1:6] %>% 
  kable()
