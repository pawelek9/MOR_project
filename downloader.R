## this file is responsible to download data
download_frame <- function(company,first_date= 20180101, last_date= 20190101) {
  #This function download one frame
  #args:
  #company = name of comapany that values of shares will be downloaded
  #first_date = start date of downloaded time series
  #last_date = end date of downloaded time series
  
  link = trimws(paste("https://stooq.pl/q/d/l/?s=",company,'&d1=',first_date, '&d2=',
                      last_date,'&i=d'))
  data = read.csv(link)
  
  return(data)
}

download_data <- function(vect, first_date, last_date) {
  #Extension to download_frame fuction, instead of one variable it takes vector of
  #variables
  
  var_list = list()
  for (i in vect) {
    var_list[[i]] = download_frame(i, first_date, last_date)
  }
  
  return(var_list)
}