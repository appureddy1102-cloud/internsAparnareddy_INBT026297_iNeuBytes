# Application Evidence Register

**Student:** Aparna Reddy
**Registration No.:** INBT026297
**Evidence received:** 23 October 2026

This register distinguishes student-supplied application evidence from independent validation. The screenshots below are genuine application captures supplied by the student; they are not generated analytical charts.

## Task 1 — MySQL 8.0

The older path/privilege-dependent SQL was replaced with the final self-contained corrected `Task-1/pharma_sales_analysis.sql`. It embeds all 2,106 daily records, uses the currently selected schema, avoids the reserved `rows` alias and includes the `ONLY_FULL_GROUP_BY`-compatible annual query.

| Evidence | What it shows |
|---|---|
| `Task-1-SQL/SQL_01_Data_Quality.png` | Row count, zero missing values, empty validation results and daily Hour helper inspection |
| `Task-1-SQL/SQL_02_MySQL_Execution_And_Row_Count.png` | Online MySQL 8.0 interface, project SQL and successful 29-query execution message |
| `Task-1-SQL/SQL_03_Overall_Category_Monthly_Results.png` | Total 127,595.50, daily average 60.59, peak 198.95, category totals and daily-derived monthly results |
| `Task-1-SQL/SQL_04_Category_Month_And_MoM_Results.png` | Long category/month output and month-over-month results |
| `Task-1-SQL/SQL_05_Annual_Weekday_Peak_Results.png` | Annual coverage, weekday results, peak days and category variability |

The screenshots are evidence of the student's SQLTest MySQL 8.0 execution. The assistant did not independently rerun the final script in a local MySQL server.

## Task 2 — Excel

| Evidence | What it shows |
|---|---|
| `Task-2-Excel/Excel_01_Start_Here.png` | Workbook guide, source scope and headline metrics |
| `Task-2-Excel/Excel_02_Dashboard_Overview.png` | Excel dashboard, selectors, KPI cards and monthly/weekday visuals |
| `Task-2-Excel/Excel_03_Dashboard_Charts.png` | Lower dashboard charts as supplied |
| `Task-2-Excel/Excel_04_Formula_Examples.png` | Practical SUM, AVERAGE, COUNT, COUNTIF and SUMIFS examples |

Visible validation includes Total Quantity 127,595.50, Average Daily Quantity 60.59, Days 2,106 and N02BE share 49.38%.

Remaining checks: the supplied lower-dashboard capture shows the category-comparison chart area blank, and a Protected View banner is visible. Final desktop recalculation, category-chart verification and native PivotTables if required are not independently confirmed.

## Task 3 — Power BI

The genuine project file is `Major-Project/Task-3-PowerBI-Tableau/Pharma_Sales_Dashboard.pbix`.

- Retrieved from the student's connected Google Drive; the uploaded double extension was corrected to one `.pbix` extension in the repository.
- File size: 159,853 bytes.
- SHA-256: `8ad4433546399c7b89a1265c49e327cbfbb0c58f3da582ca64b1a2cd2a8bc74d`.
- ZIP integrity/CRC check passed.
- The package contains `DataModel`, report definitions and four pages: Pharmaceutical Sales Analysis, Sales Analysis, Pharmaceutical Sales Details and Summary.
- Structural validation is not a substitute for reopening and testing the report in Power BI Desktop.

| Evidence | What it shows |
|---|---|
| `Task-3-PowerBI/PowerBI_01_Dashboard_Summary.png` | Summary page with Total Quantity 127.60K, Average Daily Quantity 60.59, Peak Daily Quantity 198.95, category chart and Year slicer |
| `Task-3-PowerBI/PowerBI_02_Sales_Analysis.png` | Category, weekday and trend analysis page |
| `Task-3-PowerBI/PowerBI_03_Filtered_Development_View.png` | Earlier development capture with N02BA selected; retained as filtered development evidence, not represented as the final report layout |

Final PBIX reopen/filter testing and a filtered screenshot of the final layout are recommended. Some supplied trend captures display Year rather than a continuous monthly axis.

## Task 3 — Tableau

The live Tableau Public URL is documented in `Task-3-PowerBI-Tableau/Tableau_Dashboard_Link.md`.

| Evidence | What it shows |
|---|---|
| `Tableau_Pharma_Sales_Dashboard.png` | Tableau Public's generated static preview |
| `Task-3-Tableau/Tableau_01_Dashboard_Desktop.png` | Tableau Desktop/Public dashboard with KPI, trend, weekday and category sheets |
| `Task-3-Tableau/Tableau_02_Category_Sales.png` | Category Sales worksheet and quantity total |
| `Task-3-Tableau/Tableau_03_Weekday_Demand.png` | Weekday Demand worksheet and Sunday tooltip |

The Tableau preview/dashboard capture still displays `Year of Month Start`; use continuous Month if a monthly trend is required. A local `.twbx` and independent interactive-filter validation are not claimed.

## Evidence selection

Clear, relevant captures were selected. Lower-resolution duplicates, earlier draft layouts and a browser screenshot of the GitHub repository are not presented as final dashboard evidence. No screenshot has been edited to alter results or hide application content.
