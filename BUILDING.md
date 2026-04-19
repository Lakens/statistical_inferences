# Build Instructions

This project is a Quarto book with R code chunks.

## 1) System requirements

Install these tools first:

1. R (>= 4.5 recommended)
2. Quarto CLI
3. TinyTeX (only needed if you want PDF output)

Notes:

- On Windows, Quarto is typically at `C:\Program Files\Quarto\bin\quarto.exe`.
- If `quarto` is not recognized in PowerShell, restart the terminal after installing Quarto.

## 2) Install R package requirements

From the repository root, run:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/install_book_requirements.R
```

This installs packages listed in [requirements-r.txt](requirements-r.txt).

## 3) Install TinyTeX (optional, for PDF)

```powershell
quarto install tinytex
```

## 4) Render the book

Render everything:

```powershell
quarto render
```

Render one chapter:

```powershell
quarto render 17-replication.qmd
```

## 5) Troubleshooting

1. `quarto` not found:
   - Use full path:
   - `& "C:\Program Files\Quarto\bin\quarto.exe" render`
2. `d.ind.t is not an exported object from namespace:MOTE`:
   - This repo uses `MOTE::d_ind_t` (updated API).
   - Pull latest changes and re-render.
3. PDF failures:
   - Ensure TinyTeX is installed.

## 6) Run automated book checks

Run integrity checks for:

1. Figure cross-references in source (`@fig-...`) resolve to figure labels.
2. Rendered HTML has no unresolved references (e.g., `quarto-unresolved-ref` or `Figure ?`).
3. Rendered HTML warning output (e.g., `Warning:` or `Warning in ...`) is reported as notes.
4. Multiple-choice option vectors used by `longmcq`/`mcq`/`shortmcq` contain exactly one `answer =` entry.

From the repository root:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/check_book_tests.R
```

To treat rendered warnings as blocking failures, run:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/check_book_tests.R --strict-warnings
```

If checks fail, the script exits with a non-zero status and prints file/line hints.

## 7) Automatic checks in GitHub

This repository includes a GitHub Actions workflow at `.github/workflows/book-checks.yml`.

On every push and pull request (and manual trigger), it will:

1. Install R and Quarto.
2. Install R package dependencies via `scripts/install_book_requirements.R`.
3. Render the book to HTML (`quarto render --to html`).
4. Run `scripts/check_book_tests.R`.

Rendered warning text is reported as notes by default (non-blocking), while figure reference errors, unresolved rendered references, and MC option errors remain blocking.

## 8) Reproducibility note

For fully pinned package versions over time, consider adding `renv` in a future update.
Current setup uses an explicit package list plus an install script.
