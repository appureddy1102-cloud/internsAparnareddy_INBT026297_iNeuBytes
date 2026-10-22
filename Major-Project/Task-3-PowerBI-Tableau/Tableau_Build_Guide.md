# Tableau Build Guide — `Pharma_Sales_Dashboard.twbx`

## Honest file status

A genuine packaged Tableau workbook must be created in Tableau. It has **not** been generated in this package. Do not rename a ZIP, CSV, or image to `.twbx`.

Use Tableau Desktop when a local packaged workbook is required. Tableau Public versions/workflows may require publishing to Tableau Public; follow your mentor's accepted method and privacy rules.

## 1. Connect to data

1. Open Tableau and choose **Connect → To a File → Text file**.
2. Select `pharma_sales_long.csv` from this folder.
3. Check the field types:

| Field | Tableau type |
|---|---|
| Sale_Date | Date |
| Month_Start | Date |
| Quantity | Number (decimal) |
| Year, Month_Number, Weekday_Number | Number (whole) |
| ATC_Category, Category_Description | String |
| Is_Complete_Month | Boolean |
| Month_Name, Weekday_Name | String |

4. Confirm **16,848 rows**.
5. Create an extract if your Tableau version asks for one or if you want a self-contained packaged workbook.
6. Rename the data source to `Pharma Sales Long`.

## 2. Create calculated fields

Open `Tableau_Calculated_Fields.txt` and create:

- **Average Daily Quantity** — `SUM([Quantity]) / COUNTD([Sale_Date])`.
- **Month-over-Month Growth %** — the supplied table calculation.
- Optional **7-Day Moving Average** only for a daily chart.

The denominator must be distinct dates. Using `COUNT([Quantity])` would count date/category rows and give the wrong business meaning.

## 3. Build worksheets

### Sheet 1: `KPI Total`

1. Drag `Quantity` to Text on the Marks card.
2. Change it to `SUM(Quantity)` if needed.
3. Format to two decimals.
4. Add the worksheet title `Total Recorded Quantity`.

Repeat with **Average Daily Quantity** for `KPI Average Daily`.

For a clean dashboard, remove unnecessary row/column dividers and center the text.

### Sheet 2: `Monthly Trend`

1. Drag `Month_Start` to Columns.
2. Right-click it and choose the continuous month/date option that shows each calendar month in sequence.
3. Drag `Quantity` to Rows and use `SUM(Quantity)`.
4. Change the mark type to Line.
5. Drag `Is_Complete_Month` to Filters and select **True**.
6. Title: `Monthly Quantity | Complete Calendar Months`.

### Sheet 3: `Category Sales`

1. Drag `ATC_Category` to Rows.
2. Drag `Quantity` to Columns and use `SUM(Quantity)`.
3. Sort categories descending by total Quantity.
4. Use a Bar mark and show labels.
5. Add `Category_Description` to Tooltip.
6. Title: `Quantity by ATC Category`.

### Sheet 4: `Weekday Demand`

1. Drag `Weekday_Name` to Columns.
2. Drag **Average Daily Quantity** to Rows.
3. Sort Weekday_Name manually Monday through Sunday, or use Weekday_Number for sorting.
4. Use a Column/Bar mark and show labels.
5. Title: `Average Quantity per Observed Day by Weekday`.

### Sheet 5: `MoM Growth` (optional)

1. Use continuous `Month_Start` on Columns.
2. Put the Month-over-Month Growth table calculation on Rows.
3. Compute using Month_Start.
4. Filter to complete months.
5. Format as a percentage.

## 4. Create the dashboard

1. Select **Dashboard → New Dashboard**.
2. Set a fixed size such as 1200 × 800 for a consistent screenshot.
3. Add the title `Pharmaceutical Sales Dashboard | Quantity, not revenue`.
4. Place KPI sheets at the top, Monthly Trend in the centre, Category Sales and Weekday Demand below.
5. Drag `Year` and `ATC_Category` filters into the dashboard.
6. For each filter, use the menu **Apply to Worksheets → All Using This Data Source**.
7. Test one filter and confirm all intended charts change.
8. Add a short note that the period is historical and that quantity is not revenue.

Use the same broad layout and colours as the Power BI guide so the two dashboards are comparable.

## 5. Validate the results

With filters cleared:

| Check | Expected value |
|---|---:|
| SUM(Quantity) | **127,595.50** |
| Average Daily Quantity across all dates | **60.59** |
| N02BE SUM(Quantity) | **63,005.40** |
| N02BE share of total | **49.38%** |
| Complete months | **68** |

If Average Daily Quantity appears around 7.57 rather than 60.59, you may have averaged category-day rows instead of dividing total quantity by distinct dates.

## 6. Save a packaged workbook and screenshots

1. Choose **File → Export Packaged Workbook**. In some versions, use **Save As** and select **Tableau Packaged Workbook (`.twbx`)**.
2. Save it as exactly `Pharma_Sales_Dashboard.twbx` in this folder.
3. Reopen the packaged file and confirm the data is available.
4. Capture actual Tableau screenshots:
   - `Tableau_Dashboard_All.png`
   - `Tableau_Dashboard_Filtered.png`
5. Put them in `Major-Project/Screenshots/` and add the best image to the final report.

A packaged workbook normally includes the workbook and required local data/extract, making it easier for your mentor to open.
