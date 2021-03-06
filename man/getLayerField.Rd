% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/darch.Getter.R
\name{getLayerField}
\alias{getLayerField}
\title{Returns the field of a layer from the \code{\linkS4class{DArch}} object}
\usage{
getLayerField(darch, layerIndex = 1, fieldIndex = 3)
}
\arguments{
\item{darch}{A instance of the class \code{\linkS4class{DArch}}.}

\item{layerIndex}{The index of the layer.}

\item{fieldIndex}{The index of the field in the layer.}
}
\value{
A content of the layer field.
}
\description{
The function returns the field given by the \code{fieldIndex} of the layer
given by the \code{layerIndex}.
}
\seealso{
\code{\linkS4class{DArch}}
}

