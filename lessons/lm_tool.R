#' Example R-ArcGIS Bridge tool
#' 
#' Takes input data from ArcGIS, regresses y on x and adds predicted values back 
#' to the feature class
tool_exec <- function(in_params, out_params){
  input_data <- in_params[[1]]
  y <- in_params[[2]]
  x <- in_params[[3]]
  cat(class(y))
  out_fc <- out_params[[1]]
  
  d <- arc.open(input_data)
  d_sel <- arc.select(d)
  
  xlm <- lm(d_sel[[y]] ~ d_sel[[x]])
  d_sel$lm_pred <- predict(xlm)
  
  arc.write(out_fc, d_sel)
  
  return(out_params)
}