##This script will be responsible for data preparing

count_ln_return_rate_one_frame <- function(frame) {
  #this function computes log return rates for one frame
  
  frame = cbind(frame, (shift(frame, -1)))[-1,]
  frame = frame[,c(1,2,4)]
  colnames(frame) = c('Data','Zamkniecie','Poprzednie_Zamkniecie')
  frame['ln_R'] = log(frame['Zamkniecie']/frame['Poprzednie_Zamkniecie'])
  
  return(frame[, c(1,2,4)])
}

count_ln_returns <- function(values) {
  #this function computes log return for all frames
  
  R_lns= lapply(values, count_ln_return_rate_one_frame)
  
  return(R_lns)
}