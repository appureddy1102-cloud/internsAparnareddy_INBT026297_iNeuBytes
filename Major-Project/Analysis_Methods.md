# Major Project — Analysis Methods

## Business problem

A pharmacy needs to understand historical demand by medicine category and time period. Better demand evidence can support inventory discussions, but this dataset alone cannot produce a safe reorder quantity.

## Business questions

1. What is the total recorded sales quantity over the observed period?
2. Which ATC categories contribute most and least?
3. How does quantity change by month and year?
4. Are there descriptive weekday or hour-of-day patterns?
5. Which categories have high variability or many zero-quantity days?
6. What additional information is required before using the results for purchasing?

## Why daily data is canonical

1. The daily file has 2,106 continuous dates from 2 January 2014 to 8 October 2019.
2. Hourly values aggregate to the daily values within floating-point tolerance.
3. All 302 weekly rows match daily aggregation when treated as weeks ending Sunday.
4. Only 37 of 70 monthly rows match daily aggregation within 0.01 across all categories.
5. January 2017 is a clear mismatch: the supplied monthly total is 1.00, while daily aggregation gives 2,699.60.

Therefore, the project does not average or mix the four granularities. It uses daily data for the main results and derives monthly totals from it. Hourly data is used only for the separate hour-of-day view.

## Cleaning rules

- Parse dates explicitly rather than guessing day/month order.
- Retain original decimal precision; do not convert quantities to integers.
- Do not impute blanks when none are present.
- Do not delete outliers automatically; the source states that outlier treatment was already performed.
- Validate Year, Month and Weekday against the parsed date.
- Exclude the daily Hour helper field from analytical data.
- Add calendar fields and a month-completeness flag.
- Keep partial months visible in coverage tables but exclude them from complete-month trend rankings.

## Calculations

For date `d` and category `c`:

- Daily total = sum of the eight category quantities.
- Category total = sum of that category over selected dates.
- Category share = category total / all-category total × 100.
- Average total daily quantity = sum of daily totals / observed dates.
- Monthly total = sum of daily totals in that month.
- MoM growth = (current complete month − previous complete month) / previous complete month × 100.
- Coefficient of variation = sample standard deviation / mean. It is a relative variability measure, not a stock policy.

## Inventory baseline versus a reorder rule

The analysis supplies historical average, standard deviation, 95th percentile, maximum and zero-day counts by category. These are useful descriptive inputs.

A real reorder decision also needs at least:

- Current usable stock and stock already on order.
- Supplier lead time and lead-time variability.
- Desired service level.
- Pack size and minimum order quantity.
- Expiry dates and storage requirements.
- Price, budget and supplier terms.
- Local prescribing, regulations and pharmacist judgement.

No reorder quantity, safety-stock level or purchase recommendation is invented from the available columns.

## Reproducibility

- Cleaned data: `Major-Project/Cleaned_Data/`.
- Calculated tables: `Major-Project/Analysis/`.
- SQL logic: `Task-1/pharma_sales_analysis.sql`.
- Excel formulas/charts: `Task-2/Pharma_Sales_Analysis.xlsx`.
- Power BI and Tableau build definitions: `Major-Project/Task-3-PowerBI-Tableau/`.
- Charts: `Major-Project/Charts/`.

Student-supplied MySQL execution evidence and genuine Power BI/Tableau evidence are included. Final desktop Excel recalculation and selector testing, Power BI Desktop corrections/reopening, and Tableau corrections/republication remain application-specific manual steps. Do not represent generated analytical previews as application screenshots.
