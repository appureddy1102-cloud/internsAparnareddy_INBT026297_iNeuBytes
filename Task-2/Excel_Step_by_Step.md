# Task 2 — Excel Analysis and Dashboard Guide

## File supplied

Open **`Pharma_Sales_Analysis.xlsx`** in desktop Microsoft Excel. Make a backup copy before editing.

The workbook already contains:

- Raw and cleaned daily data.
- A long/tidy table for PivotTables.
- Working SUM, AVERAGE, COUNT, COUNTIF and SUMIFS examples.
- Monthly, category and weekday summaries.
- Data-quality and monthly-reconciliation sheets.
- A dashboard with Year and Category drop-down controls, formula-driven KPI cards and charts.

**Important limitation:** the workbook includes pivot-style result tables, but not native Excel PivotTable objects. If your mentor requires actual PivotTables, complete Section 5 below. Also capture your own real Excel dashboard screenshot after checking the workbook.

## 1. Learn the meaning of the columns

- `Sale_Date`: the calendar date.
- `M01AB` to `R06`: recorded quantity in eight ATC categories.
- `Total_Quantity`: the sum of all eight categories for that date.
- `Month_Start`: the first day of the month, used to group daily rows into months.
- `Weekday_Name`: Monday, Tuesday, and so on.
- `Is_Complete_Month`: TRUE only when every calendar date in that month is present.

There is no price column. A high quantity does **not** automatically mean high revenue or profit.

## 2. Review the cleaning steps

Open `Clean_Daily` and compare it with `Raw_Daily`.

The cleaning process:

1. Converted the source `datum` text to real Excel dates.
2. Kept every one of the 2,106 daily records; no duplicate rows were found.
3. Preserved decimal quantities instead of rounding them to integers.
4. Added `Total_Quantity` with a row formula such as `=SUM(B2:I2)`.
5. Added calendar fields for filtering and grouping.
6. Excluded the daily `Hour` helper field because its values are 190, 248 and 276—not hours from 0 to 23.
7. Flagged January 2014 and October 2019 as partial months.

No missing-value imputation was performed because no blank cells were found and Kaggle states that the source was already preprocessed.

## 3. Practise the formulas

Open `Formula_Examples`. Column B contains working formulas and column C shows the formula text.

Examples:

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

Counts zero-quantity days for N05C.

```excel
=SUMIFS(Clean_Daily!J2:J2107,Clean_Daily!K2:K2107,2019,Clean_Daily!L2:L2107,1)
```

Adds total quantity only where Year is 2019 and Month_Number is 1.

### Simple meanings

- **SUM:** “Add these numbers.”
- **AVERAGE:** “What is the typical arithmetic mean?”
- **COUNTIF:** “How many rows meet this one condition?”
- **SUMIFS:** “Add values only where all these conditions are true.”

If your preview program does not recalculate formulas, open the workbook in Excel and press **Ctrl+Alt+F9** for a full recalculation. Initial calculated values are cached in the file.

## 4. Review the prepared summaries

### `Monthly_Summary`

Monthly totals are recalculated from daily data with SUMIFS. The sheet includes days observed, expected days and a completeness flag. Month-over-month growth is shown only when both adjacent months are complete.

### `Category_Summary`

This includes total quantity, share, average, median, standard deviation, 95th percentile, maximum and zero-quantity days. Standard deviation describes variation; it does not tell you whether a medicine is clinically appropriate.

### `Weekday_Summary`

Compare `Average_Daily_Quantity`, not just total quantity, because weekdays can have slightly different numbers of observations.

### `Data_Quality` and `Monthly_Reconciliation`

Use these sheets as evidence for your data-cleaning discussion. In particular, the monthly source does not consistently match daily aggregation, so the workbook derives monthly values from daily data.

## 5. Create native PivotTables if required

### A. Monthly sales PivotTable

1. Click any cell in `Long_Daily`.
2. Go to **Insert → PivotTable**.
3. Confirm that the source is the `tblLongSales` table.
4. Place it on a new worksheet and rename that sheet `Pivot_Monthly`.
5. Configure the PivotTable:
   - **Rows:** `Month_Start`
   - **Values:** `Quantity` — summarised by **Sum**
   - **Filters:** `Is_Complete_Month`
6. Set the completeness filter to **TRUE**.
7. Right-click a value → **Value Field Settings → Number Format** and use two decimals.
8. Select **Insert → PivotChart → Line** for a monthly trend.

### B. Medicine-category PivotTable

1. Insert another PivotTable from the `tblLongSales` table on `Long_Daily`.
2. Place it on a new sheet named `Pivot_Category`.
3. Configure:
   - **Rows:** `ATC_Category`
   - **Values:** Sum of `Quantity`
4. Sort largest to smallest.
5. Insert a bar PivotChart.

### C. Optional slicers

1. Click a PivotTable → **Insert Slicer**.
2. Choose `Year` and `ATC_Category`.
3. To control more than one PivotTable, use **Slicer → Report Connections** and select PivotTables built from the same source/cache.
4. Test each slicer before taking screenshots.

**Why use `Long_Daily`?** In the wide table, each category is a separate column. In the long table, category is a field, so PivotTables and slicers can compare categories naturally.

## 6. Use the interactive dashboard

1. Open `Dashboard`.
2. Change the yellow **Year** cell to `All` or a year from 2014–2019.
3. Change the yellow **Category** cell to `All` or one ATC code.
4. Excel recalculates:
   - Total Quantity KPI.
   - Average Daily Quantity KPI.
   - Days in Selection.
   - Monthly trend.
   - Weekday pattern.
5. The category-comparison chart responds to the Year selector and intentionally keeps all categories visible for comparison.

The monthly trend excludes partial January 2014 and October 2019. The KPI cards still include all valid daily records in the selected period.

### Useful checks

With both selectors set to `All`:

- Total Quantity: **127,595.50**.
- Average Daily Quantity: **60.59**.
- Days in Selection: **2,106**.
- Overall leading category: **N02BE, 49.38%**.

If these values do not match, check filters, formula references and whether calculation is set to Automatic.

## 7. Improve the dashboard before submission

You may edit the design, but keep the definitions consistent:

- One clear title and a short subtitle.
- Three or four KPI cards.
- Monthly line chart.
- Category bar chart.
- Weekday or category/month visual.
- Year and category filters.
- A note saying “Quantity, not revenue”.

Avoid 3-D charts, too many colours, or a pie chart with eight crowded slices. Bar and line charts are easier to compare.

## 8. Capture real Excel screenshots

1. Recalculate and save the workbook.
2. Set the dashboard zoom so the entire page is visible.
3. Capture the full dashboard with selectors and charts visible.
4. Optionally capture a filtered view and a native PivotTable.
5. Suggested names:
   - `Excel_Dashboard_All.png`
   - `Excel_Dashboard_Filtered.png`
   - `Excel_PivotTables.png`
6. Put the images in `Major-Project/Screenshots/` and insert the main one into the report.

The PNG files in `Major-Project/Charts/` are generated analysis charts, **not Excel application screenshots**. Place genuine application screenshots in `Major-Project/Screenshots/`.
