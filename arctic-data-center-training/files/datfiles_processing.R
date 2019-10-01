#Processing Cook Inlet files
#Jeanette Clark
#June 20 2018

library(stringi)
library(tidyr)
library(dplyr)

# Get a list of filenames to loop through and process
files <- dir("~/Desktop/datfiles/original", full.names = T, include.dirs = F)

# Get a list of filenames with .csv extension to write to, and accounting for multiple capitalization schemes in the .dat extension.
file_names <- gsub(".dat", ".csv", tolower(dir("~/Desktop/datfiles/original")))

# Start loop through files
for (i in 1:length(files)){
    
    # read in text files using scan, which returns a vector with each line as a sigle string
    # we have to use scan here because there aren't the same amount of columns in each row
    t <- scan(files[i], what = 'character', sep = '\n', quiet = T)
    # remove problematic double spaces
    t <- gsub("  ", " ", t)
    # remove problematic end of file lines, if they exist
    z <- grep("\032", t)
    if (length(z) > 0){
        t <- t[-z]
    }
    
    # start of if statement which only processes file if the header looks like this:
    if (t[1] == "yr month day set station air water temp wind vel dir tide sal set angle water depth secchi fathoms mft" &
        t[2] == "sockeye catch index length weight pink chum coho and chinook etc.") {
        
        # select odd rows for conditions
        t_conditions <- t[c(T,F)]
        # select even rows for samples
        t_samples <- t[c(F,T)]
        # If logical vectors are used for indexing in R, their values are recycled if the index vector is shorter than the vector containing the values.
        
        # separate the single string into columns using a single space as the delimiter and convert to dataframe
        t_conditions <- stri_split_fixed(t_conditions, pattern = " ", simplify = T)
        t_conditions <- as.data.frame(t_conditions, stringsAsFactors = F)
        
        # create more logical column name vector based on what was in the header row
        # you probably want to double check this, some of the columns were a little confusing. especially "set", "set_angle", "secchi", "fathoms", and "mft"
        col_names <- c("yr", "month", "day", "set", "station", "air_temp", "water_temp", "wind_vel", "wind_dir", "tide", "sal", "set_angle", "water_depth", "secchi", "fathoms", "mft")
        
        # some files have problematic spaces at the end of lines, creating empty columns. The amount of empty columns vary, and we have to name them,
        # so here we count the number of stray columns and create names for them based on the pattern z1, z1, etc, which makes them easy to remove later
        n_c <- ncol(t_conditions)
        if (n_c > 16){
            n <- n_c -16
            col_ext <- paste0("z", seq(1:n))
            col_names <- c(col_names, col_ext)
        }
        
        # assign column names
        names(t_conditions) <- col_names
        
        # remove stray columns, and remove first row of data which was originally the header row
        t_conditions <- t_conditions %>% 
            select(-starts_with("z")) %>% 
            filter(yr != "yr")
        
        # similar splitting and column renaming for the sample lines
        t_samples <- stri_split_fixed(t_samples, pattern = " ", simplify = T)
        t_samples <- as.data.frame(t_samples, stringsAsFactors = F)
        
        col_names <- c("sockeye.catch", "sockeye.index", "sockeye.length", "sockeye.weight", 
                       "pink.catch", "pink.index", "pink.length", "pink.weight",
                       "chum.catch", "chum.index", "chum.length", "chum.weight",
                       "coho.catch", "coho.index", "coho.length", "coho.weight",
                       "chinook.catch", "chinook.index", "chinook.length", "chinook.weight")
        
        n_c <- ncol(t_samples)
        if (n_c > 20){
            n <- n_c - 20
            col_ext <- paste0("z", seq(1:n))
            col_names <- c(col_names, col_ext)
        }
        
        
        names(t_samples) <- col_names
        
        t_samples <- t_samples %>% 
            select(-starts_with("z")) %>%
            filter(sockeye.catch != "sockeye")
        
        # bind the sample and conditions data together
        # use a combination of gather and spread to get the catch, index, weight, length by species
        # filter out rows where both the catch and index are 0 (no meaningful data)
        d <- cbind(t_samples, t_conditions) %>% 
            gather(key = "sample_type", value = "number", sockeye.catch:chinook.weight) %>% 
            separate(sample_type, c("species", "variable")) %>% 
            spread(key = "variable", value = "number") %>% 
            filter(catch != 0 | index != 0)
        
        # write csv for each file
        # the "reformatted" directory needs to exist prior to running this
        write.csv(d, file.path("/Users/clark/Desktop/datfiles/reformatted", file_names[i]), row.names = F)
    }
    else {
        print(paste0(files[i], " - Inconsistent Header"))
        print(t[1])
        print(t[2])
    }
    
}



# get list of formatted files
files_reformatted <- dir("/Users/clark/Desktop/datfiles/reformatted/", full.names = T)

# read from list of files, and bind together
CI_ASL <- do.call(rbind,
                  lapply(files_reformatted,
                         read.csv, 
                         stringsAsFactors = F))

# from here, more QA is needed
# It looks like -1 is a missing value code (or might be), and 0 might also be a missing value code (in the length column for example)
    # both of those should be replaced with NA
# year format is inconsistent (2 digit and 4 digit)
