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
  # Saves each las tile as an las file to disk in current working directory
  # :Param las: las file as lidR LAS object
  # :Param catalogDimensions: tuple of length 2 giving number of desired rows by number of desired columns, e.g.: (numRows, numColumns)

  
  #catalogDimenions should be 2D:
  if(length(catalogDimensions) != 2){
    stop("catalogDimenions must be vector of length 2")
  }
  
  #get header info:
  # see: https://github.com/Jean-Romain/lidR/issues/54
  oheader <- las@header

  #X extents:
  minX = min(las@data[,X])
  maxX = max(las@data[,X])
  
  #Compute width:
  w = maxX - minX
  
  #numTiles = prod(catalogDimensions)
  numRows = catalogDimensions[1]
  numColumns = catalogDimensions[2] 
  #compute column (stepX) widths:
  stepX = w/numColumns
  
  #minY_i = minY
  minX_column = minX
  tileNum = 1

  for(i_column in seq(numColumns)){
    #compute the borders of each column:
    maxX_column = minX_column + stepX

    #make the column of points:
    col_i_points = LAS(las@data[X >= minX_column & X <= maxX_column])
    #plot(col_i_points)
    # Find the minimum Y coordinate of the column of points:
    minY = min(col_i_points@data[,Y])
    #instantiate the minimum of the tile:
    minY_tile = minY
    maxY = max(col_i_points@data[,Y])
    #stop("column should be plotted")
    #height of column:
    h = maxY - minY
    #height of each tile in the column:
    stepY = h/numRows
    #then from the column pull the row to make the tile:
    for(i_row in seq(numRows)){
      #Set Y bounds of tile:
      maxY_tile = minY_tile + stepY

      #Select the points that go into the tile:
      tile_i_points = LAS(col_i_points@data[Y >= minY_tile & Y <= maxY_tile], oheader)
      #plot(tile_i_points)
      #write to disk:
      writeLAS(tile_i_points, paste0("tile-", tileNum, ".las"))
      #stop("should have written tile-1.las")
      
      #increment minY_i:
      minY_tile = maxY_tile 
      tileNum = tileNum + 1
    }

    #increment minX_column:
    minX_column = maxX_column
  }
}