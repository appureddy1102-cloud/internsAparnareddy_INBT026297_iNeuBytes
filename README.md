# internsAparnareddy_INBT026297_iNeuBytes

## iNeuBytes Data Analytics Internship — P1

**Student:** Aparna Reddy
**Registration No.:** INBT026297
**Project:** Pharmaceutical Sales Data Analytics
**Google Docs combined report:** https://docs.google.com/document/d/1amt9L8CzQ2ba_9tr_BHdGPSeUS9CUs2lT55A4ixpaKQ/edit?usp=sharing
**GitHub repository:** https://github.com/appureddy1102-cloud/internsAparnareddy_INBT026297_iNeuBytes
**Tableau Public dashboard:** https://public.tableau.com/app/profile/tallapureddy.reddy/viz/Pharma_Sales_Dashboard_/PharmaSalesDashboard?publish=yes

> **Current status after programmatic corrections — 23 October 2026:** The repository contains the self-contained corrected SQL, reconciled source/cleaned/result data, a genuine Power BI PBIX, Tableau Public evidence and student-supplied application screenshots. The Excel `Dashboard_Data` monthly/category source ranges and chart definitions have been repaired, and the underlying clean/long totals were preserved. `Final_Project_Report.docx` and the supporting reports have been synchronised. The Google Doc is publicly readable with Anyone-with-link Reader access. Desktop Excel recalculation/selector testing and replacement of pre-repair Excel screenshots remain. Power BI Desktop corrections/reopening, Tableau corrections/republication and final application screenshots also remain. No `.twbx` or native Excel PivotTable objects are claimed, and portal submission is not claimed.

## 1. Project objective

Analyse historical pharmaceutical sales **quantity** by date and ATC medicine category, identify demand patterns, and provide evidence-based recommendations for inventory-planning discussions.

The source has no price, revenue, profit, current-stock, supplier-lead-time or expiry fields. “Sales” therefore means quantity, not money, and no reorder quantity is invented.

## 2. Dataset

**Pharma sales data — Milan Zdravković, Kaggle**
https://www.kaggle.com/datasets/milanzdravkovic/pharma-sales-data

The main analysis uses **2,106 daily records from 2 January 2014 to 8 October 2019**. Raw source files are preserved under `Major-Project/Source_Data/`; the Task 1 daily dataset and data dictionary are under `Task-1/Dataset/`.

See `Major-Project/Documentation/Dataset_Attribution.md` before redistributing the data.

## 3. Repository structure

The root follows the three-folder layout shown in the supplied P1 portal instructions. Task 3 BI assets are placed inside the Major Project so that the root remains `Task-1`, `Task-2`, and `Major-Project`.

```text
internsAparnareddy_INBT026297_iNeuBytes/
├── Task-1/
│   ├── Dataset/
│   ├── query_results/
│   ├── pharma_sales_analysis.sql
│   ├── Business_Insights.md
│   └── Task_1_Project_Report.md
├── Task-2/
│   ├── Pharma_Sales_Analysis.xlsx
│   ├── Excel_Step_by_Step.md
│   └── Task_2_Project_Report.md
├── Major-Project/
│   ├── Task-3-PowerBI-Tableau/
│   ├── Source_Data/
│   ├── Cleaned_Data/
│   ├── Analysis/
│   ├── Charts/
│   ├── Screenshots/
│   ├── Documentation/
│   ├── Final_Project_Report.docx
│   ├── P1_Combined_Report.txt
│   └── Analysis_Methods.md
└── README.md
```

## 4. Tools

- **MySQL 8.0:** staging, data-quality checks, clean tables/views and analytical SQL.
- **Microsoft Excel:** formulas, summaries, charts and dashboard selectors; native PivotTables only if required by the official instructions.
- **Power BI Desktop and Tableau Public:** long-format data model, calculated measures and interactive dashboard evidence.
- **Google Docs:** one combined P1 report.
- **GitHub:** one public, folder-organised review repository.

## 5. Headline calculated findings

| Finding | Result |
|---|---:|
| Total recorded quantity | **127,595.50** |
| Average total quantity per observed day | **60.59** |
| Leading category | **N02BE — 63,005.40 (49.38%)** |
| Top-three category share | **73.09%** |
| Highest complete calendar month | **January 2019 — 2,875.16** |
| Lowest complete calendar month | **July 2017 — 1,251.15** |
| Highest weekday average | **Saturday — 65.67 per day** |
| Complete calendar months | **68** |

These are historical descriptive results, not current 2026 demand, revenue, forecasts or purchasing instructions.

## 6. Data-quality decision

The daily file has continuous dates and reconciles with hourly and weekly files. Only **37 of 70** supplied monthly rows match daily aggregation within 0.01 across all categories. Monthly analysis is therefore derived consistently from daily data.

January 2014 and October 2019 are partial months. They remain labelled and are excluded from complete-month rankings. The year 2019 is not presented as a complete year.

## 7. Execution and final-validation instructions

### Task 1 — SQL

1. Open `Task-1/pharma_sales_analysis.sql` in MySQL 8.0.
2. Select an allowed existing schema. The final script is self-contained and does not require `LOAD DATA`, a CSV path, `CREATE DATABASE` or `USE`.
3. Run the complete script once, then run analysis SELECT statements individually and inspect every quality-check result.
4. Compare results with `Task-1/query_results/` and `Task-1/Business_Insights.md`.
5. Student-supplied MySQL execution/result screenshots are under `Major-Project/Screenshots/Task-1-SQL/`.

