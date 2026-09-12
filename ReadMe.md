GLMr
====


R package for [GLM](https://github.com/AquaticEcoDynamics/glm-aed) model running. `GLMr` holds the version compiled or downloaded from the [website](https://github.com/AquaticEcoDynamics/glm-aed) on 2026-09-12 (version 4.0.0) and should run virtually on any Windows system (Linux and macOS still in planning).  This package does not contain the source code for the model, only the executable. This package was inspired by the original [GLMr package](https://github.com/GLEON/GLMr) (used for GLM v2).

## Installation

You can install GLMr from Github with:

```{r gh-installation, eval = FALSE}
# install.packages("devtools")
devtools::install_github("aemon-j/GLMr")
```
## Usage
Compatible with Windows. Linux and macOS X to be implemented.

### Run
```{r example, eval=FALSE}
library(GLMr)
sim_folder <- system.file('extdata', package = 'GLMr')
run_glm(sim_folder, par_file = 'glm4.nml')
```

### Output
```{r example, eval = FALSE}
library(glmtools)

out_file <- file.path(sim_folder, 'output/output.nc')
plot_var(nc_file = out_file, var_name = 'temp')
```
