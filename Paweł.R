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
print(optm_priv)

weighted_rates_public = rates_using_portfolio(public_companies_r_lns, optm_public)
weighted_rates_private = rates_using_portfolio(private_companies_r_lns, optm_priv) 

return_priv = count_return(weighted_rates_private)
return_public = count_return(weighted_rates_public)

return_public_9 = actualization_rates(public_companies_r_lns, 2)
return_priv_9 = actualization_rates(private_companies_r_lns, 2)

results = cbind(return_public_9$returns, return_priv_9$returns)  %>% as.data.frame() %>% mutate(ind = rownames(.))
colnames(results) = c('public', 'priv', 'ind')


results %>%melt(.) %>% mutate(ind = ind %>% as.numeric()) %>% ggplot(., aes(x= ind, y = value, colour= variable))+
  geom_point()+
  geom_line(size= 0.8)


