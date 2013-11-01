\begin{verbatim}
##==================================================================
## Uma parametrização do modelo van Genuchten para inferência
## sobre os parâmetros I e S.
##
##                                            Walmes Marques Zeviani
##                                                    walmes@ufpr.br
##
##==================================================================

##------------------------------------------------------------------
## Definições da sessão.

require(lattice)
require(latticeExtra)
require(nlme)
require(car)
require(plyr)
require(reshape)

##------------------------------------------------------------------
## Carrega os dados.

url <- "http://www.leg.ufpr.br/~walmes/data/ZevianiTeseCRA.txt"
cra <- read.table(url, header=TRUE, sep="\t")
cra$ltens <- log(cra$tens)
cra$ue <- with(cra, interaction(rep, PF, PS))
str(cra)

##------------------------------------------------------------------
## Visualiza os dados.

xyplot(umid~ltens|PF*PS, groups=rep, data=cra)

##------------------------------------------------------------------
## Define funções que retornam F e H para obter medidas de
## curvatura.

## modelo van Genuchten original, parametrização de Omuto 2007
vg.O <- deriv3(~Ur+(Us-Ur)/(1+(exp(a)*exp(psi))^n)^(1-1/n),
               c("Ur","Us","a","n"),
               function(psi, Ur, Us, a, n){ NULL })

## modelo van Genuchten reparametrizado para S e I
vg.SI <- deriv3(~Ur-S*(1+1/(1-1/n))^((1-1/n)+1)/
                (n*(1+exp(n*(psi-I))/(1-1/n))^(1-1/n)),
                c("Ur","S","I","n"),
                function(psi, Ur, S, I, n){ NULL })

##------------------------------------------------------------------
## Ajusta as parametrizações por unidade experimental.

cra.ue <- split(cra, f=cra$ue)
str(cra.ue)

aO <- lapply(cra.ue, nls,
             formula=umid~vg.O(ltens, Ur, Us, a, n),
             start=list(Ur=0.3, Us=0.6, a=0, n=1.5))
lapply(aO, summary)

aSI <- lapply(cra.ue, nls,
              formula=umid~vg.SI(ltens, Ur, S, I, n),
              start=list(Ur=0.3, S=-0.12, I=1.14, n=1.5))
lapply(aSI, summary)

##------------------------------------------------------------------
## Medidas de curvatura.

lapply(aO, MASS::rms.curv)
lapply(aSI, MASS::rms.curv)

##------------------------------------------------------------------
## Inferência sobre S e I pelo método delta.

B <- coef(aO[[1]])
W <- vcov(aO[[1]])
gS <- "-(Us-Ur)*n*(1+1/(1-1/n))^(-(1-1/n)-1)"
gI <- "-a-log(1-1/n)/n"
deltaMethod(object=B, g=gS, vcov=W)
deltaMethod(object=B, g=gI, vcov=W)

dmSI <- function(nlsobj){
  B <- coef(nlsobj); W <- vcov(nlsobj)
  dmS <- unlist(deltaMethod(object=B, g=gS, vcov=W))
  dmI <- unlist(deltaMethod(object=B, g=gI, vcov=W))
  dmS <- c(dmS, lwr=dmS[1]-1.96*dmS[2], upr=dmS[1]+1.96*dmS[2])
  dmI <- c(dmI, lwr=dmI[1]-1.96*dmI[2], upr=dmI[1]+1.96*dmI[2])
  names(dmS) <- names(dmI) <- gsub("\\..*", "", names(dmS))
  return(data.frame(par=c("S","I"), rbind(dmS, dmI)))
}

vartheta <- lapply(aO, dmSI)
vartheta <- ldply(vartheta)
str(vartheta)

##------------------------------------------------------------------
## Cria objeto de dados agrupados/longitudinais.

crag <- groupedData(umid~ltens|ue, data=cra)

##------------------------------------------------------------------
## Ajuste do modelo não linear de efeitos mistos.
## van Genuchten original.

## Valores inicias
start <- c(c(0.3, rep(0,9)), # Ur
           c(0.6, rep(0,9)), # Us
           c(0, rep(0,9)),   # a
           c(1.8, rep(0,9))) # n

## Completo
nlmeO.0 <- nlme(umid~Ur+(Us-Ur)/(1+exp(a+ltens)^n)^(1-1/n),
                data=crag,
                fixed=Ur+Us+a+n~PF*PS,
                random=Ur+Us~1,
                start=start)

## Efeitos aleatórios independentes
nlmeO.1 <- update(nlmeO.0, random=pdDiag(Ur+Us~1))

## Efeito aditivo para o parâmetro n
nlmeO.2 <- update(nlmeO.0, fixed=list(Ur+Us+a~PF*PS, n~PF+PS),
                  start=start[1:36])

anova(nlmeO.0, nlmeO.1) # testa correlação nula
anova(nlmeO.0, nlmeO.2) # testa interação nula em n

anova(nlmeO.0, type="marginal") # teste de Wald no ef fixos
VarCorr(nlmeO.0)                # estivativas das variâncias

##------------------------------------------------------------------
## Ajuste do modelo não linear de efeitos mistos.
## van Genuchten reparametrizado para S e I.

## Valores inicias
start <- c(c(0.3, rep(0,9)),  # Ur
           c(-0.1, rep(0,9)), # S
           c(1.6, rep(0,9)),  # I
           c(1.8, rep(0,9)))  # n

## Completo
nlmeSI.0 <- nlme(umid~Ur-S*(1+1/(1-1/n))^((1-1/n)+1)/
                 (n*(1+exp(n*(ltens-I))/(1-1/n))^(1-1/n)),
                 data=crag,
                 fixed=Ur+S+I+n~PF*PS,
                 random=Ur+S~1,
                 start=start)

## Efeitos aleatórios independentes
nlmeSI.1 <- update(nlmeSI.0, random=pdDiag(Ur+S~1))

## Efeito aditivo para o parâmetro n
nlmeSI.2 <- update(nlmeSI.0, fixed=list(Ur+S+I~PF*PS, n~PF+PS),
                   start=start[1:36])

anova(nlmeSI.0, nlmeSI.1) # testa correlação nula
anova(nlmeSI.0, nlmeSI.2) # testa interação nula em n

anova(nlmeSI.0, type="marginal") # teste de Wald no ef fixos
VarCorr(nlmeSI.0)                # estivativas das variâncias

##------------------------------------------------------------------
## Compara as verossimilhanças.

logLik(nlmeO.0)
logLik(nlmeSI.0)

##------------------------------------------------------------------
## Gráfico dos valores preditos.

plot(augPred(nlmeO.0, level=0:1))
plot(augPred(nlmeSI.0, level=0:1))
plot(comparePred(nlmeO.0, nlmeSI.0))

##------------------------------------------------------------------
## sessionInfo()

## R version 2.15.3 (2013-03-01)
## Platform: i686-pc-linux-gnu (32-bit)

## [1] reshape_0.8.4       plyr_1.7.1          car_2.0-15         
## [4] nnet_7.3-6          MASS_7.3-23         nlme_3.1-108       
## [7] latticeExtra_0.6-24 RColorBrewer_1.0-5  lattice_0.20-13    

##------------------------------------------------------------------
\end{verbatim}
