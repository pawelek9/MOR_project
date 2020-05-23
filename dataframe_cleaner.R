##This script will be responsible for data preparing

count_ln_return_rate_one_frame <- function(frame) {
  frame = cbind(frame, (shift(frame, -1)))[-1,]
  frame = frame[,c(1,2,4)]
  colnames(frame) = c('Data','Zamkniecie','Poprzednie_Zamkniecie')
  frame['ln_R'] = log(frame['Zamkniecie']/frame['Poprzednie_Zamkniecie'])
  
  return(frame[, c(1,2,4)])
}

count_ln_returns <- function(values) {
  R_lns= lapply(values, count_ln_return_rate_one_frame)
  
  return(R_lns)
}