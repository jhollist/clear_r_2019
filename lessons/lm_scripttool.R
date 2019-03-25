tool_exec <- function(in_params, out_params){
  input_data <- in_params$input_data
  y <- in_params$y
  x <- in_params$x
  out_fc <- out_params$output_data
  
  d <- arc.open(input_data)
  d_sel <- arc.select(d)
  
  xlm <- lm(log1p(d_sel[[y]]) ~ log1p(d_sel[[x]]))
  d_sel$lm_pred <- exp(predict(xlm)) - 1
  
  arc.write(out_fc, d_sel, overwrite = TRUE)
  
  return(out_fc)
}