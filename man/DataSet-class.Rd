% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/dataset.R
\docType{class}
\name{DataSet-class}
\alias{DataSet}
\alias{DataSet-class}
\alias{dataset}
\title{Class for specifying datasets.}
\description{
Class for specifying datasets.
}
\details{
This class deals with data (input) and targets (output) for neural
networks, including conversion of ordinal and nominal data, validation of
data, and application of model formulae to the data.
}
\section{Slots}{

\describe{
\item{\code{data}}{Input data.}

\item{\code{targets}}{Target output.}

\item{\code{formula}}{\code{\link{formula}} for the data.}

\item{\code{parameters}}{Fit parameters.}
}}

