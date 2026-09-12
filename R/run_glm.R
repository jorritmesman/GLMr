#'@title Run the GLM model
#'
#'@description
#'This runs the GLM model on the specific simulation stored in \code{sim_folder}.
#'The specified \code{sim_folder} must contain a valid .nml file.
#'
#'@param sim_folder the directory where simulation files are contained
#'@param nml_file the configuration file that needs to be run
#'@param verbose Save output as character vector. Defaults to FALSE
#'@param system.args Optional arguments to pass to GLM executable
#'@keywords methods
#'@author
#'Jorrit Mesman, Robert Ladwig
#'@examples
#'sim_folder <- system.file("extdata", package = "GLMr")
#'run_glm(sim_folder, nml_file = "glm4.nml")
#'@export
#'@importFrom utils packageName

run_glm <- function(sim_folder = ".", nml_file = "glm4.nml", verbose = TRUE,
                    system.args=character()){
  # Check for nml file in sim_folder
  if(!(nml_file %in% list.files(sim_folder))){
    stop("You must have a valid .nml file in your sim_folder: ", sim_folder)
  }
  
  nml_arg <- paste0("--nml ", nml_file)
  system.args <- c(nml_arg, system.args)
  
  ### Windows
  if(.Platform$pkgType == "win.binary"){
    return(run_glmWin(sim_folder, verbose, system.args))
  }

  ### UNIX
  if(.Platform$pkgType == "source"){
    stop("Currently UNIX is not supported by ", getPackageName())
    # return(run_glmNIX(sim_folder, verbose, system.args))
  }

  ### macOS ###
  if(grepl("mac.binary",.Platform$pkgType)){
    stop("Currently MacOs is not supported by ", getPackageName())
    
    # maj_v_number <- as.numeric(strsplit(
    #   Sys.info()["release"][[1]], ".", fixed = TRUE)[[1]][1])
    # 
    # if(maj_v_number < 13.0){
    #   stop("pre-mavericks mac OSX is not supported. Consider upgrading")
    # }
    # 
    # return(run_glmOSx(sim_folder, verbose, system.args))

  }
}

glm.systemcall <- function(sim_folder, glm_path, verbose, system.args){
  
  if(nchar(Sys.getenv("GLM_PATH")) > 0){
    glm_path <- Sys.getenv("GLM_PATH")
    warning(paste0(
      "Custom path to GLM executable set via 'GLM_PATH' environment variable as: ", 
      glm_path))
  }
  
  origin <- getwd()
  setwd(sim_folder)
  
  tryCatch({
    if(verbose){
      out <- system2(glm_path, wait = TRUE, stdout = "", 
                     stderr = "", args = system.args)
    }else{
      out <- system2(glm_path, wait = TRUE, stdout = NULL, 
                     stderr = NULL, args = system.args)
    }
    setwd(origin)
    return(out)
  }, error = function(err){
    print(paste("GLM_ERROR:  ", err))
    setwd(origin)
  })
}

### Windows ###
run_glmWin <- function(sim_folder, verbose, system.args){
  glm_path <- system.file("exec/windows/glm.exe", package=packageName())
  glm.systemcall(sim_folder, glm_path, verbose, system.args)
}

# ### macOS ###
# run_glmOSx <- function(sim_folder, verbose, system.args){
#   glm_path <- system.file("exec/macglm3", package = "GLM3r")
#   glm.systemcall(sim_folder = sim_folder, glm_path = glm_path, verbose = verbose, system.args = system.args)
# }
# 
# ### Linux ###
# run_glmNIX <- function(sim_folder, verbose, system.args){
#   glm_path <- system.file("exec/glm", package=packageName())
#   
#   Sys.setenv(LD_LIBRARY_PATH=paste(system.file("extbin/nixGLM", 
#                                                package=packageName()), 
#                                    Sys.getenv("LD_LIBRARY_PATH"), 
#                                    sep = ":"))
#   glm.systemcall(sim_folder, glm_path, verbose, system.args)
# }
