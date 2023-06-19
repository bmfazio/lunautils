init_proj <- function() {
  cat("I will do the following:",
      "> create .Rproj file",
      "> create .code-workspace file",
      "> initialize renv",
      "> initialize git repo",
      sep = "\n")

  usethis::create_project(".")
  vswrkspc <- paste0(basename(getwd()), ".code-workspace")
  fs::file_create(
    vswrkspc
  )
  writeLines(c(
'{
  "folders": [
	  {
			"path": "."
		}
	],
	"settings": {}
}'
  ), vswrkspc)
  renv::init(".")
  usethis::use_git()
}

init_lib <- function() {
  cat("I will do the following:",
      "> create package skeleton",
      "> create .code-workspace file",
      "> initialize git repo",
      sep = "\n")

  usethis::create_package(".")
  vswrkspc <- paste0(basename(getwd()), ".code-workspace")
  fs::file_create(
    vswrkspc
  )
  writeLines(c(
'{
  "folders": [
	  {
			"path": "."
		}
	],
	"settings": {}
}'
  ), vswrkspc)
  usethis::use_git()

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