% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/darch.Learn.R
\docType{methods}
\name{preTrainDArch,DArch-method}
\alias{preTrainDArch,DArch-method}
\title{Pre-trains a \code{\linkS4class{DArch}} network}
\usage{
\S4method{preTrainDArch}{DArch}(darch, dataSet, numEpochs = 1, numCD = 1,
  ..., lastLayer = 0)
}
\arguments{
\item{darch}{A instance of the class \code{\linkS4class{DArch}}.}

\item{dataSet}{\code{\linkS4class{DataSet}} to be used for training.}

\item{numEpochs}{The number of epochs}

\item{numCD}{The number of CD iterations}

\item{...}{Additional parameters for the function \code{\link{trainRBM}}}

\item{lastLayer}{Numeric indicating after which layer to stop training.}
}
\description{
Pre-trains a \code{\linkS4class{DArch}} network
}
\seealso{
\link{preTrainDArch}
}

