#' upload-lots-of-data.R
#'
#' This is an example script for showing a way to quickly upload a large number
#' of data files to a DataONE Member Node with R. It's intended for
#' demonstration purposes.

library(dataone)
library(datapack)
library(arcticdatautils)

# Set up a connection to the Member Node
client <- D1Client("STAGING", "urn:node:mnTestARCTIC")

# Prepare a vector of filepaths for our data
files <- dir("~/tmp/data", pattern = "*.csv", full.names = TRUE)

# Upload each file
data_pids <- lapply(files, function(file) {
  cat(paste0("Uploading ", file, "\n"))

  my_object <- new("DataObject",
                   filename = file,
                   format = "text/csv")

  my_object <- setPublicAccess(my_object) # Make it public readable!

  uploadDataObject(client, my_object)
})

data_pids

# Find the data we just submitted
ti <- getTokenInfo(new("AuthenticationManager"))
me <- ti[which(ti$name == "dataone_test_token"),"subject"]

query <- paste0('q=id:*+AND+formatType:DATA+AND+submitter:"', me, '"&sort=dateUploaded+desc&rows=5&fl=identifier,fileName,size')
query(client@mn, query, as = "data.frame")
