#'@title Return the path to a template of current files for running GLM
#'
#'@description
#'This returns a path to a directory with example files for running GLM (configuration files and model forcing data).
#'
#'@keywords methods
#'
#'@author
#'Jorrit Mesman
#'@examples
#'\dontrun{
#' glm_template_files()
#'}
#'
#'@export
glm_template_files <- function(){
  return(system.file('extdata/', package=packageName()))
}
