# ===============================================================================
#
# Author: Sean Hendryx
#
# seanmhendryx@email.arizona.edu  -  https://github.com/SMHendryx/tileR
#
# COPYRIGHT:
# Copyright 2017 Sean M. Hendryx
#
#
# tileR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
#
# ===============================================================================

# This implementation depends on the lidR R package.
library(lidR)

# implementation expects an LAS object from lidR, e.g. las = readLAS("path/to/some/lidar/file"), 
# though the underlying logic could be applied to any point cloud with 3 dimensions or more

tileR <- function(las, catalogDimensions){
  # :Param las: las file as lidR LAS object
  # :Param catalogDimensions: tuple of length 2 giving number of desired rows by number of desired columns, e.g.: (numRows, numColumns)
  # Saves each las tile as an las file to disk in current working directory
  
  #catalogDimenions should be 2D:
  if(length(catalogDimensions !=2)){
    stop("catalogDimenions must equal 2")
  }
  
  #extent:
  minX = min(las@data[,X])
  maxX = max(las@data[,X])
  minY = min(las@data[,Y])
  maxY = max(las@data[,Y])
  
  #Compute height and width:
  h = maxY - minY
  w = maxX - minX


  #numTiles = prod(catalogDimensions)
  #compute column and row widths:
  stepX = w/catalogDimensions[1]
  stepY = h/catalogDimensions[2]

  minY_i = minY
  minX_i = minX_i
  tileNum = 1
  for(i_column in seq(numTiles)){
    #compute the borders of each column:
    maxX_i = minX_i + stepX
    col_i_points = LAS(las@data[X >= minX_i & X <= maxX_i])
    for(i_row in seq(numTiles)){
      maxY_i = minY_i + stepY
      tile_i_points = LAS(col_i_points@data[Y >= minY_i & Y <= maxY_i])
      writeLAS(tile_i_points, paste0("tile-", tileNum))
      tileNum = tileNum + 1
    }
  }
}