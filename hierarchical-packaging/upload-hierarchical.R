#' upload-hierarchical.R
#'
#' This is a minimal example of one way you could upload all of the data and
#' metadata for a hierarchical set of packages. I made some fake data which
#' looks like this:
#'
#' Parent
#'   - A
#'   - B
#'   - C
#'
#' which has just two levels of hierarchy. Each site (A, B, and C) have a
#' single data file and the Parent contains the site-level packages.
#'
#' The script follows a simple flow:
#'
#'  1. Setup
#'  2. Upload data
#'  3. Upload metadata
#'  4. Upload resource maps
#'

# Setup
library(dataone)
library(EML)
library(arcticdatautils) # For generate_resource_map

# Set up MN
cn <- CNode("STAGING")
mn <- getMNode(cn, "urn:node:mnTestARCTIC")

# Load metadata file
metadata <- read.csv("./site_metadata.csv", stringsAsFactors = FALSE)

# Pre-generate pids
# We do this mainly because we need the data and metadata PIDs for
# generating the resource maps in the end and we can pre-compute them
metadata$metadata_pid <- vapply(seq_len(nrow(metadata)), function(i) {
  paste0("urn:uuid:", uuid::UUIDgenerate())
}, "")

metadata$data_pid <- vapply(seq_len(nrow(metadata)), function(i) {
  paste0("urn:uuid:", uuid::UUIDgenerate())
}, "")

metadata$resource_map_pid <- vapply(seq_len(nrow(metadata)), function(i) {
  paste0("urn:uuid:", uuid::UUIDgenerate())
}, "")

# Upload data
for (i in which(!is.na(metadata[,"data_path"]))) {
  data_sysmeta <- new("SystemMetadata")
  data_sysmeta@identifier <- metadata[i,"data_pid"]
  data_sysmeta@formatId <- "text/csv"
  data_sysmeta@size <- file.size(metadata[i,"data_path"])
  data_sysmeta@checksum <- digest::digest(metadata[i,"data_path"], algo = "md5", file = TRUE)
  data_sysmeta@checksumAlgorithm <- "MD5"
  data_sysmeta@rightsHolder <- "http://orcid.org/0000-0002-0381-3766"
  data_sysmeta <- datapack::addAccessRule(data_sysmeta, "public", "read")
  data_sysmeta@fileName <- basename(metadata[i,"data_path"])

  response <- createObject(mn,
                           pid = data_sysmeta@identifier,
                           file = metadata[i,"data_path"],
                           sysmeta = data_sysmeta)

  cat(paste0(response, "\n"))
}

# Generate and upload metadata
for (i in seq_len(nrow(metadata))) {


  site_cov <- set_coverage(beginDate = as.character(metadata[i,"year_start"]),
                           endDate = as.character(metadata[i,"year_end"]),
                           geographicDescription = paste0("Geographic area for site ", metadata[i,"site"]),
                           westBoundingCoordinate = metadata[i,"lon_w"],
                           eastBoundingCoordinate = metadata[i,"lon_e"],
                           northBoundingCoordinate = metadata[i,"lat_n"],
                           southBoundingCoordinate =metadata[i,"lat_s"])
  # Generate EML
  dataset <- new("dataset",
                 title = metadata[i,"title"],
                 creator = as.person("Bryce Mecum <mecum@nceas.ucsb.edu>"),
                 coverage = site_cov,
                 contact = as.person("Bryce Mecum <mecum@nceas.ucsb.edu>"))

  eml <- new("eml",
             packageId = metadata[i,"metadata_pid"],
             system = "uuid",
             dataset = dataset)

  metadata_path <- tempfile()
  write_eml(eml, metadata_path)

  # Upload EML
  metadata_sysmeta <- new("SystemMetadata")
  metadata_sysmeta@identifier <- metadata[i,"metadata_pid"]
  metadata_sysmeta@formatId <- "eml://ecoinformatics.org/eml-2.1.1"
  metadata_sysmeta@size <- file.size(metadata_path)
  metadata_sysmeta@checksum <- digest::digest(metadata_path, algo = "md5", file = TRUE)
  metadata_sysmeta@checksumAlgorithm <- "MD5"
  metadata_sysmeta@rightsHolder <- "http://orcid.org/0000-0002-0381-3766"
  metadata_sysmeta <- datapack::addAccessRule(metadata_sysmeta, "public", "read")
  metadata_sysmeta@fileName <- "science_metadata.xml"

  response <- createObject(mn,
                           pid = metadata_sysmeta@identifier,
                           file = metadata_path,
                           sysmeta = metadata_sysmeta)

  cat(paste0(response, "\n"))
}


# Generate and upload resource maps
for (d in sort(unique(metadata$depth), decreasing = TRUE)) {
  cat(paste0("Processing depth level ", d, "\n"))

  for (i in which(metadata$depth == d)) {
    cat(paste0("  Processing site ", metadata[i,"site"], "\n"))

    args <- list(metadata_pid = metadata[i,"metadata_pid"],
                 resource_map_pid = metadata[i,"resource_map_pid"])

    # Add data if needed
    if (!is.na(metadata[i,"data_path"])) {
      args[["data_pids"]] <- metadata[i,"data_pid"][[1]]
    }

    # Add child packages if needed
    children_rows <- which(metadata$parent == metadata[i,"id"][[1]])

    if (length(children_rows) > 0) {
      args[["child_pids"]] <- metadata[children_rows,"resource_map_pid"]
    }

    ore_path <- do.call(generate_resource_map, args)

    ore_sysmeta <- new("SystemMetadata")
    ore_sysmeta@identifier <- metadata[i,"resource_map_pid"]
    ore_sysmeta@formatId <- "http://www.openarchives.org/ore/terms"
    ore_sysmeta@size <- file.size(ore_path)
    ore_sysmeta@checksum <- digest::digest(ore_path, algo = "md5", file = TRUE)
    ore_sysmeta@checksumAlgorithm <- "MD5"
    ore_sysmeta <- datapack::addAccessRule(ore_sysmeta, "public", "read")
    ore_sysmeta@fileName <- "resource_map.xml"

    createObject(mn,
                 pid = ore_sysmeta@identifier,
                 file = ore_path,
                 sysmeta = ore_sysmeta)
  }
}
