# SQL File Inventory

## Input archive inspected

- Archive: `pharma.analytics.zip`
- Files inside archive: **1**
- SQL file: `pharma.analytics.sql`
- Content: `SHOW VARIABLES LIKE 'local_infile'`; `SHOW VARIABLES LIKE 'secure_file_priv'`; `SELECT VERSION()`; `SET GLOBAL local_infile = 1`.

## Classification

All statements belong to MySQL environment/import setup. No DDL, cleaning, sales analysis, customer analysis, product analysis, distributor analysis, channel analysis, or anomaly-analysis query files were included in this archive.

## Action taken

The one received SQL script was placed at `sql/00_setup/00_mysql_environment_setup.sql`. The project folders for analysis have been prepared and documented in `sql/README.md`; they remain empty until the corresponding original SQL files are supplied.
