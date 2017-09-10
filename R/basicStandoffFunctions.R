library(data.table)

didPlayerOneWin <- function(playerOneValue, playerTwoValue){
  playerOneValue > playerTwoValue
}

didMassiveLossHappened <- function(playerOneValue, playerTwoValue){
  smallerVote <- min(playerOneValue, playerTwoValue)
  randomChance <- runif(1,0,100)
  smallerVote > randomChance
}

getNumberOfGamesToPlay <- function() {
  10000
}

initThePlayerScores <- function() {
  playerOneScore <<- 0
  playerOneWinTotal <<- 0
  playerTwoScore <<- 0
  playerTwoWinTotal <<- 0
  gameObservations <<- data.frame(
    'gameNumber' = rep.int(0, getNumberOfGamesToPlay()),
    "playerOneValue" = rep(as.double(0.0), times = getNumberOfGamesToPlay()),
    "playerOneScore" = rep.int(0, getNumberOfGamesToPlay()),
    "playerOneWinTotal" = rep.int(0, getNumberOfGamesToPlay()),
    "playerTwoValue" = rep(as.double(0.0), times = getNumberOfGamesToPlay()),
    "playerTwoScore" = rep.int(0, getNumberOfGamesToPlay()),
    "playerTwoWinTotal" = rep.int(0, getNumberOfGamesToPlay()),
    "didPlayerOneWinThisRound" = rep(as.logical(FALSE), times = getNumberOfGamesToPlay()),
    "didTheMassiveLossHappen" = rep(as.logical(FALSE), times = getNumberOfGamesToPlay())
  )
}

doTheMassiveImpact <- function() {
  playerOneScore <<- playerOneScore - 10000
  playerTwoScore <<- playerTwoScore - 10000
}

incrementPlayerOne <- function() {
  playerOneScore <<- playerOneScore + 100
  playerOneWinTotal <<- playerOneWinTotal + 1
}

incrementPlayerTwo <- function() {
  playerTwoScore <<- playerTwoScore + 100
  playerTwoWinTotal <<- playerTwoWinTotal + 1
}

getPlayerOneValue <- function() {
  runif(1,0,100)
}

getPlayerTwoValue <- function() {
  runif(1,0,100)
}

runASingleRound <- function(gameNumber) {
  playerOneValue <- getPlayerOneValue()
  playerTwoValue <- getPlayerTwoValue()
  if(didPlayerOneWin(playerOneValue, playerTwoValue)) {
    incrementPlayerOne()
  } else {
    incrementPlayerTwo()
  }
  didTheMassiveLossHappen <- didMassiveLossHappened(playerOneValue, playerTwoValue)
  if(didTheMassiveLossHappen) {
    doTheMassiveImpact()
  }
  individualObservation <- c(gameNumber, 
                             playerOneValue, 
                             playerOneScore, 
                             playerOneWinTotal, 
                             playerTwoValue, 
                             playerTwoScore, 
                             playerTwoWinTotal, 
                             as.logical(didPlayerOneWin(playerOneValue, playerTwoValue)), 
                             as.logical(didTheMassiveLossHappen))
  gameObservations[gameNumber,] <<- individualObservation
}
