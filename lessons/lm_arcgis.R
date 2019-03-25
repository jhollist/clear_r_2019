# Example script: how to work with spatial data using the arcgisbinding package.

# Load up the argisbinding package
library(arcgisbinding)

# Save the path to some example data
input_data <- "lessons/nla_wq.shp"

# Opens a spatial data file: works with feature classes, layers, raster, etc.
# Appears to be just pointers and basic info, not the actual data
d <- arc.open(input_data)

# This actually pulls data into R from the input data source. Result is a data 
# frame with spatial details stuck on at the end there are functions to convert 
# from this "arc.data" object to more R native formats (e.g arc.data2sf())
d_sel <- arc.select(d)

# d_sel is a data frame so we have access to the data in it to do want we want
# inside of R.  we can for instance, fit a linear model and add predictions from
# that model back onto the data frame
xlm <- lm(d_sel[[y]] ~ log10(d_sel[[x]]))
d_sel$lm_pred <- predict(xlm)

# With our predictions saved, let's write back to the original
arc.write(input_data, d_sel, overwrite = TRUE)
