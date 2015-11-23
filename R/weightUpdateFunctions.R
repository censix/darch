# Copyright (C) 2013-2015 Martin Drees
#
# This file is part of darch.
#
# darch is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# darch is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with darch. If not, see <http://www.gnu.org/licenses/>.

#' Updates the weight using weight decay.
#' 
#' Multiplies the weights by (1 - \code{weightDecay}) before applying the
#' scheduled weight changes.
#' 
#' @param darch \linkS4class{DArch} instance.
#' @param layerIndex Layer index within the network.
#' @param weightsInc Matrix containing scheduled weight updates from the
#'  fine-tuning algorithm.
#' @param biasesInc Bias weight updates.
#' @param weightDecay Weights are multiplied by (1 - \code{weightDecay}) before
#'  each update. Corresponds to the \code{darch.weightDecay} parameter of
#'  \link{darch.default}.
#' @return updated \linkS4class{DArch} instance
#' @export
weightDecayWeightUpdate <- function(darch, layerIndex, weightsInc, biasesInc)
{
  weights <- getLayerWeights(darch, layerIndex)
  
  biases <- weights[nrow(weights),, drop = F]
  weights <- weights[1:(nrow(weights)-1),, drop = F]
  
  weights <- (weights * (1 - darch@weightDecay) + weightsInc)
  biases <- (biases * (1 - darch@weightDecay) + biasesInc)
  setLayerWeights(darch, layerIndex) <- rbind(weights, biases)
  
  return (darch)
}

#' Updates the weight on maxout layers
#' 
#' On maxout layers, only the weights of active units are altered, additionally
#' all weights within a pool must be the same.
#' 
#' @param darch \linkS4class{DArch} instance.
#' @param layerIndex Layer index within the network.
#' @param weightsInc Matrix containing scheduled weight updates from the
#'  fine-tuning algorithm.
#' @param biasesInc Bias weight updates.
#' @param weightDecay Weights are multiplied by (1 - \code{weightDecay}) before
#'  each update. Corresponds to the \code{darch.weightDecay} parameter of
#'  \link{darch.default}.
#' @return updated \linkS4class{DArch} instance
#' @export
maxoutWeightUpdate <- function(darch, layerIndex, weightsInc, biasesInc,
  poolSize = mget(c("darch.layerFunction.maxout.poolSize"), darch.env,
                  ifnotfound=2)[[1]])
{
  weights <- getLayerWeights(darch, layerIndex)
  
  biases <- weights[nrow(weights),, drop = F]
  weights <- weights[1:(nrow(weights)-1),, drop = F]
  
  ncols <- ncol(weights)
  nrows <- nrow(weights)
  
  # Abort if number of neurons in the current layer invalid
  # TODO: check this once at the start of the network setup, not each time
  if (nrows %% poolSize != 0)
  {
    flog.error(paste("Number of neurons in the current layer not divisible",
                     "by pool size (%d %% %d)"), nrows, poolSize)
    stop("Unrecoverable error, aborting.")
  }
  
  # if this is the first pass and poolSize is greater than 1
  # TODO: is poolSize = 1 allowed?
  if (!all(weights[1,] == weights[poolSize,]))
  {
    # Walk through the pools, set all weights within each pool to be the same
    for (i in 1:(nrows / poolSize))
    {
      poolStart <- poolSize * (i - 1) + 1
      poolEnd <- poolStart + (poolSize - 1)
      randomRow <- sample(poolStart:poolEnd, 1)
      
      weights[poolStart:poolEnd,] <- matrix(rep(weights[randomRow,], poolSize),
                                            nrow=poolSize, byrow=T)
    }
  }
  
  # Walk through the pools to change the weight increment
  for (i in 1:(nrows / poolSize))
  {
    poolStart <- poolSize * (i - 1) + 1
    poolEnd <- poolStart + (poolSize - 1)
    
    weightsInc[poolStart:poolEnd,] <-
      matrix(rep(colSums(weightsInc[poolStart:poolEnd,, drop=F]), poolSize),
                 nrow=poolSize, byrow=T)
  }
  
  weights <- (weights * (1 - darch@weightDecay) + weightsInc)
  biases <- (biases * (1 - darch@weightDecay) + biasesInc)
  setLayerWeights(darch, layerIndex) <- rbind(weights, biases)
  
  return (darch)
}