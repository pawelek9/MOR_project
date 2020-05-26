source('libraries.R')
source('downloader.R')
source('companies.R')
source('dataframe_cleaner.R')
source('Portfolio.R')

private_companies = download_data(companies_privat, 20180101, 20200101)
public_companies = download_data(companies_public, 20180101, 20200101)

public_companies_r_lns =  count_ln_returns(public_companies, companies_public) 
private_companies_r_lns = count_ln_returns(private_companies, companies_privat)

optm_priv = Optimal_portfolio(private_companies_r_lns, 'LongOnly')
optm_public = Optimal_portfolio(public_companies_r_lns, 'LongOnly')

weighted_rates_public = rates_using_portfolio(public_companies_r_lns, optm_public)
weighted_rates_private = rates_using_portfolio(private_companies_r_lns, optm_priv) 

return_priv = count_return(weighted_rates_private)
return_public = count_return(weighted_rates_public)


