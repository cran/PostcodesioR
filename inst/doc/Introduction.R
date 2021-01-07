## ---- message = FALSE, warning = FALSE, eval = FALSE--------------------------
#  if (!require("devtools")) install.packages("devtools")
#  devtools::install_github("erzk/PostcodesioR")

## ---- message = FALSE, warning = FALSE----------------------------------------
library(PostcodesioR)

lookup_result <- postcode_lookup("EC1Y8LX")

#overview
str(lookup_result)

## -----------------------------------------------------------------------------
query_result <- postcode_query("EC1Y8LX")

#overview
str(query_result)

## -----------------------------------------------------------------------------
pc_list <- list(postcodes = c("PR3 0SG", "M45 6GN", "EX165BL"))
bulk_lookup_result <- bulk_postcode_lookup(pc_list)

#overview
str(bulk_lookup_result[1])

## -----------------------------------------------------------------------------
library(purrr)

bulk_list <- lapply(bulk_lookup_result, "[[", 2)

bulk_df <-
  map_dfr(bulk_list,
          `[`,
          c("postcode", "longitude", "latitude"))

## -----------------------------------------------------------------------------
scottish_lookup <- scottish_postcode_lookup("EH12NG")

str(scottish_lookup)

## -----------------------------------------------------------------------------
ocl <- outward_code_lookup("E1")

#overview
str(ocl)

## -----------------------------------------------------------------------------
rev_geo <- reverse_geocoding(0.127, 51.507)

# overview
str(rev_geo[1])

## -----------------------------------------------------------------------------
# create a list with the coordinates
geolocations_list <- structure(
 list(
 geolocations = structure(
 list(
 longitude = c(-3.15807731271522, -1.12935802905177),
 latitude = c(51.4799900627036, 50.7186356978817),
 limit = c(NA, 100L),
 radius = c(NA, 500L)),
 .Names = c("longitude", "latitude", "limit", "radius"),
 class = "data.frame",
 row.names = 1:2)),
 .Names = "geolocations")

bulk_rev_geo <- bulk_reverse_geocoding(geolocations_list)

bulk_rev_geo[[1]]$result[[1]]

## -----------------------------------------------------------------------------
geolocations_df <- structure(
  list(
    longitude = c(-3.15807731271522, -1.12935802905177),
    latitude = c(51.4799900627036, 50.7186356978817),
    limit = c(NA, 100L),
    radius = c(NA, 500L)),
  .Names = c("longitude", "latitude", "limit", "radius"),
  row.names = 1:2,
  class = "data.frame")

geolocations_df

# turn a data frame into a list
geolocations_df2list <- list(geolocations_df)

# add a list name
names(geolocations_df2list) <- "geolocations"

# display correct input for the function
geolocations_df2list

## -----------------------------------------------------------------------------
# extract one postcode
bulk_rev_geo[[1]]$result[[8]]$postcode

## -----------------------------------------------------------------------------
# function to extract variables of interest
extract_bulk_geo_variable <- function(x) {
  bulk_results <- lapply(bulk_rev_geo, `[[`, "result")
  sapply(unlist(bulk_results, recursive = FALSE), `[[`, x)
}

# define the variables you need
variables_of_interest <- c("postcode", "latitude", "longitude")

# return a data frame with the variables
data.frame(
  sapply(variables_of_interest, extract_bulk_geo_variable))

## -----------------------------------------------------------------------------
out_rev_geocode <- outcode_reverse_geocoding("-3.15", "51.47")
# overview
str(out_rev_geocode[1])

## -----------------------------------------------------------------------------
# without restrictions
random_postcode()

## -----------------------------------------------------------------------------
# restrict to an outcode
random_postcode("N1")

## -----------------------------------------------------------------------------
random_place()

## -----------------------------------------------------------------------------
postcode_validation("EC1Y 8LX") # actual UK postcode

## -----------------------------------------------------------------------------
postcode_validation("XYZ") # incorrect UK postcode

## -----------------------------------------------------------------------------
postcode_autocomplete("EC1")

## -----------------------------------------------------------------------------
near_pc <- nearest_postcode("EC1Y 8LX")

#overview
str(near_pc[1])

## -----------------------------------------------------------------------------
near_outcode <- nearest_outcode("EC1Y")

# overview
str(near_outcode[2])

## -----------------------------------------------------------------------------
near_ll <- nearest_outcode_lonlat(0.127, 51.507)

#overview
str(near_ll[1])

## -----------------------------------------------------------------------------
place_query_result <- place_query("Hills", limit = 11)

# overview
str(place_query_result[1])

## -----------------------------------------------------------------------------
place_lookup_result <- place_lookup("osgb4000000074544700")

# overview
str(place_lookup_result)

## -----------------------------------------------------------------------------
terminated_postcode("E1W 1UU")

