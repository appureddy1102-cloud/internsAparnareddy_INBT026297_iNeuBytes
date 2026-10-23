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

## 7. Power BI and Tableau application evidence

### Power BI

A genuine student-created `Pharma_Sales_Dashboard.pbix` is included in this folder. Its ZIP integrity passed, and the package contains a data model, report definitions and four report pages. It was structurally checked but not reopened in this environment. Report-definition inspection found Year-level monthly trends, no complete-month report filter, weekday charts sorted by value, a Weekday series/tooltip on the main category chart, saved N02BA/N02BE selections, and label/page-name issues. These are pending Power BI Desktop corrections.

Selected screenshots are under `Major-Project/Screenshots/Task-3-PowerBI/`:

- `PowerBI_01_Dashboard_Summary.png` — Summary page 4 of 4 with KPI and category evidence; labels and KPI formatting require correction.
- `PowerBI_02_Sales_Analysis.png` — earlier two-page category, weekday and Year-trend capture; recapture from the final four-page PBIX.
- `PowerBI_03_Filtered_Development_View.png` — earlier filtered development capture, not represented as the final layout.

Apply the documented PBIX corrections in Power BI Desktop, save, close, reopen and test all four pages. Replace the Summary and Sales Analysis captures and add a filtered capture of the final layout. Desktop interactivity is not independently claimed.

### Tableau

The student's Tableau Public dashboard is:

https://public.tableau.com/app/profile/tallapureddy.reddy/viz/Pharma_Sales_Dashboard_/PharmaSalesDashboard?publish=yes

Tableau's static preview and three Desktop/Public application captures are included under `Major-Project/Screenshots/`. The dashboard displays Year of Month Start; use continuous Month with complete-month filtering. Also show/test Year and ATC filters, sort weekdays Monday–Sunday, format the total to two decimals and correct the layout before republication. Replace the final captures after testing. A local `.twbx` and independent interactive-filter validation are not claimed.

See `Major-Project/Documentation/Application_Evidence_Register.md` for the complete evidence scope.

## 8. Learning

BI measures respond to filter context. Correct data types, date relationships, time granularity and distinct-date denominators are essential for reliable dashboard KPIs.
