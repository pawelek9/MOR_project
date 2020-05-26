#This is main part of project
Optimal_portfolio <- function(dataframe, constraints) {
  portfolio = portfolioData(dataframe, spec = portfolioSpec())
  stats = getStatistics(portfolio)
  
  efficent = efficientPortfolio(dataframe, constraints = constraints)
  minvar = minvariancePortfolio(dataframe, constraints = constraints)
  tangency = tangencyPortfolio(dataframe, constraints = constraints)
  maxratio = maxratioPortfolio(dataframe, constraints = constraints)
  minrisk = minriskPortfolio(dataframe, constraints =  constraints)
  
  output = list(
    stats,
    efficent,
    tangency,
    maxratio,
    minrisk
  )
  
  names(output) = c('statistics', 'efficeint_portfolio', 'tangency_portfolio',
                    'maxratio_portfolio', 'minrisk_portfolio')
  return(output)
}


rates_using_portfolio <- function(data, porfolio) {
  weights = porfolio$efficeint_portfolio@portfolio@portfolio$weights
  data = data %>% as.data.frame()
  print(data %>% head())
  dfs = list()
  for (i in names(weights)) {
    dfs[i] = weights[i]* data[i]
  }
  
  dfs = dfs %>% as.data.frame()
  rownames(dfs) = data %>% row.names()
  return(dfs %>% as.data.frame())
}


count_return  <- function(weighted_returns) {
  retr_rates = exp(apply(weighted_returns, 1, sum))
  retr<- c()
  w_p1 <- 10000
  
  for(i in 1:length(retr_rates)){
    w_p1[i+1] <- retr_rates[i]*w_p1[i]
  }
  
  return(w_p1)
}



