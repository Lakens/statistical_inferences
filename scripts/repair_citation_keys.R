# Repair citation keys in .qmd files by mapping used keys to current keys in include/book.bib
# using normalized string similarity.

read_bib_keys <- function(path) {
  lines <- readLines(path, warn = FALSE)
  m <- regexec("^@[A-Za-z]+\\{([^,]+),\\s*$", lines, perl = TRUE)
  hits <- regmatches(lines, m)
  keys <- vapply(hits, function(x) if (length(x) > 1) x[2] else NA_character_, character(1))
  unique(stats::na.omit(keys))
}

extract_used_keys <- function(qmd_files) {
  out <- character()
  for (f in qmd_files) {
    txt <- paste(readLines(f, warn = FALSE), collapse = "\n")
    m <- gregexpr("@[A-Za-z0-9_:\\-.]+", txt, perl = TRUE)
    hits <- regmatches(txt, m)[[1]]
    if (length(hits)) out <- c(out, sub("^@", "", hits))
  }
  out <- unique(out)
  # Ignore internal cross-refs and obvious non-citations.
  out <- out[!grepl("^(fig|tbl|sec|eq|ch|lst)-", out)]
  out <- out[!grepl("^(https?|[0-9]+)$", out)]
  # Remove trailing punctuation accidentally captured.
  out <- sub("[\\.,;:]+$", "", out)
  unique(out)
}

norm_key <- function(x) {
  tolower(gsub("[^a-z0-9]", "", x))
}

best_match <- function(old_key, bib_keys) {
  n_old <- norm_key(old_key)
  n_bib <- norm_key(bib_keys)

  # Prefer same author prefix and year suffix when available.
  # Heuristic: author token before first underscore/hyphen + 4-digit year at end.
  author_old <- sub("[_-].*$", "", old_key)
  year_old <- sub("^.*_([0-9]{4}[a-z]?)$", "\\1", old_key)
  has_year <- grepl("^[0-9]{4}[a-z]?$", year_old)

  cand <- rep(TRUE, length(bib_keys))
  if (nzchar(author_old)) cand <- cand & startsWith(bib_keys, paste0(author_old, "_"))
  if (has_year) cand <- cand & grepl(paste0("_", year_old, "$"), bib_keys)

  idx <- which(cand)
  if (!length(idx)) idx <- seq_along(bib_keys)

  d <- adist(n_old, n_bib[idx])
  ord <- order(d)
  best_idx <- idx[ord[1]]
  best_dist <- as.integer(d[ord[1]])

  # Confidence heuristic.
  # Accept if normalized keys share strong prefix or edit distance reasonably small.
  nn <- n_bib[best_idx]
  prefix_ok <- startsWith(nn, n_old) || startsWith(n_old, nn)
  relative <- best_dist / max(1, nchar(n_old))
  ok <- prefix_ok || relative <= 0.45

  list(best = bib_keys[best_idx], dist = best_dist, rel = relative, ok = ok)
}

replace_in_file <- function(path, mapping) {
  regex_escape <- function(x) {
    # Escape all regex metacharacters safely for PCRE patterns.
    gsub("([][{}()+*^$|\\\\?.-])", "\\\\\\1", x, perl = TRUE)
  }

  txt <- paste(readLines(path, warn = FALSE), collapse = "\n")
  original <- txt
  for (i in seq_len(nrow(mapping))) {
    old <- mapping$old[i]
    new <- mapping$new[i]
    # Replace only citation tokens prefixed by @ and followed by a non-key character or end.
    pattern <- paste0("@", regex_escape(old), "(?=([^A-Za-z0-9_:\\-.]|$))")
    txt <- gsub(pattern, paste0("@", new), txt, perl = TRUE)
  }
  if (!identical(txt, original)) {
    writeLines(strsplit(txt, "\n", fixed = TRUE)[[1]], path, useBytes = TRUE)
    TRUE
  } else {
    FALSE
  }
}

main <- function() {
  bib_path <- "include/book.bib"
  qmd_files <- list.files(".", pattern = "\\.qmd$", full.names = TRUE)

  bib_keys <- read_bib_keys(bib_path)
  used <- extract_used_keys(qmd_files)

  missing <- setdiff(used, bib_keys)
  if (!length(missing)) {
    cat("No missing citation keys found.\n")
    quit(status = 0)
  }

  matches <- lapply(missing, best_match, bib_keys = bib_keys)
  map <- data.frame(
    old = missing,
    new = vapply(matches, `[[`, character(1), "best"),
    dist = vapply(matches, `[[`, integer(1), "dist"),
    rel = vapply(matches, `[[`, numeric(1), "rel"),
    ok = vapply(matches, `[[`, logical(1), "ok"),
    stringsAsFactors = FALSE
  )

  # Keep only high-confidence mappings.
  map_ok <- map[map$ok, c("old", "new", "dist", "rel")]
  map_ok <- map_ok[!duplicated(map_ok$old), ]

  if (!nrow(map_ok)) {
    cat("No high-confidence mappings found.\n")
    write.csv(map, "citation_key_mapping_candidates.csv", row.names = FALSE)
    cat("Wrote candidates to citation_key_mapping_candidates.csv\n")
    quit(status = 1)
  }

  changed <- 0
  for (f in qmd_files) {
    if (replace_in_file(f, map_ok)) changed <- changed + 1
  }

  write.csv(map_ok, "citation_key_mapping_applied.csv", row.names = FALSE)
  unresolved <- setdiff(extract_used_keys(qmd_files), bib_keys)

  cat("Mapped keys:", nrow(map_ok), "\n")
  cat("Files changed:", changed, "\n")
  cat("Unresolved keys after rewrite:", length(unresolved), "\n")
  if (length(unresolved)) {
    cat(paste(unresolved, collapse = "\n"), "\n")
  }
}

main()
