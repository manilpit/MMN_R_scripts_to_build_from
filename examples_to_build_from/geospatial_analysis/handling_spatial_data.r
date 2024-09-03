# Install and load necessary packages
install.packages(c("sf", "ggplot2", "tmap"))
library(sf)        # For reading and writing shapefiles
library(ggplot2)   # For mapping spatial data with geom_sf()
library(tmap)      # For advanced thematic mapping


#------------------------------------------------------------

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### 1. Reading Shapefiles Using `sf::st_read()`

# Example: Reading a shapefile of a country's administrative boundaries
# Replace "your_shapefile.shp" with the actual path to your shapefile
shapefile_path <- "your_shapefile.shp"  # Example: "data/countries.shp"
spatial_data <- st_read(shapefile_path)

# Print a summary of the spatial data
print("Summary of Spatial Data:")
print(summary(spatial_data))

# View the first few rows of the spatial data
print("First Few Rows of Spatial Data:")
print(head(spatial_data))

### 2. Writing Shapefiles Using `sf::st_write()`

# Example: Writing the spatial data to a new shapefile
output_shapefile_path <- "output_shapefile.shp"  # Specify output file path
st_write(spatial_data, output_shapefile_path)

print(paste("Shapefile has been written to:", output_shapefile_path))
