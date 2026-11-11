-- Pharma Sales & Inventory Intelligence
-- 01 Create And Populate Pharma Clean
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #31 | source line 338
SELECT
    COUNT(*) AS total_records,
    SUM(
        CASE
            WHEN Distributor <> TRIM(Distributor) THEN 1
            ELSE 0
        END
    ) AS distributor_extra_spaces,
    SUM(
        CASE
            WHEN Customer_Name <> TRIM(Customer_Name) THEN 1
            ELSE 0
        END
    ) AS customer_extra_spaces
FROM pharma_clean;
