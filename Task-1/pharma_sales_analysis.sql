/*
===============================================================================
PHARMACEUTICAL SALES DATA ANALYTICS
iNeuBytes VIIP | Course ID: DAINB10926
Task 1: MySQL analysis

Purpose:
  Analyze recorded sales QUANTITY by date and ATC medicine category.
  This dataset has no price column, so these queries do not calculate revenue.

Canonical source:
  salesdaily.csv (2,106 daily records expected from the supplied file)
  Daily data is used because hourly totals reconcile with it, while the supplied
  monthly CSV does not consistently reconcile with daily aggregation.

Before running:
  1. Use MySQL 8.0 or later (window functions are used).
  2. Enable LOCAL INFILE in your MySQL client/server if required.
  3. Change the LOAD DATA path below to the exact path on YOUR computer.
  4. The attached CSV uses CRLF line endings. If your copy uses LF only, change
     LINES TERMINATED BY '\r\n' to LINES TERMINATED BY '\n'.
  5. Run sections in order. Do not run the blind DELETE/DROP statements on any
     database containing unrelated work.

Calculated cross-checks from the supplied CSV (not claimed MySQL screenshots):
  - Total quantity, rounded to 2 decimals: 127595.50
  - N02BE total, rounded to 2 decimals: 63005.40
  - Complete calendar months: 68
  Small differences below 0.01 can occur if you round source values differently.
===============================================================================
*/

-- -----------------------------------------------------------------------------
-- SECTION 1: CREATE AN ISOLATED DATABASE AND RAW STAGING TABLE
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS ineubytes_pharma
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ineubytes_pharma;

DROP VIEW IF EXISTS pharma_monthly_derived;
DROP VIEW IF EXISTS pharma_sales_long;
DROP TABLE IF EXISTS pharma_sales_daily;
DROP TABLE IF EXISTS pharma_sales_staging;

-- VARCHAR staging lets us inspect invalid values before converting data types.
CREATE TABLE pharma_sales_staging (
  datum_raw          VARCHAR(30),
  m01ab_raw          VARCHAR(50),
  m01ae_raw          VARCHAR(50),
  n02ba_raw          VARCHAR(50),
  n02be_raw          VARCHAR(50),
  n05b_raw           VARCHAR(50),
  n05c_raw           VARCHAR(50),
  r03_raw            VARCHAR(50),
  r06_raw            VARCHAR(50),
  year_raw           VARCHAR(10),
  month_raw          VARCHAR(10),
  hour_raw           VARCHAR(10),
  weekday_name_raw   VARCHAR(20)
);

-- CHANGE THIS PATH. Relative location in this repository:
-- Task-1/Dataset/salesdaily.csv
LOAD DATA LOCAL INFILE '/absolute/path/to/internsAparnareddy_INBT026297_iNeuBytes/Task-1/Dataset/salesdaily.csv'
INTO TABLE pharma_sales_staging
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Expected for the supplied file: 2,106 rows.
SELECT COUNT(*) AS raw_rows_loaded
FROM pharma_sales_staging;


-- -----------------------------------------------------------------------------
-- SECTION 2: DATA-QUALITY CHECKS BEFORE TYPE CONVERSION
-- -----------------------------------------------------------------------------

-- Q2.1 Missing or blank values in required raw fields.
SELECT
  SUM(datum_raw IS NULL OR TRIM(datum_raw) = '') AS missing_date,
  SUM(m01ab_raw IS NULL OR TRIM(m01ab_raw) = '') AS missing_m01ab,
  SUM(m01ae_raw IS NULL OR TRIM(m01ae_raw) = '') AS missing_m01ae,
  SUM(n02ba_raw IS NULL OR TRIM(n02ba_raw) = '') AS missing_n02ba,
  SUM(n02be_raw IS NULL OR TRIM(n02be_raw) = '') AS missing_n02be,
  SUM(n05b_raw  IS NULL OR TRIM(n05b_raw)  = '') AS missing_n05b,
  SUM(n05c_raw  IS NULL OR TRIM(n05c_raw)  = '') AS missing_n05c,
  SUM(r03_raw   IS NULL OR TRIM(r03_raw)   = '') AS missing_r03,
  SUM(r06_raw   IS NULL OR TRIM(r06_raw)   = '') AS missing_r06,
  SUM(year_raw  IS NULL OR TRIM(year_raw)  = '') AS missing_year,
  SUM(month_raw IS NULL OR TRIM(month_raw) = '') AS missing_month,
  SUM(weekday_name_raw IS NULL OR TRIM(weekday_name_raw) = '') AS missing_weekday
FROM pharma_sales_staging;

