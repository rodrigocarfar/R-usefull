powershell <- function(cmd){
  for(i in 1:100) {j <- sample(1:999,1);temp_csv <- paste("C:/temp/ps",j,".csv",sep=""); if(!file.exists(temp_csv)) break}
  write("",file = temp_csv)
  temp_csv_win <- stringr::str_replace_all(temp_csv,"/","\\\\")
  #system2("powershell",args = c("-command",paste(cmd,' | convertto-csv -NoTypeInformation | out-file -Encoding UTF8 ',temp_csv_win,'"',sep="")))
  system2("powershell",args = c("-command",paste("$sw = [System.IO.StreamWriter] '",temp_csv_win,"';",cmd," | convertto-csv -NoTypeInformation | %{$sw.WriteLine($_)};$sw.close()",sep="")))
  tot <- length(readLines(temp_csv))
  if(tot > 0) {
    #saida <- read.csv(temp_csv,sep = ",",header = T,encoding ="UTF-8",stringsAsFactors=FALSE)
    saida <- data.table::fread(temp_csv,sep = ",",header = T,encoding ="UTF-8",stringsAsFactors=FALSE)
    colnames(saida) <- stringr::str_replace(colnames(saida),"X.U.FEFF.","")
  }
  rc <- file.remove(temp_csv)
  if(tot > 0){return(saida)}else{return(NULL)}
}
