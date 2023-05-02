# booktem styles and functions
# do not edit unless you're sure what you're doing!!!!!

suppressPackageStartupMessages({
  library(stats) # stops dplyr filter being masked
  library(knitr)
})

# default knitr options ----
knitr::opts_chunk$set(
  echo       = TRUE,
  results    = "hold",
  out.width  = '100%',
  fig.width  = 8,
  fig.height = 5,
  fig.align  = 'center',
  dpi = 96
)

## set class for a chunk using class="className" ----
knitr::knit_hooks$set(class = function(before, options, envir) {
  if (before) {
    sprintf("<div class = '%s'>", options$class)
  } else {
    "</div>"
  }
})

## verbatim code chunks ----
knitr::knit_hooks$set(verbatim = function(before, options, envir) {
  if (before) {
    sprintf("<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{%s}</code></pre>", options$verbatim)
  } else {
    "<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>"
  }
})


## glossary functions ----

## link to glossary with shortdef on hover
#' Display glossary entry
#'
#' @param term The glossary term to link to, can contain spaces
#' @param display The display (if different than the term)
#' @param def The short definition to display on hover and in the glossary table; if NULL, this will be looked up from https://psyteachr.github.io/glossary/
#' @param link whether to include a link to https://psyteachr.github.io/glossary/
#' @param add_to_table whether to add to the table created by glossary_table()
#' @param show_def whether to show the definition or just the term
#'
#' @return string with the link and hover text
#' @export
#'
#' @examples
#' glossary("alpha")
#' glossary("alpha", "$\\alpha$")
#' glossary("alpha", def = "The first letter of the Greek alphabet")
#' glossary("alpha", show_def = TRUE)
glossary <- function(term,
                     display = term,
                     def = NULL,
                     add_to_table = TRUE,
                     show_def = FALSE,
                     glossary = "include/glossary.yml") {
  if (is.null(def)) {
    # look up definition from glossary file if not given
    def <- tryCatch({
      gloss <- yaml::read_yaml(glossary)
      index <- grep(term, gloss, ignore.case = TRUE)
      if (length(index)) term <- names(gloss)[index]
      gloss[[index]]
    },
    error = function(e) {
      return("")
    })
  }

  ## add to global glossary for this book
  if (add_to_table) {
    env <- .GlobalEnv
    if (!exists(".myglossary", envir = env)) {
      assign(".myglossary", list(), envir = env)
    }
    .myglossary[term] <<- def
  }

  if (show_def) {
    def # just show the definition
  } else {
    # just add the tooltip and don't link to the definition webpage
    paste0("<a class='glossary' title='", def, "'>", display, "</a>")
  }
}


#' Reset glossary table
#'
#' Resets the list .myglossary in the parent environment that collects glossary entries for the table
#'
#' @return NULL
#' @export
#'
#' @examples
#' reset_glossary()
#'
reset_glossary <- function() {
  env <- .GlobalEnv
  assign(".myglossary", list(), envir = env)
}

#' Display glossary table
#'
#' @param as_kable if the output should be a kableExtra table or a data frame
#'
#' @return kable table or data frame
#' @export
glossary_table <- function(as_kable = TRUE) {
  env <- .GlobalEnv
  if (!exists(".myglossary", envir = env)) {
    assign(".myglossary", list(), envir = env)
  }
  glossary <- .myglossary
  if (is.null(glossary)) glossary <- list()

  term <- names(glossary)
  pandocto <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  is_latex <- !is.null(pandocto) && pandocto == "latex"

  the_list <- data.frame(
    term = term,
    definition = unlist(glossary)
  )

  if (is.null(term)) {
    data.frame()
  } else if (as_kable) {
    k <- kableExtra::kable(the_list[order(term),],
                           escape = is_latex,
                           row.names = FALSE)
    kableExtra::kable_styling(k)
  } else {
    the_list[order(term),]
  }
}
