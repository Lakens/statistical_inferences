#!/usr/bin/env Rscript

# Book integrity checks:
# 1) Figure cross-references in source resolve to defined figure labels.
# 2) Rendered HTML contains no unresolved cross-reference markers.
# 3) Multiple-choice question option blocks contain exactly one `answer =` entry.
# 4) Rendered HTML local asset references resolve to files in the output directory.
# 5) Rendered figure image references (e.g., *_files/figure-html/*) resolve to files.
# 6) Rendered warnings are treated as blocking errors by default.

args <- commandArgs(trailingOnly = TRUE)
strict_warnings <- TRUE
if ("--no-strict-warnings" %in% args || "--allow-warnings" %in% args) {
  strict_warnings <- FALSE
}
if ("--strict-warnings" %in% args) {
  strict_warnings <- TRUE
}

book_root <- getwd()
quarto_yml <- file.path(book_root, "_quarto.yml")

if (!file.exists(quarto_yml)) {
  stop("Could not find _quarto.yml in working directory: ", book_root)
}

read_book_chapters <- function(yml_path) {
  lines <- readLines(yml_path, warn = FALSE)
  chapter_lines <- grep("^\\s*-\\s+.*\\.qmd\\s*$", lines, perl = TRUE, value = TRUE)
  chapters <- sub("^\\s*-\\s+", "", chapter_lines, perl = TRUE)
  chapters <- trimws(chapters)
  chapters <- chapters[file.exists(chapters)]
  unique(chapters)
}

read_output_dir <- function(yml_path) {
  lines <- readLines(yml_path, warn = FALSE)
  hit <- grep("^\\s*output-dir\\s*:\\s*", lines, perl = TRUE, value = TRUE)
  if (length(hit) == 0) return("docs")
  out <- sub("^\\s*output-dir\\s*:\\s*", "", hit[1], perl = TRUE)
  trimws(out)
}

missing_download_formats <- function(output_dir, formats = c("pdf", "epub"), fallback_dir = ".") {
  candidate_dirs <- unique(c(output_dir, fallback_dir))
  existing_dirs <- candidate_dirs[dir.exists(candidate_dirs)]

  if (length(existing_dirs) == 0L) {
    return(formats)
  }

  missing_formats <- formats[vapply(
    formats,
    function(fmt) {
      files <- unlist(lapply(existing_dirs, function(d) {
        list.files(d, pattern = paste0("\\.", fmt, "$"), full.names = TRUE)
      }), use.names = FALSE)
      length(files) == 0L
    },
    logical(1)
  )]

  missing_formats
}

count_pattern <- function(text, pattern) {
  m <- gregexpr(pattern, text, perl = TRUE)
  if (length(m) == 0 || m[[1]][1] == -1) return(0L)
  length(m[[1]])
}

strip_quoted_strings <- function(x) {
  x <- gsub('"([^"\\\\]|\\\\.)*"', '""', x, perl = TRUE)
  x <- gsub("'([^'\\\\]|\\\\.)*'", "''", x, perl = TRUE)
  x
}

extract_fig_refs <- function(lines) {
  refs <- unique(unlist(regmatches(lines, gregexpr("@fig-[A-Za-z0-9_-]+", lines, perl = TRUE))))
  if (length(refs) == 0) return(character(0))
  sub("^@", "", refs)
}

extract_fig_labels <- function(lines) {
  chunk_vals <- grep("^\\s*```\\{r", lines, perl = TRUE, value = TRUE)
  chunk_labels <- character(0)
  if (length(chunk_vals) > 0) {
    for (cv in chunk_vals) {
      header <- sub("^\\s*```\\{r(.*)\\}\\s*$", "\\1", cv, perl = TRUE)
      parts <- trimws(unlist(strsplit(header, ",", fixed = TRUE)))
      parts <- parts[nzchar(parts)]
      if (length(parts) == 0) next

      # Quarto chunk label is the first non-empty token if it is not an option key=value.
      first_token <- parts[1]
      if (!grepl("=", first_token, fixed = TRUE) && grepl("^[A-Za-z][A-Za-z0-9_-]*$", first_token)) {
        chunk_labels <- c(chunk_labels, first_token)
      }
    }
    chunk_labels <- chunk_labels[grepl("^fig-", chunk_labels)]
  }

  opt_vals <- grep("^\\s*#\\|\\s*label\\s*:\\s*fig-[A-Za-z0-9_-]+", lines, perl = TRUE, value = TRUE)
  opt_labels <- character(0)
  if (length(opt_vals) > 0) {
    opt_labels <- sub("^\\s*#\\|\\s*label\\s*:\\s*(fig-[A-Za-z0-9_-]+).*$", "\\1", opt_vals, perl = TRUE)
  }

  unique(c(chunk_labels, opt_labels))
}

