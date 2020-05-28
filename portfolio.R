#This is main part of project
Optimal_portfolio <- function(dataframe, constraints) {
  portfolio = portfolioData(dataframe, spec = portfolioSpec())
  stats = getStatistics(portfolio)
  
  efficent = efficientPortfolio(dataframe, constraints = constraints)
  efficent = efficent@portfolio@portfolio$weights

  return(efficent)
}


rates_using_portfolio <- function(data, weights) {
  data = data %>% as.data.frame()
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


actualization_rates <- function(data, times) {
  
  select_rows <- function(data, periods, times) {
    print((times+1)*periods)
    df =  data[c(times*periods) : c((times+1)* periods-1), ]
    
    
    return(df)
  }
  
  len = data %>% dim()
  len = len[1]
  periods = round(len/times)
  ##first frame
  first_frame = data[c(1:periods),]
  data = data %>% as.data.frame()
  data = na.omit(data)
  
  list_frames = list()
  list_optms = list()
  vect = 1:times-1
  for (i in vect) {
    df = select_rows(data, periods, i) %>% na.omit()
    df = df %>% as.timeSeries()
    optm = Optimal_portfolio(df,'LongOnly')
    print(optm)
    list_frames[[i+1]] =  df 
    list_optms[[i+1]] =  optm 
  }
  
  weighted_rates = list()
  vect = 2: length(list_frames)
  for (i in vect) {
    weighted_rates[[i]] = rates_using_portfolio(list_frames[[i]], list_optms[[i-1]])
  }
  
  weighted_rates = Reduce(rbind, weighted_rates)
  returns = count_return(weighted_rates)
  
  results = list('frames'= list_frames ,
                 'optms' = list_optms,
                 'weighted_rates' = weighted_rates,
                 'returns'= returns)
  
  return(results) 
  
  
}






