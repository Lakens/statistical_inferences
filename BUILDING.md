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

This project is configured to build HTML, PDF, and EPUB for full book renders.

Important: when HTML chapters contain figures, publish the generated `docs/*_files/` folders together with the `.html` files. The online book pages reference those files directly, so missing chapter asset folders lead to broken images on GitHub Pages even if the HTML itself was updated.

Render one chapter:

```powershell
quarto render 17-replication.qmd
```

Note: chapter-only renders are for local iteration. For a full compile, use `quarto render`.

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
3. Rendered HTML local asset references resolve to actual files under the output directory.
4. Rendered HTML warning output (e.g., `Warning:` or `Warning in ...`) is treated as a blocking error by default.
5. Multiple-choice option vectors used by `longmcq`/`mcq`/`shortmcq` contain exactly one `answer =` entry.

From the repository root:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/check_book_tests.R
```

To allow rendered warnings as non-blocking notes, run:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/check_book_tests.R --no-strict-warnings
```

If checks fail, the script exits with a non-zero status and prints file/line hints.

## 7) Reproducibility note

For fully pinned package versions over time, consider adding `renv` in a future update.
Current setup uses an explicit package list plus an install script.
