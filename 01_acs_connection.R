# Testing how to get Census Data

## Connect to ACS API
# First request API key https://api.census.gov/data/key_signup.html

# Add key to .Renviron
# Sys.setenv(CENSUS_KEY="YOURKEYHERE")
# Reload .Renviron
readRenviron("~/.Renviron")
# Check to see that the expected key is output in your R console
CENSUS_KEY <- Sys.getenv("CENSUS_KEY")

# Install Census API package
install.packages("devtools")
devtools::install_github("hrecht/censusapi")

# Load the package
library("censusapi")

# getCensus function requires 5 arguments:
# 1. name of dataset
# 2. vintage - required for all datasets
# 3. key - aiv_api_key
# 4. vars
# 5. region

# Get name of available datasets and store them into apis:
apis <- listCensusApis()
View(apis)

# Get the names of the variables by using 'listCensusMetadata' function
vars2014 <- listCensusMetadata(name="acs/acs5", vintage=2014, "v")
View(vars2014)

# Arguments: geography
geovars2014 <- listCensusMetadata(name="acs/acs5",vintage=2014,"g")
View(geovars2014)

# See variables for 2018
vars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"v")

# 2018 geovars
geovars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"g")

# Full example call for all counties in US
data2014 <- getCensus(name="acs/acs5",
                      vintage=2014,
                      key=ivy_api_key,
                      vars=c("B01001_001E","B19013_001E","state","county"),
                      region="county:*")

# Get all variables for group "B25118", "Tenure by Income in Past 12 months"
tenure_by_income_vars <- vars2018 %>%
  filter(group %in% "B25118") %>%
  select(name)

tenure_by_income_vars_names <- vars2018 %>%
  filter(group %in% "B25118") %>%
  select(label)


# Sample call for NY data
nydata2018 <- getCensus(name="acs/acs1",
                         vintage=2018,
                         key=ivy_api_key,
                         vars=tenure_by_income_vars,
                         region="state:36"
                         )

# Advanced Geography
# region + region

data200 <- getCensus(name="sf3",vintage=2000,
                     key=ivy_api_key,
                     vars=c("P001001","P053001","H063001"),
                     region="county:*",regionin = "state:06")