-- Q2.2 Duplicate dates. There should be at most one daily row per date.
SELECT datum_raw, COUNT(*) AS duplicate_count
FROM pharma_sales_staging
GROUP BY datum_raw
HAVING COUNT(*) > 1;

-- Q2.3 Invalid or unparseable dates. Expected format examples: 1/2/2014, 10/8/2019.
SELECT datum_raw
FROM pharma_sales_staging
WHERE STR_TO_DATE(TRIM(datum_raw), '%m/%d/%Y') IS NULL;

-- Q2.4 Non-numeric category values. The regex accepts integers and decimals.
SELECT *
FROM pharma_sales_staging
WHERE TRIM(m01ab_raw) NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(m01ae_raw) NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(n02ba_raw) NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(n02be_raw) NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(n05b_raw)  NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(n05c_raw)  NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(r03_raw)   NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$'
   OR TRIM(r06_raw)   NOT REGEXP '^[+-]?[0-9]+([.][0-9]+)?$';

-- Q2.5 Check that supplied Year, Month, and Weekday agree with the parsed date.
SELECT datum_raw, year_raw, month_raw, weekday_name_raw
FROM pharma_sales_staging
WHERE CAST(year_raw AS UNSIGNED) <>
        YEAR(STR_TO_DATE(TRIM(datum_raw), '%m/%d/%Y'))
   OR CAST(month_raw AS UNSIGNED) <>
        MONTH(STR_TO_DATE(TRIM(datum_raw), '%m/%d/%Y'))
   OR TRIM(weekday_name_raw) <>
        DAYNAME(STR_TO_DATE(TRIM(datum_raw), '%m/%d/%Y'));

-- Q2.6 Inspect the daily Hour helper column before deciding whether to use it.
-- In the supplied daily file it contains only 190, 248, and 276. It is NOT a
-- time-of-day field, so it is not copied to the clean analytical table.
SELECT hour_raw, COUNT(*) AS rows
FROM pharma_sales_staging
GROUP BY hour_raw
ORDER BY hour_raw;


-- -----------------------------------------------------------------------------
-- SECTION 3: CREATE THE CLEAN DAILY TABLE
-- No imputation or integer rounding is applied. The source already states that
-- preprocessing included missing-data treatment and outlier treatment.
-- -----------------------------------------------------------------------------

CREATE TABLE pharma_sales_daily (
  sale_date       DATE NOT NULL,
  m01ab           DECIMAL(18,9) NOT NULL,
  m01ae           DECIMAL(18,9) NOT NULL,
  n02ba           DECIMAL(18,9) NOT NULL,
  n02be           DECIMAL(18,9) NOT NULL,
  n05b            DECIMAL(18,9) NOT NULL,
  n05c            DECIMAL(18,9) NOT NULL,
  r03             DECIMAL(18,9) NOT NULL,
  r06             DECIMAL(18,9) NOT NULL,
  total_quantity  DECIMAL(20,9)
    GENERATED ALWAYS AS
      (m01ab + m01ae + n02ba + n02be + n05b + n05c + r03 + r06) STORED,
  PRIMARY KEY (sale_date)
);

INSERT INTO pharma_sales_daily (
  sale_date, m01ab, m01ae, n02ba, n02be, n05b, n05c, r03, r06
)
SELECT
  STR_TO_DATE(TRIM(datum_raw), '%m/%d/%Y'),
  CAST(TRIM(m01ab_raw) AS DECIMAL(18,9)),
  CAST(TRIM(m01ae_raw) AS DECIMAL(18,9)),
  CAST(TRIM(n02ba_raw) AS DECIMAL(18,9)),
  CAST(TRIM(n02be_raw) AS DECIMAL(18,9)),
  CAST(TRIM(n05b_raw)  AS DECIMAL(18,9)),
  CAST(TRIM(n05c_raw)  AS DECIMAL(18,9)),
  CAST(TRIM(r03_raw)   AS DECIMAL(18,9)),
  CAST(TRIM(r06_raw)   AS DECIMAL(18,9))
FROM pharma_sales_staging;

-- Q3.1 Row count, unique dates, range, and continuity.
-- If unique daily dates cover every date from MIN to MAX, there are no date gaps.
SELECT
  COUNT(*) AS rows_loaded,
  COUNT(DISTINCT sale_date) AS unique_dates,
  MIN(sale_date) AS first_date,
  MAX(sale_date) AS last_date,
  DATEDIFF(MAX(sale_date), MIN(sale_date)) + 1 AS expected_daily_dates,
  CASE
    WHEN COUNT(*) = COUNT(DISTINCT sale_date)
     AND COUNT(*) = DATEDIFF(MAX(sale_date), MIN(sale_date)) + 1
    THEN 'PASS: one row per date and no date gaps'
    ELSE 'INVESTIGATE: duplicates or date gaps'
  END AS continuity_check
