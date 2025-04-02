#Load datasets from file
BeachEcoli <- read.csv("datasets/BeachEcoli.csv")
BeachLocation <- read.csv("datasets/BeachLocation.csv")
AllWeather <- read.csv("datasets/AllWeather.csv")
modNiagara <- bnlearn::read.net("datasets/Nov15NiagaraModel.net")
#modManitoba <- bnlearn::read.net("datasets/Manitoba.oobn") ## these .oobn files do not work
#modVancouver <- bnlearn::read.net("datasets/Vancouver.oobn") ## oobn does not work with read.net
modToronto <- bnlearn::read.net("datasets/Nov15NiagaraModel.net") ## needs to be changed once we have net file
modWinnepeg <- bnlearn::read.net("datasets/Nov15NiagaraModel.net") ## needs to be changed once we have net file