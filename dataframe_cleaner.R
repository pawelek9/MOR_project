##This script will be responsible for data preparing

count_ln_return_rate_one_frame <- function(frame) {
  #this function computes log return rates for one frame
  
  frame = cbind(frame, (shift(frame, -1)))[-1,]
  frame = frame[,c(1,2,4)]
  colnames(frame) = c('Data','Zamkniecie','Poprzednie_Zamkniecie')
  frame['ln_R'] = log(frame['Zamkniecie']/frame['Poprzednie_Zamkniecie'])
  print(head(frame))
    
  return(frame[, c(1,4)])
}

count_ln_returns <- function(values, names) {
  #this function computes log return for all frames
  
  print(names(values))
  R_lns = lapply(values, count_ln_return_rate_one_frame)
  R_lns =R_lns %>% reduce(left_join, by= 'Data')
  row.names(R_lns) = R_lns$Data
  R_lns = R_lns %>% select(-Data) %>% as.timeSeries()
  colnames(R_lns) = names
  print(dim(R_lns))
  
  return(R_lns)
}