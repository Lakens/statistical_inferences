# Download the preview stills and lengths of the lecture videos used in the book.
#
# Every {{< lecture ID "Title" >}} command in the chapters refers to a video on
# video.edu.nl. This script looks up each video through the platform's public
# API, saves its small preview still as images/lectures/<ID>.jpg, and writes the
# video lengths to images/lectures/lectures.json. The lecture extension
# (_extensions/lecture/lecture.lua) reads both when the book is rendered.
#
# Rerun this script after adding a lecture command or after a video changes:
#   & "C:\Program Files\R\R-4.5.3\bin\Rscript.exe" scripts/download_lecture_videos.R

api_url <- "https://video.edu.nl/api/v1/videos/"
site_url <- "https://video.edu.nl"
out_dir <- file.path("images", "lectures")
thumb_width <- 280

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("This script needs the jsonlite package: install.packages(\"jsonlite\")")
}

qmd_files <- list.files(".", pattern = "\\.qmd$")
qmd_text <- unlist(lapply(qmd_files, readLines, warn = FALSE, encoding = "UTF-8"))
ids <- regmatches(qmd_text, regexpr("\\{\\{< lecture [A-Za-z0-9]+", qmd_text))
ids <- unique(sub("^\\{\\{< lecture ", "", ids))

if (length(ids) == 0) {
  stop("No {{< lecture ID ... >}} commands found in the .qmd files.")
}
message("Found ", length(ids), " lecture videos in ", length(qmd_files), " .qmd files.")

dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
info <- list()
failed <- character(0)

for (id in ids) {
  video <- tryCatch(jsonlite::fromJSON(paste0(api_url, id)), error = function(e) NULL)
  if (is.null(video)) {
    failed <- c(failed, id)
    message("  FAILED to look up ", id)
    next
  }

  thumbs <- video$thumbnails
  if (is.data.frame(thumbs) && nrow(thumbs) > 0) {
    pick <- thumbs[which.min(abs(thumbs$width - thumb_width)), ]
    thumb_url <- pick$fileUrl
  } else {
    thumb_url <- paste0(site_url, video$thumbnailPath)
  }

  dest <- file.path(out_dir, paste0(id, ".jpg"))
  ok <- tryCatch(
    utils::download.file(thumb_url, dest, mode = "wb", quiet = TRUE) == 0,
    error = function(e) FALSE
  )
  if (!ok) {
    failed <- c(failed, id)
    message("  FAILED to download the still of ", id)
    next
  }

  info[[id]] <- list(name = video$name, duration = video$duration)
  message("  ", id, "  ", round(video$duration / 60), " min  ", video$name)
}

jsonlite::write_json(info, file.path(out_dir, "lectures.json"),
                     auto_unbox = TRUE, pretty = TRUE)

if (length(failed) > 0) {
  stop("Could not process ", length(failed), " video(s): ", paste(failed, collapse = ", "))
}
message("Saved ", length(info), " stills and lengths in ", out_dir)
