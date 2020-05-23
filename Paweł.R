source('downloader.R')
source('companies.R')

x = c('pko', 'ing', 'kgh')

data = download_data(x)
