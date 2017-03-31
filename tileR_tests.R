# tileR tests
# Clear workspace:
rm(list=ls())
library(lidR)

setwd("/Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory")

tLidar = readLAS("Decimated_Cropped_SOR_Cleaned_CC-Default-tLidarSRERMesTowerOct2015.las")

source("/Users/seanhendryx/githublocal/tileR/tileR.R")

tileR(tLidar, c(4,5))
