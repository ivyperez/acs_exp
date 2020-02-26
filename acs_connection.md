ACS Connection
================

The ‘censusapi’ package in R connects to the Census API and can be used
to retrieve Census Data. Below is a quick guide to get connected to the
API and download a sample dataset.

### Package Dependencies

If you don’t have them already, download and install the devtools &
censusapi packages:

``` r
# install.packages("devtools")
# devtools::install_github("hrecht/censusapi")
```

Load the packages:

``` r
library(dplyr)
library(devtools)
library(censusapi)
```

### Request API Access Key

To connect to the Census API, you need an API access key. You can get
the key at this website: <https://api.census.gov/data/key_signup.html>.
You’ll receive the key via an email with a confirmation link. The key
won’t work for a few minutes after you click the confirmation link.

Save it to your .Renviron file (replace) `"YOURKEYHERE`" with your
actual key. It would be foolish (foolish, I say\!) for me to leave my
actual key up. Then you could make all sorts of weird queries and the
Census will think it was me\!

Anyway, you’ll have to run these lines every time you disconnect R:

``` r
# Add key to .Renviron
Sys.setenv(CENSUS_KEY="YOUR KEY HERE")
# Reload .Renviron
 readRenviron("~/.Renviron")
# Check to see that the expected key is output in your R console
CENSUS_KEY <- Sys.getenv("CENSUS_KEY")
```

You request data from the api using the `getCensus` function. You
specify what you want to retrieve from the API using the different
arguments to the function. The arguments are:

1.  **Name of dataset** - a short name specifying the survey you want.
    For the American community survey, the dataset names are
    `"acs/acs1"` and `"acs/acs5"` for American Community Survey 1-Year
    and 5-Year estimates respectively. A list of datasets can be
    retrieved using `listCensusApis`, described below:
2.  **Vintage** - required for all datasets
3.  **Key** - Your API key
4.  **Vars** - the variables you want to retrieve (a list can be grabbed
    using `listCensusMetadata`)
5.  **Region** - Geographic location of interest (you also sometimes
    specify `regionin`, for some reason, maybe I’ll figure it out by the
    time I explain it below:)

### Get name of datasets and store them in a new data table, `apis`

``` r
apis <- censusapi::listCensusApis()
print(head(select(apis,name,title,vintage),rowname=FALSE))
```

    ##         name
    ## 380 acs/acs1
    ## 382 acs/acs1
    ## 385 acs/acs1
    ## 395 acs/acs1
    ## 401 acs/acs1
    ## 74  acs/acs1
    ##                                                                   title vintage
    ## 380 American Community Survey: 1-Year Estimates: Detailed Tables 1-Year    2005
    ## 382 American Community Survey: 1-Year Estimates: Detailed Tables 1-Year    2006
    ## 385 American Community Survey: 1-Year Estimates: Detailed Tables 1-Year    2007
    ## 395 American Community Survey: 1-Year Estimates: Detailed Tables 1-Year    2008
    ## 401 American Community Survey: 1-Year Estimates: Detailed Tables 1-Year    2009
    ## 74                                           ACS 1-Year Detailed Tables    2010

### Get the names of the variables by using ‘listCensusMetadata’ function

