# Calendar Table (DAX)

---

## What it does
Creates a reusable date table from 1 Jan 2021 to today with common attributes needed for time‑intelligence calculations:

| Column                | Purpose                                                        |
|-----------------------|----------------------------------------------------------------|
| **Date**              | Base date (continuous)                                         |
| **Date_groupby_month**| First day of the month – useful for month‑level slicers        |
| **Date_groupby_month_desc**| Negative version for descending month sorting            |
| **Day_of_month**      | Day (1‑31)                                                     |
| **Week_number**       | ISO week number (Monday‑first)                                 |
| **Month_number**      | Numeric month (1‑12)                                           |
| **Month_name_sort**   | “MM ‑ MMM” (e.g., `01 - Jan`) for proper month ordering        |
| **Year_month**        | “YYYY MMM” (e.g., `2023 Jan`) for readable labels              |
| **Quarter_name**      | “Q1”, “Q2”…                                                    |
| **Year_digit**        | Calendar year                                                  |
| **Fiscal_date**       | Adjusted to fiscal year starting April 1                        |
| **Fiscal_year**       | Fiscal year label, e.g., `2024 (FY)`                           |
| **Fiscal_year_month** | “FY YYYY MMM” for month‑level fiscal reporting                  |
| **Fiscal_qtr_name**   | Fiscal quarter name, e.g., `Q2`                                |
| **Fiscal_qtr_year_name**| Combined fiscal year & quarter, e.g., `2024 Q2`            |

*Commented‑out columns are kept for reference but omitted to keep the model lean.*

---

## Why this is a best‑practice date table

1. **Continuous, gap‑free dates** – `CALENDAR(date(2021,1,1), TODAY())` guarantees no missing days, which is required for correct time‑intelligence functions.  
2. **Pre‑computed attributes** – Storing month, quarter, week, and fiscal columns avoids repeated `CALCULATE`/`FORMAT` calls in measures, improving performance.  
3. **Sortable keys** – Columns like `Month_name_sort` and `Date_groupby_month_desc` provide natural ordering without extra sort‑by settings.  
4. **Fiscal alignment** – Fiscal columns handle organizations whose fiscal year starts April 1, letting you write simple measures (e.g., `TOTALYTD([Sales], 'Calendar'[Fiscal_date])`).  
5. **Minimal column set** – Only the fields needed for reporting are kept; extra columns are commented out, reducing model size and memory usage.  

---

## Quick usage

```DAX
-- Example: sales YTD (calendar year)
CALCULATE(
    SUM(Sales[Amount]),
    DATESYTD('Calendar'[Date])
)

-- Example: sales YTD (fiscal year)
CALCULATE(
    SUM(Sales[Amount]),
    DATESYTD('Calendar'[Fiscal\_date])
)
