# Task 2 Project Report — Excel Analysis and Dashboard

**Student:** Aparna Reddy  
**Registration No.:** INBT026297  
**Workbook:** `Pharma_Sales_Analysis.xlsx`

## 1. Objective

Clean the pharmaceutical dataset in Excel, apply appropriate formulas, summarise monthly and category trends, create charts and provide a professional interactive dashboard.

## 2. Data preparation

The workbook preserves `Raw_Daily` and adds:

- `Clean_Daily`: parsed dates, original category precision, Total_Quantity formulas and calendar fields.
- `Long_Daily`: 16,848 date/category rows for PivotTables and BI.
- `Data_Quality`: missing, duplicate, date and negative-value checks.
- `Monthly_Reconciliation`: supplied monthly totals compared with daily-derived totals.
- Partial-month flags for January 2014 and October 2019.

No duplicate deletion or missing-value imputation was required. Decimal quantities were retained.

## 3. Formula examples

```excel
=SUM(Clean_Daily!J2:J2107)
```
Adds all daily total quantities.

```excel
=AVERAGE(Clean_Daily!J2:J2107)
```
Calculates average total quantity per observed day.

```excel
=COUNTIF(Clean_Daily!G2:G2107,0)
```
Counts N05C zero-quantity days.

```excel
=SUMIFS(Clean_Daily!J2:J2107,Clean_Daily!K2:K2107,2019,Clean_Daily!L2:L2107,1)
```
Adds January 2019 quantity using Year and Month conditions.

## 4. PivotTables and charts

Use `Long_Daily`/`tblLongSales` for native PivotTables:

- Monthly: Rows = Month_Start; Values = Sum of Quantity; Filter = Is_Complete_Month TRUE.
- Category: Rows = ATC_Category; Values = Sum of Quantity; sort descending.
- Add line and bar PivotCharts and optional Year/ATC_Category slicers.

The supplied workbook contains pivot-style summaries, formulas and charts. Native PivotTable objects must be inserted and checked in desktop Excel if strictly required.

## 5. Dashboard

The Dashboard sheet provides:

- Total Quantity, Average Daily Quantity, Days in Selection and leading-category KPI cards.
- Year and Category drop-down selectors.
- Monthly complete-month trend.
- Category comparison and weekday pattern charts.

Unfiltered validation values:

| Check | Expected |
|---|---:|
| Total Quantity | 127,595.50 |
| Average Daily Quantity | 60.59 |
| Days in Selection | 2,106 |
| N02BE share | 49.38% |

## 6. Key findings

- N02BE contributes 49.38% of total quantity; the top three categories contribute 73.09%.
- January 2019 is the highest complete month at 2,875.16.
- Saturday has the highest weekday average at 65.67 per observed day.
- N05C and R03 show frequent zero-quantity days and require intermittent-demand interpretation.

## 7. Recommendations

1. Prioritise N02BE availability review, without interpreting quantity as revenue.
2. Use complete-month views for monthly planning and label partial periods.
3. Include variability and zero-day frequency in category reviews.
4. Confirm historical calendar patterns with current pharmacy evidence before operational changes.

## 8. Remaining evidence

- [ ] Open in desktop Excel and recalculate/validate the workbook.
- [ ] Add native PivotTables if required by the official instructions.
- [ ] Capture real Excel dashboard and PivotTable screenshots.
- [ ] Insert actual screenshots into the combined Google Doc.

## 9. Learning

Long-format data simplifies category PivotTables and slicers. Average per observed day can be more meaningful than totals alone when coverage differs, and cached formula results should still be recalculated and validated in Excel.
