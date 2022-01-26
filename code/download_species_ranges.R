# this script:
# creates a directory in the repo called big_data, which is gitignored
# downloads zipfiles containing species range rasters for all CA plants
# unzips these into a species_ranges subdirectory of big_data
# deletes the zip files

download_species_ranges <- function(dir = "big_data"){
        
        dir.create(dir)
        dir.create(paste0(dir, "/species_ranges"))
        
        urls <- c("https://github.com/matthewkling/facets-of-phylodiversity/releases/download/data810m/ranges_A-D.zip",
                  "https://github.com/matthewkling/facets-of-phylodiversity/releases/download/data810m/ranges_E-M.zip",
                  "https://github.com/matthewkling/facets-of-phylodiversity/releases/download/data810m/ranges_N-Z.zip")
        
        dl_uz <- function(url){
                path <- paste0(dir, "/", basename(url))
                download.file(url, path)
                unzip(path, exdir = paste0(dir, "/species_ranges"))
                file.remove(path)
                
                subd <- gsub("\\.zip", "", basename(url))
                f <- list.files(paste0(dir, "/species_ranges/", subd), full.names = T)
                file.rename(f, sub(paste0(subd, "/"), "", f))
                file.remove(paste0(dir, "/species_ranges/", subd))
        }
        
        lapply(urls, dl_uz)
}

download_species_ranges()
