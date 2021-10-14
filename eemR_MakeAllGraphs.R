## Purpose:
## Iterate through a folder of EEMs PEM outputs and plot each of them into the 'Plots' pane
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
# Enter your data folder path name below:

# Note:
# All outputs (PEM, ABS, etc.) can be in the this folder.
# If you are using Windows, make sure to use double backslashes (\\).
# File naming conventions are different for iOS, so the code won't immediately work on Macs.

path = "C:\\Users\\Emily\\Documents\\2019 Summer at UDel\\EEMs_Update\\Pretty_EEMs\\"

# Once you have filled in this filepath, run the code below all at once.
# ********************************************************************


# Open packages
library(tidyselect)
library(dplyr)
library(purrr)
library(eemR)
library(DT)

# Creates list of PEM files
file.names <- dir(path, pattern ="PEM.csv") # Change to PEM.csv if your EEMs outputs are in .csv, or 
# keep as PEM.dat if you haven't converted your outputs 

# Loops through PEM files, creating a graph in RStudio Plots pane
for(i in 1:length(file.names)){
  file <- paste(path, file.names[i], sep = "")
  print(file)
  eems <- eem_read(file, import_function = "aqualog") #read the EEM data
  plot(eems, which = 1)
}


# Plots created.
