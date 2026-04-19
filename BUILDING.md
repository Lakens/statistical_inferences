# Build Instructions

This project is a Quarto book with R code chunks.

## 1) System requirements

Install these tools first:

1. R (>= 4.5 recommended)
2. Quarto CLI
3. JAGS (required for `BEST` via `rjags` in the equivalence chapter)
4. TinyTeX (only needed if you want PDF output)

Notes:

- On Windows, Quarto is typically at `C:\Program Files\Quarto\bin\quarto.exe`.
- If `quarto` is not recognized in PowerShell, restart the terminal after installing Quarto.

## 2) Install R package requirements

From the repository root, run:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" scripts/install_book_requirements.R
```

This installs packages listed in [requirements-r.txt](requirements-r.txt), plus BEST 0.5.4 from CRAN archive.

If BEST installation fails with `rjags` errors, install JAGS first, restart R/terminal, and run the script again.

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
3. BEST/rjags errors:
   - Confirm JAGS is installed.
   - Reinstall with:
   - `Rscript -e "install.packages('rjags', repos='https://cloud.r-project.org')"`
4. PDF failures:
   - Ensure TinyTeX is installed.

## 6) Reproducibility note

For fully pinned package versions over time, consider adding `renv` in a future update.
Current setup uses an explicit package list plus an install script.