``` r
vars2014 <- listCensusMetadata(name="acs/acs5", vintage=2014, "v")
head(vars2014)
```

    ##           name
    ## 1  B99104_007E
    ## 2  B24022_060E
    ## 3  B11011_007E
    ## 4 B19001B_014E
    ## 5  B24032_049E
    ## 6  B11011_006E
    ##                                                                                                              label
    ## 1                                                Estimate!!Total!!Not living with own grandchildren under 18 years
    ## 2                   Estimate!!Total!!Female!!Service occupations!!Food preparation and serving related occupations
    ## 3                                                                 Estimate!!Total!!Family households!!Other family
    ## 4                                                                            Estimate!!Total!!$100,000 to $124,999
    ## 5 Estimate!!Female!!Educational services, and health care and social assistance!!Health care and social assistance
    ## 6             Estimate!!Total!!Family households!!Married-couple family!!Mobile homes and all other types of units
    ##                                                                                                                                                                         concept
    ## 1                                                IMPUTATION OF LENGTH OF TIME GRANDPARENT RESPONSIBLE FOR OWN GRANDCHILDREN UNDER 18 YEARS FOR THE POPULATION 30 YEARS AND OVER
    ## 2 SEX BY OCCUPATION AND MEDIAN EARNINGS IN THE PAST 12 MONTHS (IN 2014 INFLATION-ADJUSTED DOLLARS) FOR THE FULL-TIME, YEAR-ROUND CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER
    ## 3                                                                                                                                          HOUSEHOLD TYPE BY UNITS IN STRUCTURE
    ## 4                                                     HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2014 INFLATION-ADJUSTED DOLLARS) (BLACK OR AFRICAN AMERICAN ALONE HOUSEHOLDER)
    ## 5                         SEX BY INDUSTRY AND MEDIAN EARNINGS IN THE PAST 12 MONTHS (IN 2014 INFLATION-ADJUSTED DOLLARS) FOR THE CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER
    ## 6                                                                                                                                          HOUSEHOLD TYPE BY UNITS IN STRUCTURE
    ##   predicateType   group limit                               attributes required
    ## 1           int  B99104     0                             B99104_007EA     <NA>
    ## 2           int  B24022     0    B24022_060EA,B24022_060M,B24022_060MA     <NA>
    ## 3           int  B11011     0    B11011_007EA,B11011_007M,B11011_007MA     <NA>
    ## 4           int B19001B     0 B19001B_014EA,B19001B_014M,B19001B_014MA     <NA>
    ## 5           int  B24032     0    B24032_049EA,B24032_049M,B24032_049MA     <NA>
    ## 6           int  B11011     0    B11011_006EA,B11011_006M,B11011_006MA     <NA>

### Arguments: geography

``` r
# Warning: this part can take awhile
# geovars2014 <- listCensusMetadata(name="acs/acs5",vintage=2014,"g")
```

### View(geovars2014)

``` r
# head(geovars2014)
```

### See variables for 2018

``` r
vars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"v")
head(vars2018)
```

    ##            name
    ## 1   B24022_060E
    ## 2  B19001B_014E
    ## 3   C02014_002E
    ## 4 B07007PR_019E
    ## 5  B19101A_004E
    ## 6   B24022_061E
    ##                                                                                                     label
    ## 1          Estimate!!Total!!Female!!Service occupations!!Food preparation and serving related occupations
    ## 2                                                                   Estimate!!Total!!$100,000 to $124,999
    ## 3                                                      Estimate!!Total!!American Indian tribes, specified
    ## 4                 Estimate!!Total!!Moved from different municipio!!Foreign born!!Naturalized U.S. citizen
    ## 5                                                                     Estimate!!Total!!$15,000 to $19,999
    ## 6 Estimate!!Total!!Female!!Service occupations!!Building and grounds cleaning and maintenance occupations
    ##                                                                                                                                                                         concept
    ## 1 SEX BY OCCUPATION AND MEDIAN EARNINGS IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS) FOR THE FULL-TIME, YEAR-ROUND CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER
    ## 2                                                     HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS) (BLACK OR AFRICAN AMERICAN ALONE HOUSEHOLDER)
    ## 3                                                                                                         AMERICAN INDIAN AND ALASKA NATIVE ALONE FOR SELECTED TRIBAL GROUPINGS
    ## 4                                                                             GEOGRAPHICAL MOBILITY IN THE PAST YEAR BY CITIZENSHIP STATUS FOR CURRENT RESIDENCE IN PUERTO RICO
    ## 5                                                                            FAMILY INCOME IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS) (WHITE ALONE HOUSEHOLDER)
    ## 6 SEX BY OCCUPATION AND MEDIAN EARNINGS IN THE PAST 12 MONTHS (IN 2018 INFLATION-ADJUSTED DOLLARS) FOR THE FULL-TIME, YEAR-ROUND CIVILIAN EMPLOYED POPULATION 16 YEARS AND OVER
    ##   predicateType    group limit                                  attributes
    ## 1           int   B24022     0       B24022_060M,B24022_060MA,B24022_060EA
    ## 2           int  B19001B     0    B19001B_014EA,B19001B_014M,B19001B_014MA
    ## 3           int   C02014     0       C02014_002M,C02014_002MA,C02014_002EA
    ## 4           int B07007PR     0 B07007PR_019EA,B07007PR_019M,B07007PR_019MA
    ## 5           int  B19101A     0    B19101A_004M,B19101A_004MA,B19101A_004EA
    ## 6           int   B24022     0       B24022_061M,B24022_061MA,B24022_061EA
    ##   required
    ## 1     <NA>
    ## 2     <NA>
    ## 3     <NA>
    ## 4     <NA>
    ## 5     <NA>
    ## 6     <NA>

