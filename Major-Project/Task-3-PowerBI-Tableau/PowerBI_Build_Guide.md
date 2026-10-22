# Power BI Build Guide — `Pharma_Sales_Dashboard.pbix`

## Honest file status

A real `.pbix` file must be created and saved in Power BI Desktop. It has **not** been generated in this package, and a CSV or renamed file must never be presented as one. Use this guide with the supplied BI-ready data and DAX.

Power BI Desktop normally requires Windows. If you do not have it, use an approved college/lab computer or ask your mentor what alternative evidence is accepted.

## 1. Open a new project

1. Open **Power BI Desktop**.
2. Select **File → Blank report**.
3. Save immediately as `Pharma_Sales_Dashboard.pbix` in `Task-3-PowerBI-Tableau`.
4. Use a page size of 16:9 and name the first page `Sales Overview`.

## 2. Import the correct data

1. Select **Home → Get data → Text/CSV**.
2. Choose `pharma_sales_long.csv` from this folder.
3. Select **Transform data**; do not load blindly.
4. In Power Query, set these data types:

| Column | Type |
|---|---|
| Sale_Date | Date |
| Year | Whole number |
| Month_Number | Whole number |
| Month_Start | Date |
| Month_Name | Text |
| Weekday_Number | Whole number |
| Weekday_Name | Text |
| ATC_Category | Text |
| Category_Description | Text |
| Quantity | Decimal number |
| Is_Complete_Month | True/False |

5. Check that there are **16,848 rows**: 2,106 dates × 8 categories.
6. Select **Close & Apply**.
7. In the Fields pane, rename the table to `Sales`.

**Do not import both the wide clean file and this long file into the same additive visual.** That would duplicate the same quantities.

## 3. Understand the table in simple English

Each row says: “On this date, for this ATC category, this quantity was recorded.”

Example shape—not a newly invented record:

| Sale_Date | ATC_Category | Quantity |
|---|---|---:|
| A date from the CSV | N02BE | The CSV value for that date/category |

The long shape makes a category slicer easy: one `ATC_Category` column can filter every visual.

## 4. Create the Date table and measures

1. Open `PowerBI_Measures.dax` in a text editor.
2. Select **Modeling → New table** and paste only the `Date = ...` block.
3. Add the Date calculated columns one at a time.
4. Open **Model view** and create this relationship:

   `Date[Date]` **1 → *** `Sales[Sale_Date]`

5. Keep the filter direction as single, from Date to Sales, unless you have a reason to change it.
6. Right-click the Date table and choose **Mark as date table → Date**.
7. Sort `Year Month` by `Year Month Sort`, and `Weekday` by `Weekday Number`.
8. Create each measure from the DAX file by selecting **New measure**.

### Measures in simple English

- **Total Quantity:** adds Quantity in the current filter selection.
- **Average Daily Quantity:** total quantity divided by the number of observed dates.
- **Peak Daily Quantity:** finds the largest daily total in the selection.
- **Previous Month Quantity:** repeats the measure for the previous calendar month.
- **Category Share %:** compares a category with all categories for the same selected dates.
- **Zero Quantity Days:** counts dates where selected quantity is zero.

## 5. Build the dashboard

Use a consistent title: **Pharmaceutical Sales Dashboard | Quantity, not revenue**.

### A. KPI cards

Add three Card visuals:

1. `Total Quantity`
2. `Average Daily Quantity`
3. `Peak Daily Quantity`

Format quantities to two decimal places. Add a small text box showing the actual source period: **02 Jan 2014–08 Oct 2019**.

### B. Monthly trend

1. Insert a **Line chart**.
2. Axis: `Date[Month Start]`.
3. Values: `Total Quantity`.
4. Use a continuous date axis, not a categorical text month.
5. Add a **visual-level filter**: `Date[Is Complete Month] is True`.
6. Title: `Monthly Quantity | Complete Calendar Months`.

This keeps partial January 2014 and October 2019 out of the monthly ranking/trend without deleting their daily records.

### C. Medicine category chart

1. Insert a **Clustered bar chart**.
2. Axis: `Sales[ATC_Category]`.
3. Values: `Total Quantity`.
4. Sort descending by Total Quantity.
5. Add `Category_Description` to the tooltip.
6. Title: `Quantity by ATC Category`.

### D. Weekday pattern

1. Insert a **Clustered column chart**.
2. Axis: `Date[Weekday]`.
3. Values: `Average Daily Quantity`.
4. Sort by `Weekday Number`.
5. Title: `Average Quantity per Observed Day by Weekday`.

### E. Optional category/month matrix

Create a Matrix with:

- Rows: `ATC_Category`
- Columns: `Year Month`
- Values: `Total Quantity`

This is useful for checking whether a category drives a monthly peak.

## 6. Add filters and interactivity

Add slicers for:

- `Date[Year]`
- `Sales[ATC_Category]`
- `Date[Weekday]` (optional)

Then select **View → Sync slicers** only if you create more pages and need synchronized selections. Use **Format → Edit interactions** to check that each slicer filters the intended visuals.

Suggested design:

- Navy title bar, teal category bars, orange highlight for important peaks.
- Keep all KPI values visible without scrolling.
- Use clear labels instead of crowded decorations.
- Add a note: “Historical quantity from one pharmacy; no revenue or current-stock fields.”

## 7. Validate before saving

Compare Power BI with the supplied calculated results using an unfiltered page:

| Check | Expected value |
|---|---:|
| Total Quantity | **127,595.50** |
| Average Daily Quantity over all dates | **60.59** |
| N02BE Total Quantity | **63,005.40** |
| N02BE Category Share | **49.38%** |
| Complete months in monthly filter | **68** |

If Total Quantity is eight times too large, check whether you imported duplicate tables or used an incorrect relationship. If Average Daily Quantity is wrong, check that its denominator is the number of dates, not the number of long-table rows.

## 8. Save and capture evidence

1. Save the report as exactly `Pharma_Sales_Dashboard.pbix`.
2. Reopen it once to confirm that it works.
3. Capture a real screenshot of the complete report page.
4. Capture a second screenshot showing a Year or Category filter changed.
5. Name them clearly, for example:
   - `PowerBI_Dashboard_All.png`
   - `PowerBI_Dashboard_Filtered.png`
6. Put them in `Major-Project/Screenshots/` and insert the best one into the final report.

Do not submit a generated chart preview as a Power BI screenshot.