extract_c_blocks <- function(lines) {
  blocks <- list()
  i <- 1L
  n <- length(lines)

  while (i <= n) {
    line <- lines[i]
    m <- regexec("^\\s*([A-Za-z][A-Za-z0-9_.]*)\\s*<-\\s*c\\(", line, perl = TRUE)
    g <- regmatches(line, m)[[1]]

    if (length(g) > 1) {
      var_name <- g[2]
      start <- i
      j <- i
      depth <- 0L

      repeat {
        cleaned <- strip_quoted_strings(lines[j])
        depth <- depth + count_pattern(cleaned, "\\(") - count_pattern(cleaned, "\\)")

        if (depth <= 0L || j >= n) break
        j <- j + 1L
      }

      block_text <- paste(lines[start:j], collapse = "\n")
      answer_count <- length(unlist(regmatches(block_text, gregexpr("\\banswer\\s*=", block_text, perl = TRUE))))

      blocks[[length(blocks) + 1L]] <- list(
        var = var_name,
        start = start,
        end = j,
        answer_count = answer_count
      )

      i <- j + 1L
    } else {
      i <- i + 1L
    }
  }

  blocks
}

check_mc_answers <- function(file_path) {
  lines <- readLines(file_path, warn = FALSE)
  blocks <- extract_c_blocks(lines)

  call_idx <- grep("\\b(longmcq|mcq|shortmcq)\\s*\\(", lines, perl = TRUE)
  if (length(call_idx) == 0) return(list(errors = character(0), warnings = character(0)))

  errors <- character(0)
  warnings <- character(0)

  for (ln in call_idx) {
    call_line <- lines[ln]
    m <- regexec("\\b(?:longmcq|mcq|shortmcq)\\s*\\(\\s*([A-Za-z][A-Za-z0-9_.]*)", call_line, perl = TRUE)
    g <- regmatches(call_line, m)[[1]]

    if (length(g) <= 1) next
    var_name <- g[2]

    candidates <- Filter(function(b) b$var == var_name && b$start < ln, blocks)
    if (length(candidates) == 0) {
      warnings <- c(warnings, sprintf("%s:%d - Could not find option block for %s before mcq call", file_path, ln, var_name))
      next
    }

    starts <- vapply(candidates, function(b) b$start, integer(1))
    block <- candidates[[which.max(starts)]]

    if (block$answer_count != 1L) {
      errors <- c(errors, sprintf(
        "%s:%d - MC options for %s have %d answer= entries (expected exactly 1)",
        file_path, block$start, var_name, block$answer_count
      ))
    }
  }

  list(errors = unique(errors), warnings = unique(warnings))
}

