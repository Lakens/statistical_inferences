# render book as html ----
bookdown::render_book("index.Rmd", "bookdown::bs4_book", quiet = TRUE)
browseURL("docs/index.html")

# render book as PDF ----
bookdown::render_book("index.Rmd", "bookdown::pdf_book", quiet = TRUE)
browseURL("docs/statistical_inferences_book.pdf")

# render book as ePub ----
bookdown::render_book("index.Rmd", "bookdown::epub_book", quiet = TRUE)
browseURL("docs/statistical_inferences_book.epub")

# convert to mobi ----
epub <- file.path(getwd(), "docs/statistical_inferences_book.epub")
# requires the command line tools from calibre
ebook_convert <- "/Applications/calibre.app/Contents/MacOS/ebook-convert"
if (file.exists(epub) & file.exists(ebook_convert)) {
  mobi <- gsub(".epub$", ".mobi", epub)
  if (file.exists(mobi)) file.remove(mobi)
  system(paste(ebook_convert, epub, mobi))
}
