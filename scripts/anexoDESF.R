\begin{verbatim}
##==================================================================
## Uma parametrização de um modelo não linear para inferência
## sobre o nível de dano econômico da desfolha no algodoeiro
##
##                                            Walmes Marques Zeviani
##                                                    walmes@ufpr.br
##
##==================================================================

##------------------------------------------------------------------
## Definições da sessão.

require(lattice)
require(car)
require(bbmle)
require(plyr)
require(reshape)

##------------------------------------------------------------------
## Carrega os dados.

url <- "http://www.leg.ufpr.br/~walmes/data/ZevianiTeseDESF.txt"
da <- read.table(url, header=TRUE, sep="\t")
da$estágio <- factor(da$estágio,
                     levels=c("Vegetativo","Botão floral",
                       "Florescimento","Maça","Capulho"))
str(da)

##------------------------------------------------------------------
## Visualiza os dados.

xyplot(peso~desfolha|estágio, data=da)

##------------------------------------------------------------------
## Define funções que retornam F e H para obter medidas de
## curvatura.

## modelo potência original
m.O <- deriv3(~theta0-theta1*x^exp(thetac),
               c("theta0","theta1","thetac"),
               function(x, theta0, theta1, thetac){ NULL })

## modelo potência reparametrizado para dano econômico
## valor de q=5, mudar se for o caso dentro da fórmula
m.DE <- deriv3(~theta0-theta1*x^((log(5)-log(theta1))/log(varthetaq)),
                c("theta0","theta1","varthetaq"),
                function(x, theta0, theta1, varthetaq){ NULL })

##------------------------------------------------------------------
## Ajusta as parametrizações separado por estágio fenológico.

da.e <- split(da, f=da$estágio)
str(da.e)

aO <- lapply(da.e, nls,
             formula=peso~m.O(desfolha+0.02,
               theta0, theta1, thetac),
             start=list(theta0=30, theta1=8, thetac=1))
lapply(aO, summary)

aDE <- lapply(da.e, nls,
              formula=peso~m.DE(desfolha+0.02,
                theta0, theta1, varthetaq),
              start=list(theta0=30, theta1=8, varthetaq=0.7))
lapply(aDE, summary)

##------------------------------------------------------------------
## Medidas de curvatura.

lapply(aO, MASS::rms.curv)
lapply(aDE, MASS::rms.curv)

##------------------------------------------------------------------
## Matriz de correlação entre estimativas

lapply(aO, function(m) cov2cor(vcov(m)))
lapply(aDE, function(m) cov2cor(vcov(m)))

##------------------------------------------------------------------
## Inferência sobre o dano econômico pelo método delta.

B <- coef(aO[[1]])
W <- vcov(aO[[1]])
g <- "(5/theta1)^exp(-thetac)"

deltaMethod(object=B, g=g, vcov=W)

dm <- function(nlsobj){
  B <- coef(nlsobj); W <- vcov(nlsobj)
  dm <- unlist(deltaMethod(object=B, g=g, vcov=W))
  dm <- c(dm, lwr=dm[1]-1.96*dm[2], upr=dm[1]+1.96*dm[2])
  names(dm) <- gsub("\\..*", "", names(dm))
  return(dm)
}

varthetaq <- lapply(aO, dm)
varthetaq <- ldply(varthetaq)
varthetaq

##------------------------------------------------------------------
## Funções de verossimilhança.

llO <- function(theta0, theta1, thetac, desfolha, peso){
  x <- desfolha+0.02; y <- peso
  ex <- theta0-theta1*x^exp(thetac)
  sd <- sqrt(crossprod(y-ex)/(length(ex)))
  ll <- sum(dnorm(y, mean=ex, sd=sd, log=TRUE))
  -ll
}

llDE <- function(theta0, theta1, varthetaq, desfolha, peso){
  x <- desfolha+0.02; y <- peso
  ex <- theta0-theta1*x^((log(5)-log(theta1))/log(varthetaq))
  sd <- sqrt(crossprod(y-ex)/(length(ex)))
  ll <- sum(dnorm(y, mean=ex, sd=sd, log=TRUE))
  -ll
}

##------------------------------------------------------------------
## Ajuste dos modelos.

alO <- alDE <- da.e
for(i in names(alO)){
  alO[[i]] <- mle2(minuslogl=llO,
                   start=as.list(coef(aO[[i]])),
                   data=c(as.list(subset(da, estágio==i))),
                   method="BFGS")
  alDE[[i]] <- mle2(minuslogl=llDE,
                    start=as.list(coef(aDE[[i]])),
                    data=c(as.list(subset(da, estágio==i))),
                    method="BFGS")
}

##------------------------------------------------------------------
## Estimativas e medidas de ajuste.

cbind(t(sapply(alO, coef)), t(sapply(alDE, coef)))
cbind(sapply(alO, logLik), sapply(alDE, logLik))

##------------------------------------------------------------------

par(mfrow=c(5,3), mar=c(2.2,2.2,1,1))
lapply(alO, function(m) plot(profile(m, maxsteps=20)))
layout(1)

par(mfrow=c(5,3), mar=c(2.2,2.2,1,1))
lapply(alDE, function(m) plot(profile(m, maxsteps=20)))
layout(1)

##------------------------------------------------------------------
\end{verbatim}
