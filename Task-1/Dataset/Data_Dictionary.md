# Data Dictionary

## Dataset identity

- **Dataset:** Pharma sales data, Milan Zdravković, Kaggle.
- **Source:** https://www.kaggle.com/datasets/milanzdravkovic/pharma-sales-data
- **Scope stated by the source:** one pharmacy, selected drugs grouped into eight ATC categories, historical period 2014–2019; the last year is incomplete.
- **Measure meaning:** recorded sales quantity/volume. There is no price or revenue column.

## Supplied files

| File | Rows in supplied copy | Grain | Use in this project |
|---|---:|---|---|
| `saleshourly.csv` | 50,532 | One row per hour | Hour-of-day demand summary and cross-check |
| `salesdaily.csv` | 2,106 | One row per day | **Canonical source for main analysis** |
| `salesweekly.csv` | 302 | One row per week ending Sunday | Reconciliation check |
| `salesmonthly.csv` | 70 | One row per month | Reconciliation only; monthly analysis is rebuilt from daily data |

## ATC category descriptions

These descriptions follow the dataset source. The source labels the N02BE group as N02BE/B, while the CSV column is `N02BE`.

| Code | Simple category description |
|---|---|
| M01AB | Anti-inflammatory and antirheumatic products, non-steroids — acetic acid derivatives and related substances |
| M01AE | Anti-inflammatory and antirheumatic products, non-steroids — propionic acid derivatives |
| N02BA | Other analgesics and antipyretics — salicylic acid and derivatives |
| N02BE | Other analgesics and antipyretics — pyrazolones and anilides |
| N05B | Psycholeptics — anxiolytic drugs |
| N05C | Psycholeptics — hypnotics and sedatives |
| R03 | Drugs for obstructive airway diseases |
| R06 | Antihistamines for systemic use |

ATC means **Anatomical Therapeutic Chemical** classification. These are groups, not individual brand names.

## Original daily columns

| Original column | Meaning / treatment |
|---|---|
| `datum` | Source date text in month/day/year format; converted to `Sale_Date` |
| `M01AB` … `R06` | Decimal sales quantity for each ATC category; retained without integer rounding |
| `Year` | Calendar year; validated against parsed date |
| `Month` | Calendar month number; validated against parsed date |
| `Hour` | Not a valid daily time-of-day field in this file: only 190, 248 and 276 occur; excluded from clean analytical data |
| `Weekday Name` | Weekday text; validated against parsed date and regenerated in clean data |

## Clean daily fields

| Field | Type | Meaning |
|---|---|---|
| `Sale_Date` | Date | One observed calendar date |
| `M01AB` … `R06` | Decimal | Source quantity by category |
| `Total_Quantity` | Decimal | Sum of all eight categories for that date |
| `Year` | Integer | Year extracted from Sale_Date |
| `Month_Number` | Integer | 1 = January, 12 = December |
| `Month_Start` | Date | First day of the sale month; used for monthly aggregation |
| `Month_Name` | Text | Calendar month name |
| `Weekday_Number` | Integer | 1 = Monday, 7 = Sunday |
| `Weekday_Name` | Text | Day of week |
| `Is_Complete_Month` | Boolean | TRUE when rows cover every calendar date of that month |

## Long/BI fields

`pharma_sales_long.csv` contains the calendar fields above plus:

| Field | Meaning |
|---|---|
| `ATC_Category` | One category code per row |
| `Category_Description` | Plain-English ATC description |
| `Quantity` | Quantity for that date and category |

There are 16,848 rows: 2,106 dates × 8 categories. A `SUM(Quantity)` across the whole file equals the sum of `Total_Quantity` in the clean daily file.

## Important metric definitions

- **Total quantity:** sum of Quantity, or sum of daily Total_Quantity. Never add both tables together.
- **Average total daily quantity:** sum of daily Total_Quantity divided by observed dates.
- **Average category daily quantity:** sum of Quantity for one category divided by observed dates.
- **Month-over-month growth:** `(current complete month − previous complete month) / previous complete month`.
- **Zero-quantity day:** a date/category row where Quantity is zero; not necessarily a day with no patient demand.
- **Complete month:** all calendar dates are present, not merely a month with a monthly total.
