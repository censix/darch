% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/errorFunctions.R
\name{mseError}
\alias{mseError}
\title{Mean squared error function}
\usage{
mseError(original, estimate)
}
\arguments{
\item{original}{The original data matrix}

\item{estimate}{The calculated data matrix}
}
\value{
A list with the name of the error function in the first entry and the
error value in the second entry
}
\description{
The function calculates the mean squared error (MSE) from the \code{original}
and \code{estimate} parameters.
}
\seealso{
Other error functions: \code{\link{crossEntropyError}};
  \code{\link{quadraticError}}
}

