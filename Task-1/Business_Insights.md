# Task 1 — SQL Results and Business Insights

## What has actually been done

- The supplied `salesdaily.csv` was inspected and calculated with the same logic used in `pharma_sales_analysis.sql`.
- Result tables are supplied in `query_results/`.
- The SQL file contains MySQL 8.0 staging, quality checks, a clean table, analytical views, and business queries.
- The final corrected self-contained SQL has replaced the older script. Student-supplied MySQL 8.0 execution/result screenshots are stored under `Major-Project/Screenshots/Task-1-SQL/`; the CSV result files remain reconciliation tables, not screenshots.

## Verified calculations from the supplied CSV

| Metric | Result | Simple interpretation |
|---|---:|---|
| Daily rows | 2,106 | One continuous row per date |
| Date coverage | 2 Jan 2014–8 Oct 2019 | The first and last calendar months are partial |
| Total recorded quantity | **127,595.50** | Sum of all eight categories over all observed days |
| Average total quantity per day | **60.59** | Historical daily average, not a purchase recommendation |
| Highest daily quantity | **198.95 on 30 Dec 2016** | A peak observed day |
| Leading category | **N02BE: 63,005.40 (49.38%)** | Almost half of recorded quantity |
| Second category | **N05B: 18,645.74 (14.61%)** | The second-largest contributor |
| Lowest-total category | **N05C: 1,249.96 (0.98%)** | Low total and frequent zero-quantity days |
| Complete calendar months | **68** | February 2014 through September 2019 |
| Highest complete month | **January 2019: 2,875.16** | Compare only complete months for fair monthly rankings |
| Lowest complete month | **July 2017: 1,251.15** | A historical low, not proof of a permanent trend |
| Highest weekday average | **Saturday: 65.67 per day** | Descriptive pattern only |
| Lowest weekday average | **Thursday: 57.18 per day** | Saturday's average is about 14.85% higher |

## Category contribution

| Rank | ATC category | Total quantity | Share |
|---:|---|---:|---:|
| 1 | N02BE | 63,005.40 | 49.38% |
| 2 | N05B | 18,645.74 | 14.61% |
| 3 | R03 | 11,608.82 | 9.10% |
| 4 | M01AB | 10,600.94 | 8.31% |
| 5 | M01AE | 8,204.62 | 6.43% |
| 6 | N02BA | 8,172.21 | 6.40% |
| 7 | R06 | 6,107.82 | 4.79% |
| 8 | N05C | 1,249.96 | 0.98% |

The top three categories together account for approximately **73.09%** of total recorded quantity.

## Data-quality findings

1. No blank cells, exact duplicate rows, duplicate dates, invalid dates, negative category values, or missing daily timestamps were found in the supplied daily file.
2. The daily `Hour` field contains only 190, 248, and 276. It is not a valid time-of-day field and is excluded from the clean daily table. Use `saleshourly.csv` for hour-of-day analysis.
3. Hourly totals reconcile with daily totals within floating-point tolerance.
4. All 302 supplied weekly totals reconcile with daily data when the weekly date is treated as **week ending Sunday**.
5. Only **37 of 70** supplied monthly rows match daily aggregation within 0.01 across every category. For example:
   - Supplied monthly total for January 2017: **1.00**.
   - Total recalculated from daily records for January 2017: **2,699.60**.
   Therefore, monthly analysis is rebuilt from daily data rather than silently mixing the two sources.

## Practical business meaning

- **Availability priority:** N02BE deserves close stock monitoring because it carries the largest historical quantity share. This does not mean it has the highest revenue or profit; those fields are absent.
- **Intermittent demand:** N05C has 1,430 zero-quantity days (67.90%) and R03 has 484 (22.98%). Do not rely on a simple average alone for these categories.
- **Monthly planning:** Use complete-month trends and label partial periods. Do not compare the eight days in October 2019 directly with a full month.
- **Weekday review:** The Saturday pattern can prompt a staffing or replenishment review, but it does not prove a cause.
- **Clinical and operational caution:** Final stock decisions require a pharmacist plus current stock, lead time, expiry, supplier, price, and local prescribing information.
