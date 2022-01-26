
get_species_list <- function(pattern = NULL,
                             dir = "big_data/species_ranges"){
        gsub("\\.tif", "", list.files(dir, pattern))
}

derive_diversity <- function(species){
        require(raster)
        
        # create raster stack of files for selected species
        f <- list.files("big_data/species_ranges", full.names = T)
        f <- f[gsub("\\.tif", "", basename(f)) %in% species]
        s <- stack(f)
        
        # sum to calculate diversity
        d <- sum(s)
        return(d)
}

# example
library(raster)
library(tidyverse)
oak_diversity <- "Quercus" %>% get_species_list() %>% derive_diversity()
plot(oak_diversity)
