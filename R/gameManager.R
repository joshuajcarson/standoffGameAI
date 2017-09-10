#Game Idea from https://fivethirtyeight.com/features/how-to-win-a-nuclear-standoff/

source('R/basicStandoffFunctions.R')

initThePlayerScores()
getNumberOfGamesToPlayValue <- getNumberOfGamesToPlay()
for(i in 1:getNumberOfGamesToPlayValue) {
  runASingleRound(i)
}
