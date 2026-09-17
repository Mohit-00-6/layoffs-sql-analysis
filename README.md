# Tech Layoffs Data Cleaning & Exploratory Analysis (SQL)

This project takes a raw dataset of global tech layoffs and works it through two stages using MySQL: **data cleaning** and **exploratory data analysis (EDA)**. It's a good showcase of practical SQL skills — window functions, CTEs, self-joins, and standard data-wrangling logic — applied to a real-world messy dataset.

## 📊 Dataset

The source table, `layoffs`, contains layoff records with the following columns:

| Column | Description |
|---|---|
| `company` | Company name |
| `location` | City/HQ location |
| `industry` | Industry sector |
| `total_laid_off` | Number of employees laid off |
| `percentage_laid_off` | Percentage of workforce laid off |
| `date` | Date of the layoff event |
| `stage` | Company funding stage (e.g. Post-IPO, Series C) |
| `country` | Country |
| `funds_raised_millions` | Total funds raised, in millions |


## 🛠 Tools Used

- **MySQL** (Workbench or CLI)
- Window functions (`ROW_NUMBER()`, `DENSE_RANK()`, `SUM() OVER()`)
- CTEs (including multi-CTE queries)
- Self-joins for null-filling

## 📁 Files

| File | Purpose |
|---|---|
| `DATA_CLEANING.sql` | Cleans the raw `layoffs` table |
| `EXPLORATORY_DATA_ANALYSIS.sql` | Explores trends and patterns in the cleaned data |

## 🧹 Data Cleaning Steps

1. **Staging tables** — copy raw data into `layoff_staging` / `layoff_staging_2` so the original table is never modified directly.
2. **Remove duplicates** — use `ROW_NUMBER()` partitioned across all columns to flag exact duplicate rows, then delete anything beyond the first occurrence.
3. **Standardize the data**:
   - Trim whitespace from `company` names.
   - Consolidate inconsistent `industry` labels (e.g. all `Crypto%` variants → `Crypto`).
   - Strip trailing periods from `country` values (e.g. `United States.` → `United States`).
   - Convert `date` from text to a proper `DATE` type using `STR_TO_DATE`.
4. **Handle null/blank values**:
   - Convert blank `industry` strings to `NULL` for consistency.
   - Self-join the table on `company` + `location` to backfill missing `industry` values from matching rows.
   - Remove rows where both `total_laid_off` and `percentage_laid_off` are `NULL` — these carry no usable information.
5. **Drop helper columns** — remove the temporary `row_num` column once de-duplication is done.

## 🔍 Exploratory Data Analysis Highlights

- Maximum single-event layoffs and highest layoff percentages.
- Companies with the largest layoffs overall (and by year).
- Date range covered by the dataset.
- Layoffs aggregated by **industry**, **country**, and **funding stage**.
- Year-over-year layoff totals.
- **Rolling monthly total** of layoffs using a CTE + window function.
- **Top 5 companies by layoffs for each year**, using `DENSE_RANK()` inside a multi-CTE query.

## ▶️ How to Run

1. Create a MySQL database and import your raw layoffs CSV into a table named `layoffs`.
2. Run `DATA_CLEANING.sql` from top to bottom to produce the cleaned `layoff_staging_2` table.
3. Run `EXPLORATORY_DATA_ANALYSIS.sql` against `layoff_staging_2` to reproduce the analysis.

## 📌 Notes

- This project follows the common "layoffs" SQL practice dataset used in many data analytics tutorials — a solid demonstration of end-to-end SQL data cleaning + EDA for a portfolio.
- Feel free to extend the EDA section with your own questions (e.g. layoffs by company stage over time, correlation between funds raised and layoff percentage, etc.).

