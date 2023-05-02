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

if (knitr:::is_latex_output()) {
  backgroundcolor <- "#ffffff"
} else {
  backgroundcolor <- "#fffafa"
}
