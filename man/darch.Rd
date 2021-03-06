% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/interface.R
\name{darch}
\alias{darch}
\title{Fit a deep neural network.}
\usage{
darch(x, ...)
}
\arguments{
\item{x}{Input data.}

\item{...}{additional parameters, see \link{darch.default}}
}
\value{
Fitted \code{\linkS4class{DArch}} instance
}
\description{
Fit a deep neural network with optional pre-training and one of various
fine-tuning algorithms. See \link{darch.default} for a full list of
parameters.
}
\details{
The darch package implements Deep Architecture Networks and restricted
Boltzmann machines.

The creation of this package is motivated by the papers from G. Hinton et.
al. from 2006 (see references for details) and from the MATLAB source code
developed in this context. This package provides the possibility to generate
deep architecture networks (darch) like the deep belief networks from Hinton
et. al.. The deep architectures can then be trained with the contrastive
divergence method. After this pre-training it can be fine tuned with several
learning methods like backpropagation, resilient backpropagation and
conjugate gradients as well as more recent techniques like dropout and
maxout.

See \url{https://github.com/maddin79/darch} for further information,
documentation, and releases.

\tabular{ll}{ Package: \tab darch\cr Type: \tab Package\cr Version: \tab
0.10.0\cr Date: \tab 2015-11-12\cr License: \tab GPL-2 or later\cr
LazyLoad: \tab yes\cr }
}
\examples{
# Load darch examples by typing
#
#   example("darch")
#
# and then execute them by typing, e.g.
#
#   darch <- example.xor()
#
# More examples can be found on
# https://github.com/maddin79/darch/tree/master/examples/

##
# Example #1: Minimal XOR example with a custom weight generation function.
##

# Exemplary custom generate weight function
genWeightsExample <- function (numUnits1, numUnits2)
{
  generateWeightsRunif(numUnits1, numUnits2, weights.min=-.1, weights.max=.1)
}

# Simply call example.xor() after executing example("darch") or manually
# sourcing this function
example.xor <- function()
{
  # dataset
  trainData <- matrix(c(0,0,0,1,1,0,1,1), ncol = 2, byrow = TRUE)
  trainTargets <- matrix(c(0,1,1,0), nrow = 4)
  
  darch <- darch(trainData, trainTargets,
    # We don't need pre-training for this problem
    rbm.numEpochs = 0,
    # Small net so solve XOR
    layers = c(2,10,1),
    darch.batchSize = 1,
    # Bootstrapping would create a training and validation set from the training
    # data, we don't want that here
    darch.bootstrap = F,
    # The default function is generateWeights, we use the custom function above
    darch.genWeightFunc = genWeightsExample,
    # The defaults are 0.8, for this simple problem we can go a little higher
    darch.learnRate = 5,
    # stop when the network classifies all of the training examples correctly.
    darch.stopClassErr = 0,
    # the problem is usually solved within much less than 1000 epochs
    darch.numEpochs = 1000
  )
  
  # prints all parameters and stats
  print(darch)
  
  # check the performance of our network
  predictions <- predict(darch, type="bin")
  numCorrect <- sum(predictions == trainTargets)
  cat(paste0("Correct classifications on all data: ", numCorrect,
             " (", round(numCorrect/nrow(trainTargets)*100, 2), "\%)\\n"))
  
  return(darch)
}

##
# XOR example #2, with nominal data, to demonstrate that darch can deal with
# nominal data and to show how model formulae can be used.
##

# Simply call example.xorNominal() after executing example("darch") or manually
# sourcing this function
example.xorNominal <- function()
{
  # dataset
  trainData <- matrix(c("zero","zero","zero","one","one","zero","one","one"),
                      ncol=2, byrow=TRUE)
  trainTargets <- matrix(c("zero", "one", "one", "zero"), nrow=4)
  # create data frame with column names V1 through V3, which will used in the
  # model formula
  dataFrame <- cbind(trainData, trainTargets)

  # see XOR example #1 for explanation of the parameter values
  darch <- darch(V3 ~ V1 + V2, dataFrame,
                 rbm.numEpochs = 0,
                 layers = c(2,10,1),
                 darch.batchSize = 1,
                 darch.bootstrap = F,
                 darch.learnRate = 5,
                 darch.stopClassErr = 0,
                 darch.numEpochs = 1000
  )

  # Print parameters, stats, and results
  print(darch)

  predictions <- predict(darch, type="class")
  numCorrect <- sum(predictions == trainTargets)
  cat(paste0("Correct classifications on all data: ", numCorrect,
             " (", round(numCorrect/nrow(trainTargets)*100, 2), "\%)\\n"))

  return(darch)
}

##
# IRIS example #3, in which a small network is trained on the IRIS data set
# which is part of every R installation.
##

# Simply call example.iris() after executing example("darch") or manually
# sourcing this function
example.iris <- function()
{
  data(iris)
  
  # See XOR example #1 for more details on the parameter values.
  darch <- darch(Species ~ ., iris,
                 # We'll scale all data, useful for faster convergence when data
                 # is not already relatively close to 0 (or, say, within -1..1)
                 scale=T,
                 rbm.numEpochs = 0,
                 layers = c(4,20,3),
                 # batch size equals the number of classes, which is usually a
                 # sensible choice
                 darch.batchSize = 3,
                 # higher for sigmoid activation
                 darch.learnRate = .8,
                 # binary classification
                 darch.isBin = T,
                 # We'll stop when either all training examples are correctly
                 # classified or the validation error drops below 1\%...
                 darch.stopClassErr = 0,
                 darch.stopValidClassErr = 1,
                 # ... or when training has been going on for 250 epochs.
                 darch.numEpochs = 250,
                 # change to DEBUG if needed
                 darch.logLevel = futile.logger::INFO
  )
  
  print(darch)
  
  # the predict function can be used to get the network output for a new set of
  # data, it will even convert the output back to the original character labels
  predictions <- predict(darch, newdata=iris, type="class")
  
  # And these labels can then easily be compared to the correct ones
  numIncorrect <- sum(predictions != iris[,5])
  cat(paste0("Incorrect classifications on all examples: ", numIncorrect, " (",
         round(numIncorrect/nrow(iris)*100, 2), "\%)\\n"))

  return (darch)
}

##
# MNIST example #4: Uses a small network that is trained on a small chunk of the
# MNIST data set.
##

# Simply call example.mnist() after executing example("darch") or manually
# sourcing this function
example.mnist <- function(dataFolder = "data/", downloadMNIST = F)
{
  # Make sure to prove the correct folder if you have already downloaded the
  # MNIST data somewhere, or otherwise set downloadMNIST to TRUE
  provideMNIST(dataFolder, downloadMNIST)
  
  # Load MNIST data
  load(paste0(dataFolder, "train.RData")) # trainData, trainLabels
  load(paste0(dataFolder, "test.RData")) # testData, testLabels
  
  # only take 1000 samples, otherwise training takes increasingly long
  chosenRowsTrain <- sample(1:nrow(trainData), size=1000)
  trainDataSmall <- trainData[chosenRowsTrain,]
  trainLabelsSmall <- trainLabels[chosenRowsTrain,]
  
  # See XOE example #1 for details on the parameter values
  darch  <- darch(trainDataSmall, trainLabelsSmall,
    # We use 10 epochs of pre-training, disable this to see the difference
    rbm.numEpochs = 0,
    rbm.batchSize = 100,
    # Don't train the output layer, backprop does that just fine
    rbm.trainOutputLayer = F,
    layers = c(784,100,10),
    darch.batchSize = 100,
    darch.learnRate = 2,
    # fine-tune configuration.
    # use this when handling bigger data sets, it will make the resulting DArch
    # instance much smaller
    darch.retainData = F,
    darch.numEpochs = 20
  )
  
  print(darch)
  
  predictions <- predict(darch, newdata=testData[], type="class")
  labels <- cbind(predictions, testLabels[])
  numIncorrect <- sum(apply(labels, 1, function(i) { any(i[1:10] != i[11:20]) }))
  cat(paste0("Incorrect classifications on test data: ", numIncorrect,
             " (", round(numIncorrect/nrow(testLabels[])*100, 2), "\%)\\n"))

  return(darch)
}
}
\author{
Martin Drees \email{mdrees@stud.fh-dortmund.de} and contributors.
}
\references{
Hinton, G. E., S. Osindero, Y. W. Teh, A fast learning algorithm
  for deep belief nets, Neural Computation 18(7), S. 1527-1554, DOI:
  10.1162/neco.2006.18.7.1527 2006.

  Hinton, G. E., R. R. Salakhutdinov, Reducing the dimensionality of data
  with neural networks, Science 313(5786), S. 504-507, DOI:
  10.1126/science.1127647, 2006.

  Hinton, Geoffrey E. et al. (2012). "Improving neural networks by
  preventing coadaptation of feature detectors". In: Clinical Orthopaedics
  and Related Research abs/1207.0580. URL : http://arxiv.org/abs/1207.0580.

  Goodfellow, Ian J. et al. (2013). "Maxout Networks". In: Proceedings of
  the 30th International Conference on Machine Learning, ICML 2013, Atlanta,
  GA, USA, 16-21 June 2013, pp. 1319-1327.
  URL: http://jmlr.org/proceedings/papers/v28/goodfellow13.html.

  Drees, Martin (2013). "Implementierung und Analyse von tiefen Architekturen
  in R". German. Master's thesis. Fachhochschule Dortmund.

  Rueckert, Johannes (2015). "Extending the Darch library for deep
  architectures". Project thesis. Fachhochschule Dortmund.
  URL: http://static.saviola.de/publications/rueckert_2015.pdf.
}
\seealso{
Other darch interface functions: \code{\link{darch.DataSet}};
  \code{\link{darch.default}}; \code{\link{darch.formula}};
  \code{\link{predict.DArch}}, \code{\link{predict.darch}};
  \code{\link{print.DArch}}, \code{\link{print.darch}}
}
\keyword{Architectures}
\keyword{Backpropagation}
\keyword{Boltzmann}
\keyword{Conjugate}
\keyword{Contrastive}
\keyword{Deep}
\keyword{Deep-Belief-Networks}
\keyword{Divergence}
\keyword{Dropout}
\keyword{Gradient}
\keyword{Machines}
\keyword{Maxout}
\keyword{NN}
\keyword{Nets}
\keyword{Networks}
\keyword{Neural}
\keyword{Resilient}
\keyword{Restricted}
\keyword{darch}
\keyword{package}

