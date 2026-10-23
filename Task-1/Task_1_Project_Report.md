# Task 1 Project Report — SQL-Based Descriptive Analytics

**Student:** Aparna Reddy  
**Registration No.:** INBT026297  
**Project:** Pharmaceutical Sales Data Analytics

## 1. Objective

Inspect, clean and analyse pharmaceutical sales quantity using MySQL, then produce descriptive statistics, aggregate results and business insights.

## 2. Dataset and scope

- Source: https://www.kaggle.com/datasets/milanzdravkovic/pharma-sales-data
- Task dataset: `Dataset/salesdaily.csv`.
- Rows: 2,106 continuous daily records from 2 January 2014 to 8 October 2019.
- Eight ATC category columns contain quantity, not revenue.
- `Dataset/Data_Dictionary.md` documents categories and engineered fields.

## 3. Method

1. Load raw values into a VARCHAR staging table.
2. Check missing/blank values, duplicate dates, invalid dates, non-numeric fields and calendar consistency.
3. Create a clean daily table using DATE and DECIMAL fields.
4. Preserve source decimals and raw data; do not impute or round unnecessarily.
5. Add a generated Total_Quantity column.
6. Create long date/category and daily-derived monthly views.
7. Use aggregate functions, grouping, filtering, CASE, HAVING and window functions.

A join is not needed for the main numerical queries because the clean table and long view contain all required measures. The supplied category lookup/data dictionary can be joined for descriptions without changing totals.

## 4. Data-quality results

- No blank cells, exact duplicate rows, duplicate dates, invalid dates, negative quantities or missing daily timestamps were found.
- The daily Hour field contains only 190, 248 and 276, so it is not time-of-day and is excluded.
- Hourly totals reconcile with daily totals within floating-point tolerance.
- All 302 weekly rows reconcile when treated as weeks ending Sunday.
- Only 37 of 70 supplied monthly rows match daily aggregation within 0.01 across all categories.
- January 2017 is 1.00 in the supplied monthly file but 2,699.60 when recalculated from daily data. Monthly analysis is therefore daily-derived.

## 5. Main results

| Metric | Result |
|---|---:|
| Total quantity | 127,595.50 |
| Average total quantity/day | 60.59 |
| Peak daily quantity | 198.95 on 30 Dec 2016 |
| Leading category | N02BE — 63,005.40 (49.38%) |
| Top-three category share | 73.09% |
| Highest complete month | January 2019 — 2,875.16 |
| Lowest complete month | July 2017 — 1,251.15 |
| Complete months | 68 |

Category totals and shares:

| ATC | Total quantity | Share |
|---|---:|---:|
| N02BE | 63,005.40 | 49.38% |
| N05B | 18,645.74 | 14.61% |
| R03 | 11,608.82 | 9.10% |
| M01AB | 10,600.94 | 8.31% |
| M01AE | 8,204.62 | 6.43% |
| N02BA | 8,172.21 | 6.40% |
| R06 | 6,107.82 | 4.79% |
| N05C | 1,249.96 | 0.98% |

## 6. Business insights

- N02BE warrants close historical availability review because it accounts for almost half of quantity.
- N05C has zero quantity on 67.90% of days and R03 on 22.98%; a simple average alone is insufficient for intermittent demand.
- Monthly comparisons must distinguish complete and partial periods.
- Results do not establish revenue, profit, causality or a safe purchase quantity.

## 7. Files and execution

- SQL: `pharma_sales_analysis.sql`.
- Calculated results: `query_results/`.
- Additional insights: `Business_Insights.md`.

The final SQL is self-contained: select an allowed existing schema and run it in MySQL 8.0; no CSV path or LOAD DATA is required. It embeds all 2,106 source rows and includes the permission, reserved-alias and ONLY_FULL_GROUP_BY corrections. The result CSVs were calculated from the supplied data using equivalent logic and are used as reconciliation tables.

## 8. Application evidence

- [x] Student executed the corrected script in an online MySQL 8.0 environment; the supplied capture shows a successful 29-query execution message.
- [x] Result captures show 2,106 loaded rows, Total Quantity 127,595.50, Average Daily Quantity 60.59, Peak Daily Quantity 198.95 and category/monthly/annual/weekday outputs.
- [x] Five selected SQL screenshots are stored under `Major-Project/Screenshots/Task-1-SQL/`.
- [x] The older SQL was replaced by the final corrected self-contained script.

The assistant reviewed the supplied result captures but did not independently rerun the script in a local MySQL server.

## 9. Learning

Reliable SQL reporting depends on grain, date coverage and source reconciliation—not only correct syntax. Successful queries can still mislead if partial months or inconsistent source files are ignored.