### 2018 geovars

``` r
geovars2018 <- listCensusMetadata(name="acs/acs1",vintage=2018,"g")
head(geovars2018)
```

    ##                 name geoLevelDisplay referenceDate      requires wildcard
    ## 1                 us             010    2018-01-01          NULL     NULL
    ## 2             region             020    2018-01-01          NULL     NULL
    ## 3           division             030    2018-01-01          NULL     NULL
    ## 4              state             040    2018-01-01          NULL     NULL
    ## 5             county             050    2018-01-01         state    state
    ## 6 county subdivision             060    2018-01-01 state, county   county
    ##   optionalWithWCFor
    ## 1              <NA>
    ## 2              <NA>
    ## 3              <NA>
    ## 4              <NA>
    ## 5             state
    ## 6            county

### Full example call for all counties in US

``` r
data2014 <- getCensus(name="acs/acs5",
                      vintage=2014,
                      key=CENSUS_KEY,
                      vars=c("NAME","B01001_001E", "B19013_001E", "B17010_017E", "B17010_037E"),
                      region="county:*")
```

``` r
head(data2014)
```

    ##   state county                           NAME B01001_001E B19013_001E
    ## 1    06    037 Los Angeles County, California     9974203       55870
    ## 2    06    039      Madera County, California      152452       45490
    ## 3    06    041       Marin County, California      256802       91529
    ## 4    06    043    Mariposa County, California       17946       50560
    ## 5    06    045   Mendocino County, California       87612       43290
    ## 6    06    047      Merced County, California      261609       43066
    ##   B17010_017E B17010_037E
    ## 1      119794      188266
    ## 2        2553        2257
    ## 3        1207        4359
    ## 4         143         228
    ## 5        1249        1422
    ## 6        5361        4642

### Get all variables for group “B25118”, “Tenure by Income in Past 12 months”

``` r
tenure_by_income_vars <- vars2018 %>%
  filter(group %in% "B25118") %>%
  select(name)

head(tenure_by_income_vars)
```

    ##          name
    ## 1 B25118_006E
    ## 2 B25118_007E
    ## 3 B25118_008E
    ## 4 B25118_009E
    ## 5 B25118_001E
    ## 6 B25118_002E

``` r
tenure_by_income_vars_names <- vars2018 %>%
  filter(group %in% "B25118") %>%
  select(label)
```

### Sample call for NY data

``` r
nydata2018 <- getCensus(name="acs/acs1",
                         vintage=2018,
                         key=CENSUS_KEY,
                         vars=tenure_by_income_vars$name,
                         region="state:36"
                         )
head(nydata2018)
```

    ##   state B25118_006E B25118_007E B25118_008E B25118_009E B25118_001E B25118_002E
    ## 1    36       97064      122516      229618      351431     7367015     3953785
    ##   B25118_003E B25118_004E B25118_005E B25118_010E B25118_011E B25118_012E
    ## 1       66816       44078       81892      601645      532005      790767
    ##   B25118_013E B25118_018E B25118_019E B25118_014E B25118_015E B25118_016E
    ## 1     1035953      213876      203225     3413230      187776      205239
    ##   B25118_017E B25118_021E B25118_022E B25118_023E B25118_024E B25118_025E
    ## 1      275737      421781      520836      347303      361268      334712
    ##   B25118_020E
    ## 1      341477

### Advanced Geography

#### region + region

``` r
data200 <- getCensus(name="sf3",vintage=2000,
                     key=CENSUS_KEY,
                     vars=c("P001001","P053001","H063001"),
                     region="county:*",regionin = "state:06")
head(data200)
```

    ##   state county P001001 P053001 H063001
    ## 1    06    001 1443741   55946     852
    ## 2    06    003    1208   41875     659
    ## 3    06    005   35100   42280     685
    ## 4    06    007  203171   31924     563
    ## 5    06    009   40554   41022     599
    ## 6    06    011   18804   35062     494
