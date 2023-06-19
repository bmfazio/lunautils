init_proj <- function() {
  cat("I will do the following:",
      "> create .Rproj file",
      "> create .code-workspace file",
      "> initialize renv",
      "> add a template .Rprofile",
      "> initialize git repo",
      sep = "\n")

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
      "C:/Users/fazio/config/vscode-R/renv/library/R-4.3/x86_64-w64-mingw32"
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
  renv::init(".")
  use_git <- usethis::use_git
  body(use_git) <- body(usethis::use_git)[1:5]
  use_git()
}

init_lib <- function() {
  cat("I will do the following:",
      "> create package skeleton",
      "> create .code-workspace file",
      "> put devtools in .Rprofile",
      "> initialize git repo",
      sep = "\n")

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

# Remember to set libpath so VSCode wont clash with renv
# credit to https://github.com/rstudio/renv/issues/1129
# https://github.com/REditorSupport/vscode-R/wiki/Working-with-renv-enabled-projects