FROM pharma_sales_daily;

-- Q3.2 Negative values in the clean table.
SELECT COUNT(*) AS rows_with_negative_quantity
FROM pharma_sales_daily
WHERE m01ab < 0 OR m01ae < 0 OR n02ba < 0 OR n02be < 0
   OR n05b < 0 OR n05c < 0 OR r03 < 0 OR r06 < 0;

-- Q3.3 Exact duplicate category/date rows. The primary key already prevents
-- duplicate dates; this query documents the full-row duplicate check.
SELECT sale_date, m01ab, m01ae, n02ba, n02be, n05b, n05c, r03, r06,
       COUNT(*) AS duplicate_count
FROM pharma_sales_daily
GROUP BY sale_date, m01ab, m01ae, n02ba, n02be, n05b, n05c, r03, r06
HAVING COUNT(*) > 1;


-- -----------------------------------------------------------------------------
-- SECTION 4: ANALYTICAL VIEWS
-- Long view: one row per date and category. This prevents repeated category code
-- in later queries and is also the preferred shape for BI tools.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW pharma_sales_long AS
SELECT sale_date, 'M01AB' AS atc_category, m01ab AS quantity FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'M01AE', m01ae FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'N02BA', n02ba FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'N02BE', n02be FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'N05B',  n05b  FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'N05C',  n05c  FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'R03',   r03   FROM pharma_sales_daily
UNION ALL SELECT sale_date, 'R06',   r06   FROM pharma_sales_daily;

-- Monthly view derived from daily records, with a completeness flag.
CREATE OR REPLACE VIEW pharma_monthly_derived AS
SELECT
  month_start,
  days_observed,
  DAY(LAST_DAY(month_start)) AS expected_days,
  CASE
    WHEN days_observed = DAY(LAST_DAY(month_start)) THEN 1
    ELSE 0
  END AS is_complete_month,
  total_quantity,
  average_daily_quantity
FROM (
  SELECT
    DATE_SUB(DATE(sale_date), INTERVAL DAYOFMONTH(sale_date) - 1 DAY) AS month_start,
    COUNT(*) AS days_observed,
    SUM(total_quantity) AS total_quantity,
    AVG(total_quantity) AS average_daily_quantity
  FROM pharma_sales_daily
  GROUP BY DATE_SUB(DATE(sale_date), INTERVAL DAYOFMONTH(sale_date) - 1 DAY)
) AS monthly_base;

-- Check the two partial endpoint months and the 68 complete months.
SELECT is_complete_month, COUNT(*) AS number_of_months
FROM pharma_monthly_derived
GROUP BY is_complete_month;


-- -----------------------------------------------------------------------------
-- SECTION 5: BUSINESS QUERIES
-- -----------------------------------------------------------------------------

-- Q1. Overall KPI: total, daily average, and highest daily quantity.
SELECT
  MIN(sale_date) AS start_date,
  MAX(sale_date) AS end_date,
  COUNT(*) AS days_observed,
  ROUND(SUM(total_quantity), 2) AS total_sales_quantity,
  ROUND(AVG(total_quantity), 2) AS average_daily_quantity,
  ROUND(MAX(total_quantity), 2) AS peak_daily_quantity
FROM pharma_sales_daily;

-- Q2. Ten highest-quantity days.
SELECT sale_date, ROUND(total_quantity, 2) AS total_sales_quantity
FROM pharma_sales_daily
ORDER BY total_quantity DESC
LIMIT 10;

-- Q3. Sales by medicine category, contribution, average, variability, zero days.
SELECT
  atc_category,
  ROUND(SUM(quantity), 2) AS total_sales_quantity,
  ROUND(100 * SUM(quantity) / SUM(SUM(quantity)) OVER (), 2)
    AS share_of_total_percent,
  ROUND(AVG(quantity), 2) AS average_daily_quantity,
  ROUND(STDDEV_SAMP(quantity), 2) AS stddev_daily_quantity,
  SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) AS zero_quantity_days
FROM pharma_sales_long
GROUP BY atc_category
ORDER BY total_sales_quantity DESC;

-- Q4. Monthly trend derived from daily data. Partial months remain labelled.
SELECT
  month_start,
  days_observed,
  expected_days,
  is_complete_month,
  ROUND(total_quantity, 2) AS monthly_sales_quantity,
  ROUND(average_daily_quantity, 2) AS average_daily_quantity
FROM pharma_monthly_derived
ORDER BY month_start;

