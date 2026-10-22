# Task 3 Project Report — Business Intelligence Dashboard

**Student:** Aparna Reddy  
**Registration No.:** INBT026297  
**Topic:** Pharmaceutical Sales Quantity Dashboard

## 1. Objective

Prepare a reusable long-format dataset, define consistent KPIs and build an interactive Power BI or Tableau dashboard with time and category filters.

## 2. Data preparation

Use `pharma_sales_long.csv`:

- 16,848 rows = 2,106 dates × 8 ATC categories.
- Sale_Date and Month_Start: Date.
- Quantity: Decimal.
- Year, Month_Number and Weekday_Number: Whole number.
- ATC_Category and Category_Description: Text.
- Is_Complete_Month: Boolean.

The long format preserves zero-quantity rows and allows one ATC_Category filter to control all relevant visuals.

## 3. KPIs and calculated measures

Power BI examples:

```DAX
Total Quantity = SUM('Sales'[Quantity])
```

```DAX
Days in Selection = COUNTROWS(VALUES('Date'[Date]))
```

```DAX
Average Daily Quantity = DIVIDE([Total Quantity], [Days in Selection])
```

```DAX
Peak Daily Quantity = MAXX(VALUES('Date'[Date]), [Total Quantity])
```

Tableau example:

```text
SUM([Quantity]) / COUNTD([Sale_Date])
```

A separate Power BI Date table and relationship are defined in `PowerBI_Measures.dax`. Previous-month and category-share measures are also supplied.

## 4. Dashboard design

- KPI cards: Total Quantity, Average Daily Quantity and Peak Daily Quantity.
- Monthly line chart: Month Start + Total Quantity; complete-month visual filter.
- Category bar chart: ATC_Category + Total Quantity; descending sort.
- Weekday chart: Weekday + Average Daily Quantity; Monday–Sunday order.
- Filters: Year and ATC_Category; optional Weekday.
- Note: historical quantity, not revenue.

## 5. Validation checks

| Check | Expected unfiltered value |
|---|---:|
| Total Quantity | 127,595.50 |
| Average Daily Quantity | 60.59 |
| N02BE Total Quantity | 63,005.40 |
| N02BE share | 49.38% |
| Complete months | 68 |

If the average is calculated using long-table row count rather than distinct dates, its business meaning will be wrong.

## 6. Business insights

- N02BE dominates historical quantity and should be visible as the leading category.
- Complete-month filtering prevents partial endpoints from distorting monthly comparisons.
- Year/category filters allow users to investigate whether broad patterns hold in subsets.
- Consistent measures allow SQL, Excel and BI outputs to be reconciled.

## 7. Current file status and manual steps

A genuine `.pbix` or `.twbx` has **not** been generated in this environment. The folder contains data, DAX, Tableau calculations and build guides—not a substitute application file.

Before P1 submission:

- [ ] Build the dashboard in Power BI Desktop or Tableau.
- [ ] Validate all unfiltered and filtered results.
- [ ] Save a genuine `Pharma_Sales_Dashboard.pbix` or `Pharma_Sales_Dashboard.twbx` here.
- [ ] Reopen the saved file to verify it functions.
- [ ] Capture actual dashboard and filtered-view screenshots.
- [ ] Add screenshots to the combined Google Doc.

## 8. Learning

BI measures respond to filter context. Correct data types, date relationships, time granularity and distinct-date denominators are essential for reliable dashboard KPIs.
