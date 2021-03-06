% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/darchUnitFunctions.R
\name{softmaxUnitDerivative}
\alias{softmaxUnitDerivative}
\title{Softmax unit function with unit derivatives.}
\usage{
softmaxUnitDerivative(input, ...)
}
\arguments{
\item{input}{Input for the activation function.}
}
\value{
A list with the softmax activation in the first entry and the
derivative of the transfer function in the second entry
}
\description{
The function calculates the activation of the units and returns a list, in
which the first entry is the result through the softmax transfer function
and the second entry is the derivative of the transfer function.
}
\seealso{
\code{\linkS4class{DArch}}

Other DArch unit functions: \code{\link{linearUnitDerivative}};
  \code{\link{maxoutUnitDerivative}};
  \code{\link{rectifiedLinearUnitDerivative}};
  \code{\link{sigmoidUnitDerivative}};
  \code{\link{tanSigmoidUnitDerivative}}
}

