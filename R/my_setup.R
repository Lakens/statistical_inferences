# book-specific code to include on every page

#par(bg = backgroundcolor)
#theme_set() # for ggplot

knitr::opts_chunk$set(error = FALSE,
                      warning = FALSE,
                      message = FALSE,
                      out.width  = '100%',
                      fig.width  = 8,
                      fig.height = 5,
                      fig.align  = 'center')

backgroundcolor <- "#fffafa"

knitr::opts_hooks$set(label = function(options) {
  if (identical(knitr::opts_current$get("dev"), "pdf")) {
    assign("backgroundcolor", "#ffffff", envir = .GlobalEnv)
  } else {
    assign("backgroundcolor", "#fffafa", envir = .GlobalEnv)
  }
  options
})
