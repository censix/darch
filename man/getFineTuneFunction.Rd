% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/darch.Getter.R
\name{getFineTuneFunction}
\alias{getFineTuneFunction}
\title{Returns the fine tune function for the \code{\linkS4class{DArch}} object}
\usage{
getFineTuneFunction(darch)
}
\arguments{
\item{darch}{An instance of the class \code{\linkS4class{DArch}}.}
}
\value{
Fine-tune function of the \code{\linkS4class{DArch}} object.
}
\description{
Returns the fine tune function which is executed by the function
\code{\link{fineTuneDArch}}.
}
\seealso{
\code{\linkS4class{DArch}}, \code{\link{backpropagation}},
  \code{\link{rpropagation}}, \code{\link{minimizeAutoencoder}},
  \code{\link{minimizeClassifier}}
}

