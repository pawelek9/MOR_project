source('downloader.R')
source('companies.R')

private_companies = download_data(companies_privat, 20170101, 20180101)
public_companies = download_data(companies_public, 20170101, 20180101)
