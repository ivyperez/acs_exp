
# Testing how to get Census Data

## Connect to ACS API
# First request API key https://api.census.gov/data/key_signup.html

# store ivy API key
ivy_api_key <- "e3111ffad343455b6e8820f4ab4db17fad17502a"

# Add key to .Renviron
Sys.setenv(CENSUS_KEY="e3111ffad343455b6e8820f4ab4db17fad17502a")
# Reload .Renviron
readRenviron("~/.Renviron")
# Check to see that the expected key is output in your R console
CENSUS_KEY <- Sys.getenv("CENSUS_KEY")

# Install Census API package
install.packages("devtools")
devtools::install_github("hrecht/censusapi")

# Load the package
library("censusapi")


#getCensus function required arguments:
# 1. name
# 2. vintage - required for all datasets
# 3. key - aiv_api_key
# 4. vars
# 5. region

# Arguments: name and vintage
apis <- listCensusApis()
View(apis)

# Arguments: variables
vars2014 <- listCensusMetadata(name="acs/acs5", vintage=2014, "v")
View(vars2014)

# Arguments: geography
geovars2014 <- listCensusMetadata(name="acs/acs5",vintage=2014,"g")
View(geovars2014)

# Check 2018 works
vars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"v")

# 2018 geovars
geovars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"g")

ivy_api_key <-

# Putting it all together
data2014 <- getCensus(name="acs/acs5",
                      vintage=2014,
                      key=ivy_api_key,
                      vars=c("B01001_001E","B19013_001E","state","county"),
                      region="county:*")

View(data2014)


census_key <- "e3111ffad343455b6e8820f4ab4db17fad17502a"

# Advanced Geography
# region + region

data200 <- getCensus(name="sf3",vintage=2000,
                     key=ivy_api_key,
                     vars=c("P001001","P053001","H063001"),
                     region="county:*",regionin = "state:06")


