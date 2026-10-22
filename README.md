# internsAparnareddy_INBT026297_iNeuBytes

## iNeuBytes Data Analytics Internship — P1

**Student:** Aparna Reddy  
**Registration No.:** INBT026297  
**Project:** Pharmaceutical Sales Data Analytics  
**Google Docs combined report:** https://docs.google.com/document/d/1amt9L8CzQ2ba_9tr_BHdGPSeUS9CUs2lT55A4ixpaKQ/edit?usp=sharing  
**GitHub repository:** https://github.com/appureddy1102-cloud/internsAparnareddy_INBT026297_iNeuBytes

> **Completion status:** This repository contains real data, code, calculations, an Excel workbook, BI build assets and reports. MySQL execution screenshots, native Excel PivotTables if required, genuine Power BI/Tableau project files and application screenshots remain manual steps. Do not describe those pending items as completed in the P1 portal.

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
- **Microsoft Excel:** formulas, summaries, PivotTable practice, charts and dashboard selectors.
- **Power BI Desktop or Tableau:** long-format data model, calculated measures and interactive dashboard.
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

## 7. Execution instructions

### Task 1 — SQL

1. Open `Task-1/pharma_sales_analysis.sql` in MySQL 8.0.
2. Change the `LOAD DATA LOCAL INFILE` path to your local `Task-1/Dataset/salesdaily.csv` path.
3. Run sections in order and inspect every quality-check result.
4. Compare results with `Task-1/query_results/` and `Task-1/Business_Insights.md`.
5. Capture real MySQL query/result screenshots before submission.

### Task 2 — Excel

1. Open `Task-2/Pharma_Sales_Analysis.xlsx` in desktop Excel.
2. Read `START_HERE`, recalculate formulas and test the Year/Category dashboard selectors.
3. With both selectors at All, confirm Total Quantity = **127,595.50**, Average Daily = **60.59**, and Days = **2,106**.
4. Follow `Excel_Step_by_Step.md` to add native PivotTables if required.
5. Save and capture actual Excel dashboard/PivotTable screenshots.

### Task 3 and Major Project — BI

1. Open the guides in `Major-Project/Task-3-PowerBI-Tableau/`.
2. Import `pharma_sales_long.csv` into Power BI or Tableau.
3. Apply the supplied data types, Date model, DAX measures or Tableau calculated fields.
4. Build KPI cards, complete-month trend, category chart, weekday chart and filters.
5. Validate the same headline totals, save a genuine `.pbix` or `.twbx`, reopen it and capture real screenshots.

## 8. Remaining manual steps before P1 submission

- [ ] Run the SQL script in MySQL and capture application evidence.
- [ ] Validate Excel formulas/charts and add native PivotTables if required.
- [ ] Build and save the actual Power BI or Tableau dashboard file.
- [ ] Add genuine application screenshots to this repository and the single Google Doc.
- [ ] Replace/update any remaining pending-status text after the work is actually complete.
- [ ] Test the GitHub and Google Docs links in an incognito window.
- [ ] Submit only the two review links through the official P1 portal.

## 9. Submission rules from the supplied instructions

- Use this **one public repository** for all work; do not create separate task repositories.
- Commit actual files into the correct folders. **Do not upload a ZIP file as the GitHub submission.**
- Use the single linked Google Doc for explanations, screenshots, results and learnings from all tasks and the Major Project.
- Keep both review links publicly accessible, but do not share them on social media.
- Submit carefully: each submission or resubmission uses a chance.
- Monitor email, including spam/promotions, for the mandatory P1 verification meeting.
- Follow the current official portal and mentor instructions if they differ from this general guide.
