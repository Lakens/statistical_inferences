suppressPackageStartupMessages({
  library(webexercises)
})

# knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
#   if (before) {
#     if (is.character(options$webex.hide)) {
#       hide(options$webex.hide)
#     } else {
#       hide()
#     }
#   } else {
#     unhide()
#   }
# })

knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
  if (before) {
    if (is.character(options$webex.hide)) {
      paste0("\n::: {.callout-note collapse='true'}\n## ", options$webex.hide, "\n\n")
    } else {
      paste0("\n::: {.callout-note collapse='true'}\n## ", "Solution", "\n\n")
    }
  } else {
    "\n:::\n\n"
  }
})
