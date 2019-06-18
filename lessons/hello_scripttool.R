#' Example R-ArcGIS Bridge tool
#' 
#' Hello World
tool_exec <- function(in_params, out_params){
  text <- in_params$input_text
  print(text)
  return(out_params)
}
