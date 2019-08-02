sqlite_query <- function(db,query){
  library("RSQLite")
  db = dbConnect(drv=RSQLite::SQLite(), dbname=db)
  rs <- dbSendQuery(conn = db,query)
  resultado <- dbFetch(rs)
  dbClearResult(rs)
  dbDisconnect(db)
  return(resultado)
}
