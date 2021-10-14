## Purpose:
## Iterate through a folder of EEMs outputs, collect indices, and export them all together as a csv
##
## Packages Required: 
## tidyselect, dplyr, purrr, eemR, DT
##
## Written: 
## Emily Deardorff 7/23/2019 (emily.deardorff@gmail.com)
##
## Last Updated: 
## Emily Deardorff 7/23/2019


# ********************************************************************
# Enter your data folder path name and name your output csv below:

# Note:
# All outputs (PEM, ABS, etc.) can be in the this folder. The CSV will be put in this folder as well.
# If you are using Windows, make sure to use double backslashes (\\).
# File naming conventions are different for iOS, so the code won't immediately work on Macs.

path = "C:\\Users\\Emily\\Documents\\2019 Summer at UDel\\DATA_EEMs_Jul29\\Deardorff_7.29.19\\"
csvname = "6.19_ReDiluted_KCWTP_Indices.csv"

# Once you have filled in these two variables, run the code below all at once.
# ********************************************************************


# Open packages
library(tidyselect)
library(dplyr)
library(purrr)
library(eemR)
library(DT)

# Creates blank dataframe for results
out.file <- data.frame(matrix(ncol = 9, nrow = 0)) #create blank file object
x <- c("sample", "coble_b", "coble_t", "coble_a", "coble_m", "coble_c","fi", "hix", "bix")
colnames(out.file) <- x

# Creates list of PEM files
file.names <- dir(path, pattern ="PEM.csv") #change to PEM.csv if your EEMs outputs are in .csv 


# Loops through PEM files, extracting indices and coble peaks
for(i in 1:length(file.names)){
  file <- paste(path, file.names[i], sep = "")
  print(file)
  eems <- eem_read(file, import_function = "aqualog") #read the EEM data
  
  coble <- data.frame(eem_coble_peaks(eems, verbose = FALSE))
  fi <- data.frame(eem_fluorescence_index(eems, verbose = FALSE))
  hi <- data.frame(eem_humification_index(eems, verbose = FALSE))
  bi <- data.frame(eem_biological_index(eems, verbose = FALSE)) 
  
  newDF <- data.frame("sample" = coble$sample, 
                      "coble_b" = coble$b, 
                      "coble_t" = coble$t, 
                      "coble_a" = coble$a, 
                      "coble_m" = coble$m, 
                      "coble_c" = coble$c, 
                      "fi" = fi$fi, 
                      "hix" = hi$hix, 
                      "bix" = bi$bix)
  out.file <- rbind(out.file, newDF)
  }

# Sets up output file path for indices csv
out.file.path = paste(path, csvname, sep = "")

# Writes csv file of indices
write.csv(out.file, file = out.file.path)

# CSV written. Processing complete.
