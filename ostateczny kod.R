
###################################################################
############# proces pobierania i obróbki danych ##################
###################################################################

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
dzien <- data.frame(pko[,1])
d1 <- data.frame(pko[,5],kgh[,5],pkn[,5],pzu[,5],peo[,5])#kursy zamknięcia 
d2 <- data.frame(cdr[,5],cps[,5],dnp[,5],lpp[,5],spl[,5]) #kursy zamknięcia 
#dodanie nazw do kolumn 
colnames(dzien)<-NA
colnames(d2)<-names2
colnames(d1)<-names1

#dodanie pomocniczych ramek danych bez pierwszego okresu  aby można było później podzielić jedne przez drugi
dzien_1<-dzien[c(2:495),]

dp1<-d1[c(2:495),] #tworzenie ramki danych bez pierwszego okresu 
dp2<-d2[c(2:495),] #tworzenie ramki danych bez pierwszego okresu 

dpp1<-d1[c(1:494),]
dpp2<-d2[c(1:494),]


stopy_p1<-data.frame(dzien_1,log(dp1/dpp1))
stopy_p2<-data.frame(dzien_1,log(dp2/dpp2))



###################################################################
############zysk oraz ryzyko dla poszczególnych spółek  ###########
###################################################################
s1<-log(dp1/dpp1)
s2<-log(dp2/dpp2)

colMeans(s1)
colSds(s1)
colMeans(s2)
colSds(s2)

###################################################################
################ proces generowania danych ########################
###################################################################

#Konwersja z data frame na szeregi czasowe 
sz1<- as.timeSeries(stopy_p1)
sz2<- as.timeSeries(stopy_p2)


#przypisanie danych do funkcji porftolio z (pakietu fPortfolio)
### szczagóły tego co poniżej
## https://www.rmetrics.org/downloads/9783906041018-fPortfolio.pdf
## strona 187

lppData1 <- portfolioData(data = sz1, spec = portfolioSpec())  
lppData2 <- portfolioData(data = sz2, spec = portfolioSpec()) 

#otrzymanie głównych statystyk miedzy innymi macierzy kowariancji 
getStatistics(lppData1)
getStatistics(lppData2)

#chyba tworzy funkcje która ułoży wyniki w fajny raporcik 
portfel_1 <- portfolioSpec()
portfel_2 <- portfolioSpec()


#to jest funkcja generująca udziały spółek dla (tylko długch pozycji czyli BEZ KS) oraz (miniamlizacja wariancji=ryzyka)
minriskPortfolio1 <- efficientPortfolio( data = lppData1, spec = portfolioSpec(), constraints = "LongOnly")
minriskPortfolio2 <- efficientPortfolio( data = lppData2, spec = portfolioSpec(), constraints = "LongOnly")

raport1<-print(minriskPortfolio1)
raport2<-print(minriskPortfolio2)










 
