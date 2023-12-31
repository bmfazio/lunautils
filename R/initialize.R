config_hint <- function() {
  cat("You probably want to set up an Rprofile.site file!",
      paste0("It should go in ", file.path(Sys.getenv("R_HOME"), "etc")),
      '- Add "options(repos = "https://cloud.r-project.org/")" so install.packages stops asking',
      '- To link a minimal renv for VSCode+renv integration add options(lunautils.renv_external = <your choice>)',
      "(if you don't know what that is supposed to mean, read https://github.com/rstudio/renv/issues/1129)",
      "Also, targets::tar_script to make a pipeline and stuff.",
      sep = "\n")
      # I probably can make a command to create the renv folder with all relevant pkgs as well
}

safety_check <- function() {
  if(!identical(
    list.files(all.files = TRUE, recursive = TRUE, include.dirs = TRUE),
    character(0)))
      stop("Folder must be completely empty.")
}

init_proj <- function() {
  if(is.null(getOption("lunautils.renv_external")))
    stop("Please set the lunautils.renv_external option first.\n")
  safety_check()

  cat("I will do the following:",
      "> create .Rproj file",
      "> create .code-workspace file",
      "> add a template .Rprofile",
      "> initialize renv",
      "> initialize git repo",
      sep = "\n")

  invisible(readline(prompt="Press [Enter] to continue "))

  usethis::create_project(".")
  vswrkspc <- paste0(basename(getwd()), ".code-workspace")
  fs::file_create(vswrkspc)
  writeLines(c(
'{
  "folders": [
	  {
			"path": "."
		}
	],
	"settings": {
    "r.libPaths": [
      ]
  }
}'), vswrkspc)
  fs::file_create(".Rprofile")
  writeLines(c(
'source("renv/activate.R")
options(defaultPackages = c(
  getOption("defaultPackages")
  # Insert other things you want to load here
))'), ".Rprofile")
  renv::init(".", bare = TRUE,
  settings = list(
    snapshot.type = "explicit",
    external.libraries = getOption("lunautils.renv_external")
  ))
  fs::file_create("DESCRIPTION")
  writeLines("Imports:", "DESCRIPTION")
  use_git <- usethis::use_git
  body(use_git) <- body(usethis::use_git)[1:5]
  use_git()
}

init_lib <- function() {
  safety_check()
  cat("I will do the following:",
      "> create package skeleton",
      "> create .code-workspace file",
      "> put devtools in .Rprofile",
      "> initialize git repo",
      sep = "\n")

  invisible(readline(prompt="Press [Enter] to continue "))

  usethis::create_package(".")
  vswrkspc <- paste0(basename(getwd()), ".code-workspace")
  fs::file_create(vswrkspc)
  writeLines(c(
'{
  "folders": [
	  {
			"path": "."
		}
	],
	"settings": {}
}'), vswrkspc)
  fs::file_create(".Rprofile")
  writeLines(c(
'options(defaultPackages = c(
  getOption("defaultPackages"),
  "devtools"
))'), ".Rprofile")

  usethis::use_agpl_license(version = 3, include_future = TRUE)
  cat(paste0(vswrkspc, "\n"), file = ".Rbuildignore", append = TRUE)
  
  use_git <- usethis::use_git
  body(use_git) <- body(usethis::use_git)[1:5]
  use_git()

  cat("Remember the workflow:",
      "- Create scripts with use_r()",
      "- Add dependencies with use_package()",
      "- Update documentation with document()",
      "- Use check() before installing",
      "- Run install() and enjoy",
      "More info at https://r-pkgs.org/whole-game.html",
      sep = "\n")
}

# Something to find where the global R site file is and add default mirror
# Also maybe eventually extend renv to pkg dev
# And dont forget targets stuff
# And also how to link up with remote github
# Take the stuff out into separate functions e.g. rprofile making

## The usual usual
# git remote add origin https://github.com/bmfazio/lunautils.git
# git branch -M main
# git push -u origin main