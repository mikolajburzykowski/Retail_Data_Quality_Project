-- ==========================================================
-- Data Quality Analysis Project
-- Database: data_quality.db
-- Author: Mikolaj Burzykowski
-- Date: 05-12-2025
-- This script contains SQL queries used to assess quality issues
-- in property address datasets imported from CSV files.
-- ==========================================================

/**********************************************************************
 HOW TO RUN THIS SCRIPT (Execution Instructions)

 1. Open DB Browser for SQLite (or DBeaver / VS Code extension)
 2. Go to File → Open Database
 3. Load the database file:
        sql/data_quality.db
 4. Open this script in any SQL editor
 5. Run each section step-by-step in the following order:

    A. Table creation (creates structure)
    B. Data imports (already done manually in DB Browser)
    C. Data analysis queries
    D. Consistency checks between tables
    E. Summary report

 6. After executing CREATE TABLE statements,
    refresh "Browse Data" tab in DB Browser to see results.

***********************************************************************/


-- ==========================================================
-- SECTION 1: Basic dataset metrics
-- ==========================================================

-- Counts total number of records in each source table
SELECT 'CleanedData' AS TableName, COUNT(*) AS TotalRecords
FROM CleanedData;

SELECT 'checks' AS TableName, COUNT(*) AS TotalRecords
FROM checks;


-- ==========================================================
-- SECTION 2: Global data quality status
-- ==========================================================

-- Returns total number of valid vs invalid entries
SELECT AnyError, COUNT(*) AS CountRows
FROM CleanedData
GROUP BY AnyError;

-- Calculates error percentage across the dataset
SELECT
    SUM(CASE WHEN AnyError = 'ERROR' THEN 1 ELSE 0 END) AS ErrorCount,
    COUNT(*) AS TotalRows,
    ROUND(100.0 * SUM(CASE WHEN AnyError = 'ERROR' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ErrorRatePercent
FROM CleanedData;


-- ==========================================================
-- SECTION 3: Breakdown of errors
-- ==========================================================

-- Shows which error types are most frequent
SELECT ErrorType, COUNT(*) AS Total
FROM checks
GROUP BY ErrorType
ORDER BY Total DESC;

-- Identifies countries where issues occur most often
SELECT Country, COUNT(*) AS ErrorCount
FROM CleanedData
WHERE AnyError = 'ERROR'
GROUP BY Country
ORDER BY ErrorCount DESC;

-- Identifies systems contributing most incorrect data
SELECT SourceSystem, COUNT(*) AS ErrorCount
FROM CleanedData
WHERE AnyError = 'ERROR'
GROUP BY SourceSystem
ORDER BY ErrorCount DESC;


-- Calculates monthly trend of error occurrence
SELECT SUBSTR(UpdatedDate, 4, 7) AS MonthYear, COUNT(*) AS ErrorCount
FROM CleanedData
WHERE AnyError = 'ERROR'
GROUP BY MonthYear
ORDER BY MonthYear;


-- ==========================================================
-- SECTION 4: Final report table
-- ==========================================================

DROP TABLE IF EXISTS ErrorReport;

-- Creates a final consolidated dataset containing only incorrect rows
CREATE TABLE ErrorReport AS
SELECT
c.PropertyID,
c.Country,
c.SourceSystem,
ck.ErrorType,
c.UpdatedDate
FROM CleanedData c
JOIN checks ck ON c.PropertyID = ck.PropertyID
WHERE c.AnyError = 'ERROR';


-- ==========================================================
-- SECTION 5: Data consistency checks between tables
-- ==========================================================

DROP TABLE IF EXISTS MissingInChecks;
CREATE TABLE MissingInChecks AS
SELECT c.*
FROM CleanedData c
LEFT JOIN checks ck ON c.PropertyID = ck.PropertyID
WHERE ck.PropertyID IS NULL;

DROP TABLE IF EXISTS MissingInCleanedData;
CREATE TABLE MissingInCleanedData AS
SELECT ck.*
FROM Checks ck
LEFT JOIN CleanedData c ON c.PropertyID = ck.PropertyID
WHERE c.PropertyID IS NULL;


/**********************************************************************
 FINAL SUMMARY RESULTS
 Overall status after validation
***********************************************************************/

SELECT 
    (SELECT COUNT(*) FROM CleanedData)       AS TotalRowsInCleanedData,
    (SELECT COUNT(*) FROM checks)             AS TotalRowsInChecks,
    (SELECT COUNT(*) FROM MissingInChecks)    AS MissingOnlyInChecks,
    (SELECT COUNT(*) FROM MissingInCleanedData) AS MissingOnlyInCleanedData,
    (SELECT COUNT(*) FROM ErrorReport)        AS RowsWithValidationErrors;