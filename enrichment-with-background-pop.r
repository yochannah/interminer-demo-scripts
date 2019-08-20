# load InterMineR
library(InterMineR)

# querying against my chosen InterMine
myMine <- listMines()["HumanMine"]
im <- initInterMine(mine=myMine)

# Let's make a list of ids I want to enrich
# These are human gene identifiers
myGenes <- c(2566,
             57094,
             6323,
             6324,
             6335,
             84059)

# currently enrichment results MUST have a saved list as a background population,
# and the background population MUST have all of the same genes as in the list we're enriching.
# let's make a saved, named HumanMine list with our ids.
# note that this is the same list as above with a few extra ids for demo purposes
# it probably doesn't make much biological sense
backgroundPopulation <- list(2566,
                          57094,
                          6323,
                          6324,
                          6335,
                          84059, 
                          5468, 
                          3983, 
                          10257, 
                          105, 
                          29929)

# We need to pass the list of ids as a single comma (or tab, or newline) separated string
backgroundPopulationString <- paste0(backgroundPopulation, 
                                     collapse=",")

# This is the name that will be saved in the InterMine server
backgroundPopulationListName <- "myBackgroundPopulation"

# The type of object you're saving, e.g. Gene or Protein or something else. 
# This must match the name of the class in the InterMine model, e.g. "Gene" not "gene" or "genes"
backgroundPopulationListType <- "Gene"

# The URL we call to save the list, with the name of the list we want to save
# and the type of objects embedded in the URL as parameters. 
requestUrl <- paste0(myMine,
                     "/service/lists?name=", backgroundPopulationListName,
                     "&type=", backgroundPopulationListType)

# okay, to save this list on the intermine servce I'll need a token (in this case from humanmine)
# to get your own token log into the web interface (e.g. humanmine.org) and go to the
# myMine tab, then click the Account Details sub-tab, and copy and paste (or generate)
# your token into this script
myToken <- "C1w6Sciavafam1W5d7Q8"; #replace this with your own token

# InterMineR doesn't have a built in method to save lists on the InterMine server, but we can call the API directly
# Load the httr library to make http requests
library(httr)
response <- POST(
                 # the URL we're making an API call against
                 url=requestUrl, 
                 # tell them which IDs you want saved, as a single string
                 body = backgroundPopulationString,
                 # prove you're you with a token
                 add_headers(Authorization = paste0("Token ", myToken)),
                 encode = "multipart", 
                 # clear errors please
                 verbose(),
                 # required, will return 500 error without the content type
                 content_type("text/plain;charset=UTF-8"))

#enrichment result with saved list name and background population as a saved list
enrichmentResult <- doEnrichment(
  im = im,
  ids = myGenes,
  widget = "publication_enrichment",
  population = "myBackgroundPopulation"
)

content(enrichmentResult)

