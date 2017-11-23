#cd /Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory/tiles
ls /Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory/tiles/*.las >/Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory/las_file_list.txt

cd /Applications/LAStools/bin
wine lasmerge -lof  /Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory/tiles/las_file_list.txt -o /Users/seanhendryx/DATA/Lidar/SRER/maxLeafAreaOctober2015/inputData/outputDirectory/tiles/merged.las