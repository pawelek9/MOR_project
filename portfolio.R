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