-- Q5. Ten highest COMPLETE calendar months.
-- This avoids ranking partial January 2014 or partial October 2019 as low demand.
SELECT
  month_start,
  ROUND(total_quantity, 2) AS monthly_sales_quantity,
  ROUND(average_daily_quantity, 2) AS average_daily_quantity
FROM pharma_monthly_derived
WHERE is_complete_month = 1
ORDER BY total_quantity DESC
LIMIT 10;

-- Q6. Monthly sales by ATC category.
SELECT
  DATE_SUB(DATE(sale_date), INTERVAL DAYOFMONTH(sale_date) - 1 DAY) AS month_start,
  atc_category,
  ROUND(SUM(quantity), 2) AS monthly_sales_quantity
FROM pharma_sales_long
GROUP BY
  DATE_SUB(DATE(sale_date), INTERVAL DAYOFMONTH(sale_date) - 1 DAY),
  atc_category
ORDER BY month_start, atc_category;

-- Q7. Month-over-month growth using adjacent COMPLETE months only.
-- February 2014 has no growth value because January 2014 is incomplete.
WITH complete_months AS (
  SELECT *
  FROM pharma_monthly_derived
  WHERE is_complete_month = 1
),
monthly_with_lag AS (
  SELECT
    month_start,
    total_quantity,
    LAG(total_quantity) OVER (ORDER BY month_start) AS previous_month_quantity
  FROM complete_months
)
SELECT
  month_start,
  ROUND(total_quantity, 2) AS monthly_sales_quantity,
  ROUND(previous_month_quantity, 2) AS previous_month_quantity,
  ROUND(
    100 * (total_quantity - previous_month_quantity) / previous_month_quantity,
    2
  ) AS mom_growth_percent
FROM monthly_with_lag
ORDER BY month_start;

-- Q8. Annual totals with an explicit coverage label.
-- Do not interpret 2019 as a full-year decline: it ends on 8 October 2019.
SELECT
  YEAR(sale_date) AS sales_year,
  COUNT(*) AS days_observed,
  MIN(sale_date) AS first_date,
  MAX(sale_date) AS last_date,
  CASE
    WHEN MIN(sale_date) = DATE(CONCAT(YEAR(sale_date), '-01-01'))
     AND MAX(sale_date) = DATE(CONCAT(YEAR(sale_date), '-12-31'))
    THEN 'Complete calendar year'
    ELSE 'Partial calendar year'
  END AS coverage,
  ROUND(SUM(total_quantity), 2) AS annual_sales_quantity,
  ROUND(AVG(total_quantity), 2) AS average_daily_quantity
FROM pharma_sales_daily
GROUP BY YEAR(sale_date)
ORDER BY sales_year;

-- Q9. Weekday demand pattern: compare average per observed day, not only totals.
SELECT
  WEEKDAY(sale_date) + 1 AS weekday_number,
  DAYNAME(sale_date) AS weekday_name,
  COUNT(*) AS days_observed,
  ROUND(SUM(total_quantity), 2) AS total_sales_quantity,
  ROUND(AVG(total_quantity), 2) AS average_daily_quantity
FROM pharma_sales_daily
GROUP BY WEEKDAY(sale_date) + 1, DAYNAME(sale_date)
ORDER BY weekday_number;

-- Q10. Historical inventory-planning baseline by category.
-- These are descriptive statistics, NOT reorder levels or purchase quantities.
SELECT
  atc_category,
  ROUND(AVG(quantity), 3) AS historical_average_per_day,
  ROUND(STDDEV_SAMP(quantity), 3) AS historical_standard_deviation,
  ROUND(MAX(quantity), 3) AS historical_maximum_per_day,
  SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) AS zero_quantity_days
FROM pharma_sales_long
GROUP BY atc_category
ORDER BY historical_average_per_day DESC;

/*
===============================================================================
SCREENSHOT EVIDENCE TO CAPTURE IN MYSQL WORKBENCH
1. Q3.1 continuity check and row count.
2. Q1 overall KPI result.
3. Q3 category result.
4. Q4 monthly result (include the completeness columns).
5. Q5 highest complete months or Q7 month-over-month result.

For each screenshot, show both the SQL statement and the result grid. Use clear
file names such as SQL_Q1_Overall.png. A generated CSV or chart is not a MySQL
application screenshot.

BUSINESS INTERPRETATION REMINDERS
- Quantity is not revenue.
- The data covers one pharmacy and historical years 2014–2019.
- The source says the data was already preprocessed; decimals are retained.
- January 2014 and October 2019 are partial calendar months.
- Inventory decisions also need current stock, lead time, expiry, price, local
  prescribing patterns, and pharmacist review.
===============================================================================
*/
