# new hack ----

write_custom_footer <- function() {

  file.create("footer.html")
  fileConn <- file("footer.html")

  writeLines(
    c("<div class=\"row\" style=\"padding-top: 2em;\">",
      "<p style=\"text-align: center\">",
      "<img src=\"images/worship.jpg\" style=\"width: 100px; padding: 0; display: inline; vertical-align: top\">",
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

