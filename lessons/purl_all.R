#' purl All
#' Grab all .Rmd files in a directory, and purl output to a single file.
#' @param dir Directory to search for .Rmd files
#' @param output Name of file to save R code to. Overwrites existing files.
#' @importFrom knitr purl
#' @export
purl_all <- function(dir, output = "purled_code.R"){
  if(file.exists(output)){
    file.remove(output)
  }
  rmds <- list.files(dir, ".Rmd",full.names = TRUE)
  for(i in rmds){
    out_i <- gsub(".Rmd",".R",i)
    knitr::purl(i,out_i)
    con <- file(out_i,"r+")
    in_i <- readLines(con)
    close(con)
    file.remove(out_i)
    in_i <- c(paste(rep("#",80),collapse=""),
              paste("#",out_i),
              paste(rep("#",80),collapse=""),
              in_i)
    l1 <- !substr(in_i,1,4) %in% "## -"
    l2 <- !substr(in_i,1,4) %in% "## #"
    l3 <- substr(in_i,1,2) %in% "##"
    l4 <- (l1 + l2 + l3)==3
    in_i[l4] <- gsub("## ","", in_i[l4])
    if(!file.exists(output)){
      file.create(output)
    }
    con <- file(output,"a+")
    writeLines(in_i,con)
    close(con)
  }
  return(paste(output, "created."))
}