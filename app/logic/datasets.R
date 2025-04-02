#app/logic/datasets

box::use(
  utils[read.csv],
  bnlearn[read.net],
  dplyr[rename]
)

#' @export
BeachEcoli <- read.csv("app/datasets/BeachEcoli.csv")

#' @export
BeachLocation <- read.csv("app/datasets/BeachLocation.csv")

#' @export
AllWeather <- read.csv("app/datasets/AllWeather.csv")

#' @export
modNiagara <- read.net("app/datasets/Nov15NiagaraModel.net")