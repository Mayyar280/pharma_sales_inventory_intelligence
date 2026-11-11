-- Pharma Sales & Inventory Intelligence
-- 00 Schema And Raw Data Exploration
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #1 | source line 1
describe pharma_analytics.pharma_raw;

-- Original query #2 | source line 1
select *
from pharma_analytics.pharma_raw;

-- Original query #27 | source line 290
show create table pharma_analytics.pharma_raw;

-- Original query #28 | source line 292
USE pharma_analytics;

-- Original query #29 | source line 295
CREATE TABLE pharma_clean LIKE pharma_raw;

-- Original query #30 | source line 297
INSERT INTO pharma_clean (
    Distributor,
    Customer_Name,
    City,
    Country,
    Latitude,
    Longitude,
    Chanals,
    Sub_Channal,
    Product_Name,
    Product_class,
    Quantity,
    Price,
    Sales,
    Month,
    Year_,
    Name_Of_Sales_Rep,
    Name_of_Manager,
    Sales_team
)
SELECT
    TRIM(Distributor),
    TRIM(Customer_Name),
    TRIM(City),
    TRIM(Country),
    Latitude,
    Longitude,
    TRIM(Chanals),
    TRIM(Sub_Channal),
    TRIM(Product_Name),
    TRIM(Product_class),
    Quantity,
    Price,
    Sales,
    TRIM(Month),
    Year_,
    TRIM(Name_Of_Sales_Rep),
    TRIM(Name_of_Manager),
    TRIM(Sales_team)
FROM pharma_raw;
