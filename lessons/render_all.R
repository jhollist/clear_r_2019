render_all<-function(path=".",pattern="*.Rmd"){
  files <- list.files(path,pattern,full.names = T)
  for(i in files){
    out <- stringr::str_replace(i,"Rmd","md")
    if(!file.exists(out)){
      knitr::knit(i,output=out)
    } else if((file.info(i)$mtime-file.info(out)$mtime)>0){
      knitr::knit(i,output=out)
    }
  }
  system("git add -A")
  system('git commit -m "new render"')
  system("git push origin master")
}