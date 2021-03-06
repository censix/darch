example.maxout <- function(dataFolder = "data/", downloadMNIST = F)
{
  provideMNIST(dataFolder, downloadMNIST)
  
  load(paste0(dataFolder, "train.RData")) # trainData, trainLabels
  load(paste0(dataFolder, "test.RData")) # testData, testLabels
  
  # only take 1000 samples, otherwise training takes increasingly long
  chosenRowsTrain <- sample(1:nrow(trainData), size=1000)
  trainDataSmall <- trainData[chosenRowsTrain,]
  trainLabelsSmall <- trainLabels[chosenRowsTrain,]
  
  darch <- darch(x = trainDataSmall, y = trainLabelsSmall,
    rbm.numEpochs = 0,
    
    # DArch constructor arguments
    layers = c(784,500,10), # required
    darch.batchSize = 100,
    darch.learnRate = 1,
    darch.dropoutHidden = .5,
    darch.dropoutInput = .2,
    # custom activation functions
    darch.layerFunctions = list("2"=maxoutUnitDerivative),
    darch.layerFunction.maxout.poolSize = 5,
    darch.weightUpdateFunctions = list("2"=maxoutWeightUpdate),
    darch.retainData = F,
    darch.numEpochs = 50
  )

  print(darch)
  
  predictions <- predict(darch, newdata=testData[], type="class")
  labels <- cbind(predictions, testLabels[])
  numIncorrect <- sum(apply(labels, 1, function(i) { any(i[1:10] != i[11:20]) }))
  cat(paste0("Incorrect classifications on test data: ", numIncorrect,
             " (", round(numIncorrect/nrow(testLabels[])*100, 2), "%)\n"))

  return(darch)
}