% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/rbm.Learn.R
\docType{methods}
\name{trainRBM,RBM-method}
\alias{trainRBM,RBM-method}
\title{Trains a \code{\link{RBM}} with contrastive divergence}
\usage{
\S4method{trainRBM}{RBM}(rbm, trainData, numEpochs = 1, numCD = 1, ...)
}
\arguments{
\item{rbm}{A instance of the class \code{\link{RBM}}.}

\item{trainData}{The data matrix for the training}

\item{numEpochs}{The number of training iterations}

\item{numCD}{Number of contrastive divergence iterations}

\item{...}{Additional parameters for the unit functions}
}
\description{
Trains a \code{\link{RBM}} with contrastive divergence
}
\seealso{
\link{trainRBM}
}

