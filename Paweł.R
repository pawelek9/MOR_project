source('libraries.R')
source('downloader.R')
source('companies.R')
source('dataframe_cleaner.R')
source('Portfolio.R')

private_companies = download_data(companies_privat, 20180101, 20200101)
public_companies = download_data(companies_public, 20180101, 20200101)

private_companies_r_lns =  count_ln_returns(private_companies, companies_public) 
public_companies_r_lns = count_ln_returns(public_companies, companies_privat)

optm = Optimal_portfolio(private_companies_r_lns, 'LongOnly')

