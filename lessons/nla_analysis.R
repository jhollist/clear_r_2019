# 2007 NLA Analysis

################################################################################
# Purpose: The purpose of this document is to serve as motivating example (R
# and Open data are cool!), but will also serve to structure the rest of this
# workshop in that we will see how to work with and visualize data in R, use 
# scripts, and  (if time) introduce The Tidyverse
# (https://tidyverse.org) which is an opinionated (but effective) way to think
# about organizing and analyzing data in R.  To accomplish this, we will be 
# using data from the 2007 National Lakes Assessment data as it provides a nice 
# water quality relevant example and I am quite familiar with it so I already 
# know most of the issues we will run into!

################################################################################
# Install packages, if needed: This is fancier than it normally needs to be.  It
# checks to make sure that packages are installed and installs if they aren't
# then loads it up.  You would normally be able to install each package 
# separately with install.packages("nameofpackage").  This is done to speed 
# things along.  Also packages are installed infrequently so I rarely include 
# package installs in a script.  Needed to do it for this example to ensure that
# the script ran on y'alls machines.

pkgs <- c("dplyr", "readr", "sf", "mapview")
for(i in pkgs){
  if(!i %in% installed.packages()){
    install.packages(i)
  }
}

################################################################################
# Load up packages in R session

library(dplyr)
library(readr)
library(sf)
library(mapview)

################################################################################
# Get Data: The data we need is available from the National Aquatic Resource
# Survey's website First we can get the dataset that we have saved as a `.csv`
# in this repository.

nla_wq_all <- read_csv("nla2007_chemical_conditionestimates_20091123.csv")

################################################################################
# Manipulate Data: Let's tidy up this dataset by turning all column names to
# lower case (Jeff likes it that way), convert all text in the dataset to lower
# case (again Jeff likes it like that way and it is kind of a hot mess
# otherwise), filter out just the probability samples and the first visits, and
# select a subset of columns.

nla_wq <- nla_wq_all %>%
  rename_all(tolower) %>% #making all names lower case beucase they are a mess!
  mutate_if(is.character, tolower) %>%
  filter(site_type == "prob_lake",
         visit_no == 1) %>%
  select(site_id, lat_dd, lon_dd, st, epa_reg, wsa_eco9, ptl, ntl, turb, chla, doc)

nla_wq

################################################################################
# Spatial Data:  Since our focus is working with spatial data, we need to 
# convert the dataset, known in R as a data frame, into a spatial data 
# structure. We will use the sf package for that.

nla_wq_sf <- st_as_sf(nla_wq, coords = c("lon_dd", "lat_dd"),
                      crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")


mapview(nla_wq_sf, zcol = "chla", cex = log1p(nla_wq_sf$chla))

################################################################################
# Write to ESRI format: There are many options to both read and write spatial 
# data formats.  The shapefile is pretty easy so we will use that here.  You can
# read file geodatabase and, with the ESRI FileGDB SDK you can also write them.  
# There are other formats as well such as geoPackage, geojson, etc.  
# See <https://geocompr.robinlovelace.net/read-write.html#file-formats> for more.

st_write(nla_wq_sf, "nla_wq.shp")




