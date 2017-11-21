#untested setup for Linux
#download R for Linux
sudo apt-get update
sudo apt-get install r-base

#start R
R
install.packages("lidR")
# quit R
quit('no')

git clone https://github.com/SMHendryx/tileR

cd tileR

#Edit paths for your file and source call:
vim tileR_tests.R
#quit vim

# Run tileR_tests.R
Rscript tileR_tests.R
