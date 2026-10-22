# Package Validation Summary

Validated against the supplied workspace files on 22 October 2026.

## Data reconciliation checks

- Clean daily rows: **2,106**.
- Long BI rows: **16,848** = 2,106 dates × 8 categories.
- Derived monthly rows: **70**.
- Complete calendar months: **68**.
- Partial months: **January 2014 (30 of 31 days)** and **October 2019 (8 of 31 days)**.
- Clean daily Total_Quantity sum: **127,595.50368748402**.
- Long Quantity sum: **127,595.50368748399**.
- Derived monthly Total_Quantity sum: **127,595.503687** after six-decimal CSV output.
- Clean-versus-long absolute difference: approximately **0.000000000029**, caused only by floating-point representation.
- Category shares total approximately **100%** after six-decimal CSV rounding.
- Supplied monthly rows matching daily aggregation within 0.01 across all categories: **37 of 70**.

## File checks

- `Pharma_Sales_Analysis.xlsx` opens programmatically with formula and cached-value views.
- Active Excel sheet: **Dashboard**.
- Dashboard charts: **3**.
- Dashboard data validations/drop-downs: **2**.
- Clean and long Excel tables: **tblCleanDaily** and **tblLongSales**.
- Cached unfiltered Dashboard Total Quantity: **127,595.50368748402**.
- `Final_Project_Report.docx` opens programmatically and contains headings, result tables and five generated analytical images.
- No `.pbix`, `.twbx`, application screenshot, GitHub repository URL, Google Docs URL or portal submission has been fabricated.

## Validation boundaries

- The SQL was written for MySQL 8.0 but was **not executed in a MySQL server in this environment**.
- The workbook was not opened/recalculated in desktop Microsoft Excel here; the student must visually inspect and test it there.
- Native Excel PivotTable objects, Power BI and Tableau files require their respective applications.
- Generated PNGs were visually checked as analytical charts, not represented as application screenshots.
