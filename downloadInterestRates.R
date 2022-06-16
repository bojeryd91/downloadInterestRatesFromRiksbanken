### To download Swedish interest rates

library(utils)
library(hash)
###

loadDictionary <- function() {
  dict <- hash()
  dict[["SE1M"]]  <- "g6-SETB1MBENCHC=on&"
  dict[["SE3M"]]  <- "g6-SETB3MBENCH=on&"
  dict[["SE6M"]]  <- "g6-SETB6MBENCH=on&"
  dict[["SE2Y"]]  <- "g7-SEGVB2YC=on&"
  dict[["SE5Y"]]  <- "g7-SEGVB5YC=on&"
  dict[["SE7Y"]]  <- "g7-SEGVB7YC=on&"
  dict[["SE10Y"]] <- "g7-SEGVB10YC=on&"
  dict[["STIBORTN"]]  <- "g5-SEDPT%2FNSTIBORDELAYC=on&"
  dict[["STIBOR1W"]]  <- "g5-SEDP1WSTIBORDELAYC=on&"
  dict[["STIBOR1M"]]  <- "g5-SEDP1MSTIBORDELAYC=on&"
  dict[["STIBOR2M"]]  <- "g5-SEDP2MSTIBORDELAYC=on&"
  dict[["STIBOR3M"]]  <- "g5-SEDP3MSTIBORDELAYC=on&"
  dict[["STIBOR6M"]]  <- "g5-SEDP6MSTIBORDELAYC=on&"
  dict[["STIBOR9M"]]  <- "g5-SEDP9MSTIBOR=on&"
  dict[["STIBOR12M"]] <- "g5-SEDP12MSTIBOR=on&"
  dict[["RB_policy"]]  <- "g2-SECBREPOEFF=on&"
  dict[["RB_deposit"]] <- "g2-SECBDEPOEFF=on&"
  dict[["RB_lending"]] <- "g2-SECBLENDEFF=on&"
  return(dict)
}

# Freq can take values Day week Month Quarter Year
downloadYear <- function(year, list_of_rates, freq = "Month",
                         filename = "defaultName.csv") {
  str_part1 <- paste0("https://www.riksbank.se/en-gb/statistics/", 
                      "search-interest--exchange-rates/?c=cAverage&f=",
                      freq, "&from=01%2f01%2f", year, "&", sep="")
  
  list_of_possible_rates = c("SE1M", "SE3M", "SE6M", "SE2Y", "SE5Y", 
                             "SE7Y", "SE10Y", "STIBORTN", "STIBOR1W", 
                             "STIBOR1M", "STIBOR2M", "STIBOR3M", "STIBOR6M",
                             "STIBOR9M", "STIBOR12M",
                             "RB_policy", "RB_deposit", "RB_lending")
  dictionary <- loadDictionary()
  str_part2 <- ""
  
  for (pot in list_of_possible_rates) {
    if (pot %in% list_of_rates) {
      str_part2 <- paste(str_part2, dictionary[[pot]], sep="")
    }
  }
  str_part3 <- paste0("s=Dot&to=31%2f12%2f", year, "&export=csv", sep="")
  address <- paste(str_part1, str_part2, str_part3, sep="")
  
  ### Download
  cat(address, "\n")
  download.file(address, filename)
}

# Download
freq = "Month"
for (year in 1994:2020){
  filename <- paste0("./Downloaded-data/rates_", year, "_freq_", freq, ".csv")
  downloadYear(year, c("RB_policy", "RB_deposit", "RB_lending",
                       "STIBORTN", "STIBOR1W", "hej"), freq, filename)
}