### Task 2 — Excel

1. Open the repaired `Task-2/Pharma_Sales_Analysis.xlsx` in desktop Excel.
2. The programmatic repair has already been applied: monthly data is in `Dashboard_Data!A2:C71`, category data in `E2:F9`, weekday data in `H2:J8`, and the chart references/caches were corrected. Do not move category values back into `A2:B9`.
3. Fully recalculate with **Ctrl+Alt+F9**, save, close and reopen. Confirm there are no `#N/A` values in the intended output ranges and no blank chart areas.
4. With both selectors at `All`, confirm Total Quantity = **127,595.50**, Average Daily = **60.59**, Days = **2,106**, and N02BE share = **49.38%**. Test at least one Year and one Category selection and confirm that the intended visuals respond.
5. Follow `Excel_Step_by_Step.md` to add native PivotTables only if required by the official instructions.
6. Replace the pre-repair `Excel_02_Dashboard_Overview.png` and `Excel_03_Dashboard_Charts.png` with genuine post-repair captures. Add `Excel_05_Dashboard_Filtered.png` after a deliberate filter test. Keep the valid Start Here and formula-example captures.

### Task 3 and Major Project — Power BI

1. Open `Major-Project/Task-3-PowerBI-Tableau/Pharma_Sales_Dashboard.pbix` in Power BI Desktop.
2. On every relevant page, use a continuous Month axis for a monthly trend and apply `Is_Complete_Month = True` to that trend. The current report definitions use Year and contain no complete-month report filter.
3. Sort weekday charts Monday–Sunday using `Weekday_Number`.
4. On the main category chart, remove the unnecessary `Weekday_Name` series and `Weekday_Number` tooltip.
5. Clear saved N02BA and N02BE slicer selections before capturing unfiltered evidence. Test a deliberate filter separately.
6. Rename `Total Quality Total Quantity` to `Total Quantity`; correct `Total quality` and `peak daily qunatity`; format the total card to show **127,595.50**, not only **127.60K**. Clean page names by removing leading spaces and trailing full stops.
7. Review the Details page: use a genuine daily axis for a chart titled “Daily,” or rename the visual to match its actual granularity.
8. Save, close, reopen and test all four pages. Recapture the Summary and Sales Analysis pages from the final four-page PBIX and add a filtered screenshot of the final layout.

### Task 3 and Major Project — Tableau

1. Open the published workbook in Tableau and change the trend to continuous `Month_Start` with `Is_Complete_Month = True`.
2. Show Year and ATC Category filters and apply them to all intended worksheets. Remove the unnecessary single-value Quantity range control if it does not serve the analysis.
3. Sort weekdays Monday–Sunday, format the total to two decimals, and resize the dashboard so every KPI and all eight categories are visible without cropping.
4. Test filters, republish and confirm the public link in a private browser window.
5. Replace the dashboard and static-preview evidence. Save/download a genuine `.twbx` only if required by the mentor.

### Final report and evidence documents

1. `Major-Project/Final_Project_Report.docx` was synchronised on 23 October 2026: the current SQL path/method, three-folder structure, PBIX/Tableau/evidence status and public-link status are now stated. Its five charts and 23 tables were preserved.
2. The combined report, Task 2/Task 3 reports, screenshot guide, evidence register and validation summary were updated with the programmatic repair and remaining manual checks.
3. After the final Excel, Power BI and Tableau application work, refresh these status documents again and insert only genuine post-correction screenshots. Keep earlier captures explicitly labelled as pre-repair or development evidence.

## 8. Remaining steps before P1 submission

- [ ] Recalculate, save, close and reopen the repaired Excel workbook; test All/All and filtered selections.
- [ ] Replace the pre-repair Excel dashboard screenshots and add a genuine filtered dashboard capture.
- [ ] Add native PivotTables/PivotCharts and evidence only if required by the official instructions.
- [ ] Correct, reopen and filter-test the PBIX; replace the Summary/Sales Analysis captures and add a filtered final-layout capture.
- [ ] Correct and republish the Tableau dashboard; test Year/ATC filters and replace/add final evidence.
- [ ] Save/download a genuine `.twbx` only if required by the mentor.
- [ ] Update the Google Doc with the final genuine screenshots and refresh the evidence register/checklists after the manual tests.
- [ ] Keep the Google Doc at Anyone-with-link **Reader** access and test GitHub, Google Doc and Tableau Public links in an incognito/private window.
- [ ] Confirm the current official P1 instructions, deadline and remaining submission chances in the portal.
- [ ] Submit only the two review links through the official P1 portal.

## 9. Submission rules from the supplied instructions

- Use this **one public repository** for all work; do not create separate task repositories.
- Commit actual files into the correct folders. **Do not upload a ZIP file as the GitHub submission.**
- Use the single linked Google Doc for explanations, screenshots, results and learnings from all tasks and the Major Project.
- Keep both review links publicly accessible with appropriate read-only review access, but do not share them on social media.
- Submit carefully: each submission or resubmission uses a chance.
- Monitor email, including spam/promotions, for the mandatory P1 verification meeting.
- Follow the current official portal and mentor instructions if they differ from this general guide.
