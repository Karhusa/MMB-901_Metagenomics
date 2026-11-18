## Some setup for R packages needed for the analysis
.libPaths(c("/projappl/project_2022405/project_rpackages_r461", .libPaths()))

# Load required libraries
library(tidyverse)
library(phyloseq)
library(microViz)
library(mia)

## setwd() sets the working directory. 
## Set it to your course directory. Use the full path and put it between quotes.
setwd("")

## Read in the metadata file
metadata <- read.table("doc/metadata.txt", sep="\t", header = TRUE, row.names = 1)

# The metadata file has a line starting with Unclassified. Remove that either manually or with an R script.

## Clean metadata
metadata <- metadata %>%
  mutate(participant_type = recode(
    participant_type,
    "Recipient" = "recipient"
  ))

## Read in the metaphlan file as a TreeSummarizedExperiment object
tse <- mia::importMetaPhlAn("03_TAXONOMY/metaphlan.txt", assay.type="counts")

## Save the common samples
common.samples <- intersect(colnames(tse), rownames(metadata))

## Add metadata to the tse using common sample names
colData(tse) <- S4Vectors::DataFrame(metadata[common.samples,])

## Check the tse structure
tse

## Convert to phyloseq object
phy <- convertToPhyloseq(tse)

## Then the phyloseq object is ready and
## we can visualize the results using
## the ord_explore function from microViz package
phy %>% ord_explore()

# Finally, save both objects for later use
saveRDS(phy, file = "03_TAXONOMY/phyloseq_metaphlan4.rds")
saveRDS(tse, file = "03_TAXONOMY/tse_metaphlan4.rds")