check_html_unresolved_refs <- function(output_dir) {
  html_files <- character(0)
  if (dir.exists(output_dir)) {
    html_files <- list.files(output_dir, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
    if (length(html_files) == 0) {
      return(list(errors = sprintf("No rendered HTML files found in output directory '%s'. Run `quarto render` first.", output_dir), checked = 0L))
    }
  } else {
    html_files <- list.files(".", pattern = "\\.html$", recursive = FALSE, full.names = TRUE)
  }

  if (length(html_files) == 0) {
    return(list(errors = "No rendered HTML files found. Run `quarto render` first.", checked = 0L))
  }

  errors <- character(0)

  for (f in html_files) {
    lines <- readLines(f, warn = FALSE)
    file_text <- paste(lines, collapse = "\n")

    idx_unresolved <- grep("quarto-unresolved-ref", lines, fixed = TRUE)
    if (length(idx_unresolved) > 0) {
      for (line_idx in idx_unresolved) {
        line <- lines[line_idx]
        href_match <- regexec('href="#([^"]+)"', line, perl = TRUE)
        href_groups <- regmatches(line, href_match)[[1]]

        # Only fail unresolved spans when their anchor target is actually missing.
        if (length(href_groups) > 1) {
          target_id <- href_groups[2]
          target_pat <- paste0('id="', gsub('([\\^$.|?*+(){}\\[\\]\\\\])', '\\\\\\1', target_id, perl = TRUE), '"')
          if (!grepl(target_pat, file_text, perl = TRUE)) {
            errors <- c(errors, sprintf("%s:%d - unresolved cross-reference target is missing in HTML: #%s", f, line_idx, target_id))
          }
        }
      }
    }

    idx_qmark <- grep("(Figure|Table|Section|Chapter)[[:space:]]*\\?", lines, perl = TRUE)
    if (length(idx_qmark) > 0) {
      errors <- c(errors, sprintf("%s:%d - contains possible unresolved '?' cross-reference", f, idx_qmark))
    }

    # Catch raw Quarto labels left in prose, e.g. "Figure fig-metaci".
    idx_raw_labels <- grep(
      "\\b(Figure|Table|Section|Chapter)\\s+(fig|tbl|sec|eq|lem|thm|cor|prp|lst)-[A-Za-z0-9_-]+\\b",
      lines,
      perl = TRUE,
      ignore.case = TRUE
    )
    if (length(idx_raw_labels) > 0) {
      errors <- c(errors, sprintf("%s:%d - contains unresolved raw label text (e.g., Figure fig-...)", f, idx_raw_labels))
    }
  }

  list(errors = unique(errors), checked = length(html_files))
}

check_html_figure_assets <- function(output_dir) {
  html_files <- character(0)
  if (dir.exists(output_dir)) {
    html_files <- list.files(output_dir, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
    if (length(html_files) == 0) {
      return(list(errors = sprintf("No rendered HTML files found in output directory '%s'. Run `quarto render` first.", output_dir), checked = 0L))
    }
  } else {
    html_files <- list.files(".", pattern = "\\.html$", recursive = FALSE, full.names = TRUE)
  }

  if (length(html_files) == 0) {
    return(list(errors = "No rendered HTML files found. Run `quarto render` first.", checked = 0L))
  }

  errors <- character(0)

  for (f in html_files) {
    lines <- readLines(f, warn = FALSE)
    matches <- gregexpr('src="([^"]+)"', lines, perl = TRUE)
    refs <- regmatches(lines, matches)

    for (line_idx in seq_along(refs)) {
      if (length(refs[[line_idx]]) == 0) next

      for (raw_ref in refs[[line_idx]]) {
        asset_path <- sub('^src="([^"]+)"$', "\\1", raw_ref, perl = TRUE)
        asset_path <- sub("[#?].*$", "", asset_path, perl = TRUE)

        # Only enforce rendered figure output assets.
        if (!grepl("_files/figure-html/", asset_path, fixed = TRUE)) next

        local_asset <- normalizePath(file.path(dirname(f), asset_path), winslash = "/", mustWork = FALSE)
        if (!file.exists(local_asset)) {
          errors <- c(errors, sprintf("%s:%d - missing rendered figure asset referenced by HTML: %s", f, line_idx, asset_path))
        }
      }
    }
  }

  list(errors = unique(errors), checked = length(html_files))
}

collect_html_warning_notes <- function(output_dir) {
  html_files <- character(0)
  if (dir.exists(output_dir)) {
    html_files <- list.files(output_dir, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
    if (length(html_files) == 0) {
      return(list(notes = sprintf("No rendered HTML files found in output directory '%s'. Run `quarto render` first.", output_dir), checked = 0L))
    }
  } else {
    html_files <- list.files(".", pattern = "\\.html$", recursive = FALSE, full.names = TRUE)
  }

  if (length(html_files) == 0) {
    return(list(notes = "No rendered HTML files found. Run `quarto render` first.", checked = 0L))
  }

  notes <- character(0)

  for (f in html_files) {
    lines <- readLines(f, warn = FALSE)

    # Catch common rendered warning signatures from knitr/R output.
    idx <- grep("(^|[>[:space:]])Warning(:| in )", lines, perl = TRUE)
    if (length(idx) > 0) {
      notes <- c(notes, sprintf("%s:%d - contains rendered warning text", f, idx))
    }
  }

  list(notes = unique(notes), checked = length(html_files))
}

is_external_asset_ref <- function(path) {
  grepl("^(?:[A-Za-z][A-Za-z0-9+.-]*:|//|#)", path, perl = TRUE)
}

check_html_local_assets <- function(output_dir) {
  html_files <- character(0)
  if (dir.exists(output_dir)) {
    html_files <- list.files(output_dir, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
    if (length(html_files) == 0) {
      return(list(errors = sprintf("No rendered HTML files found in output directory '%s'. Run `quarto render` first.", output_dir), checked = 0L))
    }
  } else {
    html_files <- list.files(".", pattern = "\\.html$", recursive = FALSE, full.names = TRUE)
  }

  if (length(html_files) == 0) {
    return(list(errors = "No rendered HTML files found. Run `quarto render` first.", checked = 0L))
  }

  errors <- character(0)

  for (f in html_files) {
    lines <- readLines(f, warn = FALSE)
    matches <- gregexpr("(?:src|href)=\"([^\"]+)\"", lines, perl = TRUE)
    refs <- regmatches(lines, matches)

    for (line_idx in seq_along(refs)) {
      if (length(refs[[line_idx]]) == 0) next

      for (raw_ref in refs[[line_idx]]) {
        asset_path <- sub('^(?:src|href)="([^"]+)"$', "\\1", raw_ref, perl = TRUE)
        asset_path <- sub("[#?].*$", "", asset_path, perl = TRUE)

        if (!nzchar(asset_path) || is_external_asset_ref(asset_path) || grepl("^data:", asset_path, perl = TRUE)) {
          next
        }

        local_asset <- normalizePath(file.path(dirname(f), asset_path), winslash = "/", mustWork = FALSE)
        if (!file.exists(local_asset)) {
          errors <- c(errors, sprintf("%s:%d - missing local asset referenced by rendered HTML: %s", f, line_idx, asset_path))
        }
      }
    }
  }

  list(errors = unique(errors), checked = length(html_files))
}

chapters <- read_book_chapters(quarto_yml)
if (length(chapters) == 0) {
  stop("No chapter .qmd files discovered from _quarto.yml")
}

cat("Running book checks on", length(chapters), "qmd files\n")

# Check 1: source figure refs
all_refs <- character(0)
all_labels <- character(0)
ref_locations <- list()

for (f in chapters) {
  lines <- readLines(f, warn = FALSE)
  refs <- extract_fig_refs(lines)
  labels <- extract_fig_labels(lines)

  if (length(refs) > 0) {
    all_refs <- c(all_refs, refs)
    for (r in refs) {
      ref_locations[[r]] <- unique(c(ref_locations[[r]], f))
    }
  }

  if (length(labels) > 0) {
    all_labels <- c(all_labels, labels)
  }
}

all_refs <- unique(all_refs)
all_labels <- unique(all_labels)

missing_global <- setdiff(all_refs, all_labels)
fig_errors <- character(0)
if (length(missing_global) > 0) {
  for (m in missing_global) {
    loc <- paste(ref_locations[[m]], collapse = ", ")
    fig_errors <- c(fig_errors, sprintf("Missing figure label '%s' referenced in: %s", m, loc))
  }
}

# Check 2: MC answer count
mc_errors <- character(0)
mc_warnings <- character(0)
for (f in chapters) {
  res <- check_mc_answers(f)
  mc_errors <- c(mc_errors, res$errors)
  mc_warnings <- c(mc_warnings, res$warnings)
}
mc_errors <- unique(mc_errors)
mc_warnings <- unique(mc_warnings)

# Check 3: rendered HTML unresolved refs
output_dir <- read_output_dir(quarto_yml)
missing_downloads <- missing_download_formats(output_dir, fallback_dir = book_root)
html_res <- check_html_unresolved_refs(output_dir)
html_errors <- unique(html_res$errors)

# Check 4: rendered HTML local assets
asset_res <- check_html_local_assets(output_dir)
asset_errors <- unique(asset_res$errors)

# Check 5: rendered figure assets
fig_asset_res <- check_html_figure_assets(output_dir)
fig_asset_errors <- unique(fig_asset_res$errors)

# Check 6: rendered HTML warnings
warn_res <- collect_html_warning_notes(output_dir)
warn_notes <- unique(warn_res$notes)

download_errors <- character(0)
if (length(missing_downloads) > 0) {
  download_errors <- sprintf(
    "Missing required book download output(s): %s in '%s'. Run `quarto render` (full book compile).",
    paste(missing_downloads, collapse = ", "),
    output_dir
  )
}

all_errors <- c(fig_errors, mc_errors, html_errors, asset_errors, fig_asset_errors, download_errors)
if (strict_warnings) {
  all_errors <- c(all_errors, warn_notes)
}

if (length(mc_warnings) > 0) {
  cat("\nWarnings:\n")
  for (w in mc_warnings) cat("-", w, "\n")
}

if (length(warn_notes) > 0) {
  if (strict_warnings) {
    cat("\nRendered warning errors:\n")
    for (n in warn_notes) cat("-", n, "\n")
    cat("- Blocking: rendered warnings are treated as errors. Use --no-strict-warnings to allow them.\n")
  } else {
    cat("\nNotes (rendered warnings found):\n")
    for (n in warn_notes) cat("-", n, "\n")
    cat("- Non-blocking: warnings are reported as notes. Use --strict-warnings to fail on these.\n")
  }
}

if (length(all_errors) > 0) {
  cat("\nFAILED checks:\n")
  for (e in all_errors) cat("-", e, "\n")
  quit(save = "no", status = 1)
}

cat("\nAll checks passed.\n")
cat("- Figure references: OK\n")
cat("- MC answer options (exactly one answer=): OK\n")
cat("- Download outputs (pdf, epub): OK\n")
cat("- Rendered HTML unresolved refs: OK (", html_res$checked, "files checked)\n", sep = "")
cat("- Rendered HTML local assets: OK (", asset_res$checked, "files checked)\n", sep = "")
cat("- Rendered figure assets: OK (", fig_asset_res$checked, "files checked)\n", sep = "")
cat("- Rendered HTML warnings: OK (", warn_res$checked, "files checked)\n", sep = "")
