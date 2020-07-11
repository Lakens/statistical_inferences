# new hack ----

write_custom_footer <- function() {

  file.create("footer.html")
  fileConn <- file("footer.html")

  writeLines(
    c("<div class=\"row\" style=\"padding-top: 2em;\">",
      "<p style=\"text-align: center\">",
      "<img src=\"images/logo_dark.png\" style=\"width: 100px; padding: 0; display: inline; vertical-align: top\">",
      "<span style=\"display: inline-block; margin-left: 2em; margin-top: 16px; font-size: small\">",
      "<span style=\"font-weight: bold;\">Eric P. Green</span><br/>",
      "<a href=\"https://themethodsection.com\">themethodsection.com</a><br/>",
      paste("page built ", as.character(Sys.Date())),
      "</span>",
      "</p>",
      "</div>"),
    fileConn)

  close(fileConn)
}


# old hack ----

# add_foot <- function(html_file) {
#   html <- xfun::read_utf8(html_file)
#   date_lines <- which(str_detect(html, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))
#
#   html[rev(date_lines)[1]] <- paste0(html[rev(date_lines)[1]],
#                                      '</p><p class="build-date">\nEric Green, <a href="http://themethodsection.com/">themethodsection.com.</a>')
#   xfun::write_utf8(html, html_file)
# }
#
# ##  apply to all chapters
# html_files <- list.files('ebook', pattern = ".html", full.names = TRUE)
# lapply(html_files, add_foot)
#
