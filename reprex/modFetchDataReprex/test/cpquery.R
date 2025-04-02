library(bnlearn)
library(tidyverse)
# CORRECT SYNTAX FOR BNLEARN::CPQUERY

# Load .net file into bayesian network object
# baynet <- read.net("rscripts/modFetchDataReprex/test/niagara.net")
baynet <- read.net("rscripts/modFetchDataReprex/test/vancouver.net")

nodes <- names(baynet) # these are the nodes of the network
baynet[["geomean200"]] %>% names()
  baynet[["geomean200"]]$node  # node name, same as the baynet name "geomean200"
  baynet[["geomean200"]]$parents # parent nodes: "watertemp", "turbidity", "geomean24", "avgwspd", "waveheight"
  baynet[["geomean200"]]$children # children nodes: empty character
  baynet[["geomean200"]]$prob


cpquery(fitted = baynet,
        event = logical(),
        evidence = logical())

# these logical values are condition statements:
cpquery(baynet,
  event = (geomean200 == "true"), # in the data, this is either TRUE or FALSE,
  evidence = (watertemp == "[0,15]")) # these conditions are either TRUE or FALSE)

# Multiple evidence statements
cpquery(baynet,
        event = (geomean200 == "true"), # in the data, this is either TRUE or FALSE,
        evidence = (avgwspd == "(5.6,11.1]" & rain48 == "[0,2.5]")) # these conditions are either TRUE or FALSE)


# and you can get the actual table of numbers like this
table(cpdist(baynet, "Max24UV", (avgwspd == "(5.6,11.1]")))

### testing a dynamic value for shiny implement

# Function to determine the increment for Max24UV in Niagara
determineMax24UVNiagara <- function(value) {
     if (value >= 0 && value <= 5.98) {
          return("[0,5.98]")
     } else if (value > 5.98 && value <= 7.1) {
          return("(5.98,7.1]")
     } else if (value > 7.1 && value <= 7.92) {
          return("(7.1,7.92]")
     } else if (value > 7.92 && value <= 12) {
          return("(7.92,12]")
     } else {
          return(NA) # or handle out-of-range values as needed
     }
}

# Function to determine the increment for Max24UV in Winnipeg
determineMax24UVWinnipeg <- function(value) {
     if (value >= 0 && value <= 4.55) {
          return("[0,4.55]")
     } else if (value > 4.55 && value <= 5.52) {
          return("(4.55,5.52]")
     } else if (value > 5.52 && value <= 6.3) {
          return("(5.52,6.3]")
     } else if (value > 6.3 && value <= 10) {
          return("(6.3,10]")
     } else {
          return(NA) # or handle out-of-range values as needed
     }
}

# Example usage
uv_dummy <- 2
max24UV_increment <- determineMax24UVIncrement(uv_dummy)

# Use cpquery with dynamic evidence
cpquery(baynet,
       event = (geomean200 == "true"),
       evidence = (Max24UV == max24UV_increment)
)

cpquery(baynet,
        event = (geomean200 == "true"), # in the data, this is either TRUE or FALSE,
        evidence = (Max24UV == "[0,5.98]") # these conditions are either TRUE or FALSE)
)

