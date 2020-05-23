
m<-as.data.frame(EuStockMarkets)#robiy szereg czasowy

ue<-as.timeSeries(EuStockMarkets)## kurwa trzeba zrobić z tych danych szereg czasowy bo inaczej nie działają chuje (siedziałem nad tym 2h XD)


lppAssets <- ue[,c("DAX","SMI","CAC","FTSE")]

lppData <- portfolioData(data = lppAssets, spec = portfolioSpec())

str(lppData, width = 65, strict.width = "cut")

args(aktywa)

###### na danych od wójcika wyszła ta sama kowariancja więc można robić tym pakietem
dd<- read_excel("C:/Users/Janusz/Desktop/dane.xlsx",sheet = "2017-2018")
ddd<-as.timeSeries(dd)[,3:7]


lppAssets <- ddd[,c("KGHM","Orange","PKN","PKOBP","Budimex")]

lppData <- portfolioData(data = lppAssets, spec = portfolioSpec())

getStatistics(lppData)
#########################################
minriskSpec <- portfolioSpec()
targetReturn <- getTargetReturn(ewPortfolio@portfolio)["mean"]

minriskPortfolio <- efficientPortfolio(
  data = lppData,
  spec = minriskSpec,
  constraints = "LongOnly")
print(minriskPortfolio)



class(minriskPortfolio)




pko<- read.csv("C:/Users/Janusz/Desktop/mor/pan/pko.csv")
kgh<- read.csv("C:/Users/Janusz/Desktop/mor/pan/kgh.csv")
pkn<- read.csv("C:/Users/Janusz/Desktop/mor/pan/pkn.csv")
pzu<- read.csv("C:/Users/Janusz/Desktop/mor/pan/pzu.csv")
peo<- read.csv("C:/Users/Janusz/Desktop/mor/pan/peo.csv")


cdr<- read.csv("C:/Users/Janusz/Desktop/mor/pry/cdr.csv")
cps<- read.csv("C:/Users/Janusz/Desktop/mor/pry/cps.csv")
dnp<- read.csv("C:/Users/Janusz/Desktop/mor/pry/dnp.csv")
lpp<- read.csv("C:/Users/Janusz/Desktop/mor/pry/lpp.csv")
spl<- read.csv("C:/Users/Janusz/Desktop/mor/pry/spl.csv")


names1<-c("PKO","KGH","PKN","PZU","PEO")
names2<-c("CDR","CPS","DNP","LPP","SPL")
#utworzenie ramek danych na podstawie pobranych danych o kursach na zamknięciach
daty <- data.frame(pko[,1])
d1 <- data.frame(pko[,5],kgh[,5],pkn[,5],pzu[,5],peo[,5])#kursy zamknięcia 
d2 <- data.frame(cdr[,5],cps[,5],dnp[,5],lpp[,5],spl[,5]) #kursy zamknięcia 
#dodanie nazw do kolumn 
colnames(daty)<-NA
colnames(d2)<-names2
colnames(d1)<-names1

#dodanie pomocniczych ramek danych bez pierwszego okresu  aby można było później podzielić jedne przez drugi
data_1<-data[c(2:495)]
dp1<-d1[c(2:495),] #tworzenie ramki danych bez pierwszego okresu 
dp2<-d2[c(2:495),] #tworzenie ramki danych bez pierwszego okresu 

dpp1<-d1[c(1:494),]
dpp2<-d2[c(1:494),]

stopy_p1<-log(dp1/dpp1)
stopy_p2<-log(dp2/dpp2)




#to właściwie sie zrobi na samym oncu jak sie dane już obrobi i zrobi się stopy zwtrotu i doda daty 
d<-as.timeSeries(d1) 
ds2<- as.timeSeries(d2)


m<-as.data.frame(EuStockMarkets)#robiy szereg czasowy

ue<-as.timeSeries(EuStockMarkets)## kurwa trzeba zrobić z tych danych szereg czasowy bo inaczej nie działają chuje (siedziałem nad tym 2h XD)


lppAssets <- ue[,c("DAX","SMI","CAC","FTSE")]

lppData <- portfolioData(data = lppAssets, spec = portfolioSpec())

str(lppData, width = 65, strict.width = "cut")

args(aktywa)

###### na danych od wójcika wyszła ta sama kowariancja więc można robić tym pakietem
dd<- read_excel("C:/Users/Janusz/Desktop/dane.xlsx",sheet = "2017-2018")
ddd<-as.timeSeries(dd)[,3:7]


lppAssets <- ddd[,c("KGHM","Orange","PKN","PKOBP","Budimex")]

lppData <- portfolioData(data = lppAssets, spec = portfolioSpec())

getStatistics(lppData)
#########################################
minriskSpec <- portfolioSpec()
targetReturn <- getTargetReturn(ewPortfolio@portfolio)["mean"]

minriskPortfolio <- efficientPortfolio(
  data = lppData,
  spec = minriskSpec,
  constraints = "LongOnly")
print(minriskPortfolio)



class(minriskPortfolio)






