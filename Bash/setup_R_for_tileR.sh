# install for ubuntu
#download R for Linux
# update the list of available packages:
sudo apt-get update

sudo apt-get -y install r-base
sudo apt-get -y install r-base-dev
#Change permissions (may or may not be necessary, depending on your permissions configs):
sudo chmod -R 777 /usr/local/lib/R/site-library
sudo chmod -R 777 /usr/lib/R
sudo chmod -R 777 /usr/local/lib/R

#Dependencies for lidR on ubuntu
sudo apt-get install libcgal-dev libglu1-mesa-dev libglu1-mesa-dev
sudo apt-get install libx11-dev

sudo apt-get install fftw3 fftw3-dev pkg-config

sudo apt-get install apt-file
apt-file update

sudo apt-get update && sudo apt-get install libgdal-dev libproj-dev

R

install.packages("devtools")
devtools::install_github("Jean-Romain/rlas", dependencies=TRUE)
#devtools::install_github("krahim/fftwtools", dependencies = TRUE)
devtools::install_github("Jean-Romain/lidR", dependencies=TRUE)

# quit R
quit('no')

git clone https://github.com/SMHendryx/tileR

cd tileR

#Edit paths for your file and source call:
vim tileR_tests.R
#quit vim

# Run tileR_tests.R
Rscript tileR_tests.R
