# load InterMineR
library(InterMineR)

# querying against my chosen InterMine
myMine <- listMines()["YeastMine"]
im <- initInterMine(mine=myMine)


# enrichment result with saved list name and background population as a saved list
enrichmentResult <- doEnrichment(
  im = im,
  genelist = "Dubious_ORFs",
  widget = "publication_enrichment",
  population = "ALL_Verified_Uncharacterized_Dubious_ORFs"
)

# enrichment result with saved list name and background population as a saved list
enrichmentResultBad <- doEnrichment(
  im = im,
  genelist = "Dubious_ORFs",
  widget = "publication_enrichment",
  population = "snRNAs"
)

enrichmentResultBad
